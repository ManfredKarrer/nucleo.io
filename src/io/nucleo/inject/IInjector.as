package io.nucleo.inject {
public interface IInjector {
    /**
     *
     * @param mappingKey        The mapping key to get the associated object.
     * @return
     */
    function getObject(mappingKey:Object):*;

    /**
     * Cleanup all resources.
     */
    function destroy():void;
}
}
