package io.nucleo.inject.mojito {
    import io.nucleo.inject.*;
    import io.nucleo.inject.mojito.domain.Client;
    import io.nucleo.inject.mojito.domain.IBar;
    import io.nucleo.inject.mojito.domain.IThirstyClient;
    import io.nucleo.inject.mojito.domain.IWaitress;
    import io.nucleo.inject.mojito.domain.Bar;
    import io.nucleo.inject.mojito.domain.Waitress;

    import mx.resources.IResourceManager;
    import mx.rpc.remoting.RemoteObject;

    public class MojitoConfig extends AConfig {

    public function MojitoConfig() {
        super(new ConstructorParameters());
    }

    override protected function setup():void {
        mapClass(Client).toClass(Client).asSingleton();
        mapParameterName("theFewSpanishWords").toInstance("¡Muchas gracias guapa!");
        mapInterface(IBar).toProvider(BarProvider).asSingleton();
        mapInterface(IWaitress).toClass(Waitress).asSingleton();
        mapParameterName("isInTheMood").toInstance(true);
    }
}
}
