package io.nucleo.scheduler.model {

    /**
     * The base interface for all models using the dependency management with the read/write methods.
     */
    public interface IPropertyProviderModel {

        /**
         *
         * @param key       The key to be used for the given value. Can be of any type. Typically an interface, class
         *                  or string.
         * @param value     The value to be stored.
         */
        function write(key:Object,
                       value:Object):void;

        /**
         * This method is used to define the read dependencies (the model data objects needed for a certain
         * task to be able to run)
         *
         * @param key       The key which was used for writing an object to the data dictionary.
         * @return          The value object stored with the associated key.
         */
        function read(key:Object):*;


        /**
         *
         * @param readDependencyKeys    The array of keys for dependent model data objects needed for a certain task
         *                              to be able to run.
         * @return                      True if all the data objects are already written and available.
         */
        function areAllDependenciesAvailable(readDependencyKeys:Array):Boolean;
    }
}
