package io.nucleo.inject {

public class CreationPolicy {

    private var _isSingleton:Boolean;


    //--------------------------------------------------------------------------
    // Constructor
    //--------------------------------------------------------------------------

    public function CreationPolicy() {
    }


    //--------------------------------------------------------------------------
    // Public Methods
    //--------------------------------------------------------------------------

    /**
     * If this fluent interface node is used the Injector takes care that only one instance for this mapping is created.
     * @return
     */
    public function asSingleton():CreationPolicy {
        this._isSingleton = true;
        return this;
    }


    //--------------------------------------------------------------------------
    // Internal Properties
    //--------------------------------------------------------------------------

    internal function get isSingleton():Boolean {
        return _isSingleton;
    }
}
}
