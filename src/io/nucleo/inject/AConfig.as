package io.nucleo.inject {

    import flash.utils.Dictionary;

    import io.nucleo.errors.AbstractMethodInvocationError;

    public class AConfig implements IConfig, IConfigInfo {

        private var mappings:Dictionary;
        private var constructorParameters:AConstructorParameters;


        //--------------------------------------------------------------------------
        // Constructor
        //--------------------------------------------------------------------------

        /**
         *
         * @param constructorParameters     The concrete ConstructorParameters class.
         */
        public function AConfig(constructorParameters:AConstructorParameters) {
            this.constructorParameters = constructorParameters;

            mappings = new Dictionary();

            setup();
        }


        //--------------------------------------------------------------------------
        // IConfig implementation
        //--------------------------------------------------------------------------

        /**
         * @inheritDoc
         */
        final public function mapInterface(interfaceDefinition:Class):IMapping {
            return map(interfaceDefinition);
        }

        /**
         * @inheritDoc
         */
        final public function mapClass(classDefinition:Class):IMapping {
            return map(classDefinition);
        }

        /**
         * @inheritDoc
         */
        final public function mapParameterName(parameterName:String):IMapping {
            return map(parameterName);
        }


        //--------------------------------------------------------------------------
        // IConfigInfo implementation
        //--------------------------------------------------------------------------

        /**
         * @private
         */
        final public function getMapping(key:Object):IMappingInfo {
            return IMappingInfo(mappings[key]);
        }

        /**
         * @private
         */
        final public function getConstructorParameters(classDefinition:Class):Array {
            return constructorParameters.getConstructorParameters(classDefinition);
        }

        /**
         * @private
         */
        public function destroy():void {
            mappings = null;
            constructorParameters.destroy();
            constructorParameters = null;
        }


        // -------------------------------------------------------------------
        // Abstract Methods
        // -------------------------------------------------------------------

        /**
         * To be used by sub classes to define the mappings
         */
        protected function setup():void {
            throw new AbstractMethodInvocationError(this, "setup");
        }


        //--------------------------------------------------------------------------
        // Private Methods
        //--------------------------------------------------------------------------

        private function map(key:Object):IMapping {
            if (mappings[key] != undefined) {
                throw new Error("Mapping with key: " + key + " is already defined.");
            }

            var mapping:IMapping = new Mapping();
            mappings[key] = mapping;
            return mapping;
        }


    }
}
