package io.nucleo.inject {

import io.nucleo.inject.scope.IScopePolicy;

    /**
     *
     * @param config       The config to be used.
     * @param scopePolicy   Optional scope policy. If not set the DefaultScopePolicy is used.
     * @return
     */
public function createInjector(config:IConfig, scopePolicy:IScopePolicy = null):IInjector {
    return Injector.createInjector(IConfigInfo(config), scopePolicy);
}

}
