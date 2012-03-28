package io.nucleo.inject.scope {

    public class GlobalScopePolicy implements IScopePolicy {

        //--------------------------------------------------------------------------
        // IScopePolicy implementation
        //--------------------------------------------------------------------------

        /**
         * @inheritDoc
         */
        public function getScope(object:Object = null):String {
            return "io.nucleo.inject.global";
        }

    }
}
