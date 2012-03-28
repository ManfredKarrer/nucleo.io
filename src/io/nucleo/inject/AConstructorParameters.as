package io.nucleo.inject {
import flash.utils.Dictionary;

public class AConstructorParameters {

    /**
     * The dictionary used to store the constructor parameter keys for a class.<br>
     * The key of the dictionary is the class for which we store the constructor parameters.<br>
     * The value is an array of constructor parameter keys.
     */
    protected var constructorParameterKeys:Dictionary;

    //--------------------------------------------------------------------------
    // Constructor
    //--------------------------------------------------------------------------

    public function AConstructorParameters() {
        constructorParameterKeys = new Dictionary();
        config();
    }

    /**
     * This will be overwritten by the concrete class (auto generated).<br>
     * For example: <code>constructorParameterKeys[Client] = ["theFewSpanishWords", IBar];</code>
     */
    protected function config():void {
    }

    /**
     * @private
     */
    internal function getConstructorParameters(classDefinition:Class):Array {
        return constructorParameterKeys[classDefinition];
    }

    /**
     * @private
     */
    internal function destroy():void {
        constructorParameterKeys = null;
    }

}
}
