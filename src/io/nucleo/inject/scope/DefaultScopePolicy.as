package io.nucleo.inject.scope {
    import flash.utils.getQualifiedClassName;

    import io.nucleo.inject.IConfigInfo;

    /**
     * The DefaultScopePolicy use the package name of the config class as the scope ID.
     */
    public class DefaultScopePolicy implements IScopePolicy {

        //--------------------------------------------------------------------------
        // IScopePolicy implementation
        //--------------------------------------------------------------------------

        /**
         * @inheritDoc
         */
        public function getScope(object:Object = null):String {
            return getQualifiedClassName(object).split("::")[0];
        }

    }
}
