package io.nucleo.inject {
    import flash.utils.Dictionary;

    import io.nucleo.inject.scope.DefaultScopePolicy;
    import io.nucleo.inject.scope.IScopePolicy;
    import io.nucleo.utils.ClassUtil;

    public final class Injector implements IInjector {

        //--------------------------------------------------------------------------
        // Static Variables
        //--------------------------------------------------------------------------

        private static const scopedInjectors:Object = {};
        private static var scopePolicy:IScopePolicy;
        private static var singletonPrivatePin:Number = Math.random();


        //--------------------------------------------------------------------------
        // Static Methods
        //--------------------------------------------------------------------------

        /**
         * This method is only used via the createInjector package level function.
         *
         * @private
         */
        internal static function createInjector(config:IConfigInfo,
                                                scopePolicy:IScopePolicy = null):IInjector {
            if (!scopePolicy) {
                Injector.scopePolicy = new DefaultScopePolicy();
            }
            else {
                Injector.scopePolicy = scopePolicy;
            }

            var scope:String = Injector.scopePolicy.getScope(config);

            if (scopedInjectors[scope] != undefined) {
                throw new Error("Config " + config + " in scope: " + scope + " is already defined.");
            }

            var scopedInjector:Injector = new Injector(config, singletonPrivatePin);
            scopedInjectors[scope] = scopedInjector;

            return scopedInjector;
        }


        //--------------------------------------------------------------------------
        // Variables
        //--------------------------------------------------------------------------

        private var config:IConfigInfo;
        private var circularDependencies:Dictionary;


        //--------------------------------------------------------------------------
        // Constructor
        //--------------------------------------------------------------------------

        /**
         * @private
         */
        public function Injector(config:IConfigInfo,
                                 singletonProtectionPin:Number) {
            if (singletonProtectionPin != singletonPrivatePin) {
                throw new Error("Injector may only be created using: Injector.createInjector(config).");
            }

            circularDependencies = new Dictionary();
            this.config = config;
        }


        //--------------------------------------------------------------------------
        // IInjector implementation
        //--------------------------------------------------------------------------

        /**
         * @inheritDoc
         */
        public function getObject(mappingKey:Object):* {
            if (circularDependencies[mappingKey]) {
                var keys:String = "";
                for (var i:String in circularDependencies) {
                    keys += i + ", ";
                }
                throw new Error("Error: Detected a circular dependency with key: " + mappingKey + ". These keys are in the stacktrace: " + keys);
            }

            var mapping:IMappingInfo = config.getMapping(mappingKey);
            if (!mapping) {
                throw new Error("Error: No Mapping found with key: " + mappingKey);
            }

            circularDependencies[mappingKey] = true;

            var instance:Object;
            if (mapping.instance) {
                instance = mapping.instance;
            } else if (mapping.classDefinition) {
                instance = injectByClassDefinition(mapping, mapping.classDefinition);
            } else if (mapping.provider) {
                var provider:IProvider = IProvider(injectByClassDefinition(mapping, mapping.provider));
                instance = provider.getObject();
            } else if (mapping.factoryMethod != null) {
                instance = mapping.factoryMethod();
            } else if (mapping.onDemandFactory) {
                instance = IOnDemandFactory(injectByClassDefinition(mapping, mapping.onDemandFactory));
            }

            delete circularDependencies[mappingKey];

            return instance;
        }

        /**
         * @inheritDoc
         */
        public function destroy():void {
            circularDependencies = null;
            config.destroy();
            config = null;

        }


        //--------------------------------------------------------------------------
        // Private Methods
        //--------------------------------------------------------------------------

        private function injectByClassDefinition(mapping:IMappingInfo,
                                                 classDefinition:Class):Object {
            var constructorParameters:Array = config.getConstructorParameters(classDefinition);

            var arguments:Array = [];
            for (var i:int = 0; i < constructorParameters.length; i++) {
                var mappingKey:Object = constructorParameters[i];
                arguments.push(getObject(mappingKey));
            }

            var instance:Object = ClassUtil.createInstance(classDefinition, arguments);

            if (mapping.isSingleton) {
                mapping.cacheInstance(instance);
            }

            return instance;
        }

    }
}