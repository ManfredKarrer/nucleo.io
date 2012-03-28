package io.nucleo.inject.mojito {
	import io.nucleo.inject.mojito.*;
	import io.nucleo.inject.mojito.domain.IWaitress;
	import io.nucleo.inject.AConstructorParameters;
	import io.nucleo.inject.mojito.domain.*;
	public class ConstructorParameters extends AConstructorParameters {
		protected override function config():void {
			constructorParameterKeys[BarProvider] = [IWaitress];
			constructorParameterKeys[Bar] = [IWaitress];
			constructorParameterKeys[Client] = ["theFewSpanishWords", IBar];
			constructorParameterKeys[Waitress] = ["isInTheMood"];
		}
	}
}