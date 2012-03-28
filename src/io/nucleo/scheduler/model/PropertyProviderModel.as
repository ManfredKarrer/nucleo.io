package io.nucleo.scheduler.model {
    import flash.utils.Dictionary;

    /**
     * The data model to store objects needed to be shared between tasks and the client.
     * It is using a style inspired by dependency injection frameworks like Google Guice.
     * You can use an Interface, Class or a string as key for reading or writing an object.
     */
    public class PropertyProviderModel implements IPropertyProviderModel {

        private var data:Dictionary;
        private var registeredPropertiesMap:Dictionary;

        public function PropertyProviderModel() {
            data = new Dictionary();
            registeredPropertiesMap = new Dictionary();

            // register properties which are available at startup
            // typically done directly in the constructor so the constructor parameters can be used
            // directly to be written to the data dictionary.

            // registerObject("flashVars", flashVars);

            registerKeys();
        }

        // -------------------------------------------------------------------
        // IPropertyProviderModel implementation
        // -------------------------------------------------------------------

        /**
         * @inheritDoc
         */
        public function write(key:Object,
                              value:Object):void {
            data[key] = value;

            if (registeredPropertiesMap[key] == undefined) {
                handleMissingPropertyRegistrationWarning(key);
            }
        }

        /**
         * @inheritDoc
         */
        public function read(key:Object):* {
            if (registeredPropertiesMap[key] == undefined) {
                handleMissingPropertyRegistrationWarning(key);
            }

            return data[key];
        }

        /**
         * @private
         */
        public function areAllDependenciesAvailable(readDependencyKeys:Array):Boolean {
            for (var i:int = 0; i < readDependencyKeys.length; i++) {
                var key:Object = readDependencyKeys[i];
                if (data[key] == undefined) {
                    return false;
                }
            }
            return true;
        }


        // -------------------------------------------------------------------
        // Protected
        // -------------------------------------------------------------------

        /**
         * To be overwritten in subclass.
         * Register all property keys which are not available at startup.
         * These property keys will be used for writing into the data dictionary from any task during the
         * execution process.
         * This is next to the constructor the central place where all available properties are visible.
         */
        protected function registerKeys():void {
            // We define a key IUser and "channel" which will be used later from any task for writing a user
            // object with this key.
            //registerKey(IUser);
            //registerKey("channel");
        }

        /**
         * The handling of a missing key registration can be overwritten if another handling is preferred.
         * @param key
         */
        protected function handleMissingPropertyRegistrationWarning(key:Object):void {
            throw new Error("Registration for key " + key + " missing!");
        }

        /**
         * @param key
         * @param value
         */
        final protected function registerObject(key:Object,
                                                value:Object):void {
            data[key] = value;
            registerKey(key);
        }

        /**
         * @param key
         */
        final protected function registerKey(key:Object):void {
            registeredPropertiesMap[key] = true;
        }


    }
}
