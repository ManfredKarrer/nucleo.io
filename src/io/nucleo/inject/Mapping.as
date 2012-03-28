package io.nucleo.inject {

    public final class Mapping implements IMapping, IMappingInfo {

        private var _instance:Object;
        private var _classDefinition:Class;
        private var _provider:Class;
        private var _factoryMethod:Function;
        private var _onDemandFactory:Class;
        private var policy:CreationPolicy;

        //--------------------------------------------------------------------------
        // Constructor
        //--------------------------------------------------------------------------

        /**
         * @private
         */
        public function Mapping() {
        }


        //--------------------------------------------------------------------------
        // IMapping implementation
        //--------------------------------------------------------------------------

        /**
         * @inheritDoc
         */
        public function toInstance(instance:Object):void {
            _instance = instance;
        }

        /**
         * @inheritDoc
         */
        public function toClass(classDefinition:Class):CreationPolicy {
            _classDefinition = classDefinition;
            return setCreationPolicy();
        }

        /**
         * @inheritDoc
         */
        public function toProvider(providerClass:Class):CreationPolicy {
            _provider = providerClass;
            return setCreationPolicy();
        }

        /**
         * @inheritDoc
         */
        public function toFactoryMethod(factoryMethod:Function):CreationPolicy {
            _factoryMethod = factoryMethod;
            return setCreationPolicy();
        }

        /**
         * @inheritDoc
         */
        public function toOnDemandFactory(onDemandFactory:Class):CreationPolicy {
            _onDemandFactory = onDemandFactory;
            return setCreationPolicy();
        }


        //--------------------------------------------------------------------------
        // IMappingInfo implementation
        //--------------------------------------------------------------------------

        /**
         * @private
         */
        public function get isSingleton():Boolean {
            if (policy) {
                return policy.isSingleton;
            }
            else {
                return false;
            }
        }

        /**
         * @private
         */
        public function get instance():Object {
            return _instance;
        }

        /**
         * @private
         */
        public function get classDefinition():Class {
            return _classDefinition;
        }

        /**
         * @private
         */
        public function get provider():Class {
            return _provider;
        }

        /**
         * @private
         */
        public function get factoryMethod():Function {
            return _factoryMethod;
        }

        /**
         * @private
         */
        public function get onDemandFactory():Class {
            return _onDemandFactory;
        }

        /**
         * @private
         */
        public function cacheInstance(instance:Object):void {
            _instance = instance;
        }


        //--------------------------------------------------------------------------
        // Private Methods
        //--------------------------------------------------------------------------

        private function setCreationPolicy():CreationPolicy {
            policy = new CreationPolicy();
            return policy;
        }

    }
}
