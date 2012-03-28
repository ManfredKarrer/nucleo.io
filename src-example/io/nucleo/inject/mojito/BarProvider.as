package io.nucleo.inject.mojito
{
	import io.nucleo.inject.IProvider;
	import io.nucleo.inject.mojito.domain.Bar;
	import io.nucleo.inject.mojito.domain.IWaitress;

	public class BarProvider implements IProvider
	{
		
		public function BarProvider(waitress:IWaitress) {
			this.waitress = waitress;
		}
		
		private var bar:Bar;
		private var waitress:IWaitress;
		public function getObject():Object
		{
			bar = new Bar(waitress);
			bar.open();
			return bar;
		}
	}
}