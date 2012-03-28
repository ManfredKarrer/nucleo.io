package io.nucleo.inject.scope {
public interface IScopePolicy {

    /**
     *
     * @param object    An optional object to be passed for deriving the scope ID from it (e.g. package name)
     * @return          The ID of the scope.
     */
    function getScope(object:Object = null):String;
}
}
