package io.nucleo.inject {

public interface IConfig {

    /**
     *
     * @param interfaceDefinition   The Interface definition used as mapping key.
     * @return
     */
    function mapInterface(interfaceDefinition:Class):IMapping;

    /**
     *
     * @param classDefinition      The Class definition used as mapping key.
     * @return
     */
    function mapClass(classDefinition:Class):IMapping;

    /**
     *
     * @param parameterName      The parameter name used as mapping key.
     * @return
     */
    function mapParameterName(parameterName:String):IMapping;

}
}
