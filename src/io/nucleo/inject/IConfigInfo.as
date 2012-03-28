package io.nucleo.inject {

    /**
     * IConfigInfo is only used internally.
     */
    public interface IConfigInfo {
        /**
         * @private
         */
        function getMapping(key:Object):IMappingInfo;

        /**
         * @private
         */
        function getConstructorParameters(classDefinition:Class):Array;

        /**
         * @private
         */
        function destroy():void;
    }
}
