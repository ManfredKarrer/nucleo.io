package io.nucleo.inject {
    /**
     * IMappingInfo is only used internally.
     */
    public interface IMappingInfo {
        /**
         * @private
         */
        function get isSingleton():Boolean;

        /**
         * @private
         */
        function get instance():Object;
        /**
         * @private
         */
        function get classDefinition():Class;
        /**
         * @private
         */
        function get provider():Class;
        /**
         * @private
         */
        function get factoryMethod():Function;
        /**
         * @private
         */
        function get onDemandFactory():Class;
        /**
         * @private
         */
        function cacheInstance(instance:Object):void;
    }
}
