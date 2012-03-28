package io.nucleo.inject {
public interface IMapping {

    /**
     *
     * @param instance      Target instance of mapping.
     */
    function toInstance(instance:Object):void;

    /**
     *
     * @param classDefinition   Class definition used for creating the target object.
     * @return
     */
    function toClass(classDefinition:Class):CreationPolicy;

    /**
     *
     * @param providerClass     Provider class of type IProvider to be used for custom object construction.
     *                          Is needed for 3rd party Classes or for more complex construction setup.
     * @return
     */
    function toProvider(providerClass:Class):CreationPolicy;

    /**
     *
     * @param factoryMethod     Factory method used for custom object construction. Similar to the solution with
     *                          IProvider but there is no extra class used, only a method in the config for the
     *                          construction of the object.
     * @return
     */
    function toFactoryMethod(factoryMethod:Function):CreationPolicy;

    /**
     *
     * @param onDemandFactory       On demand factory of type IOnDemandFactory used for on demand object construction.
     *                              You can inject this factory and the actual object creation will be triggered when
     *                              the getObject() method is called.
     * @return
     */
    function toOnDemandFactory(onDemandFactory:Class):CreationPolicy;
}
}
