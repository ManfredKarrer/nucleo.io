package io.nucleo.inject.mojito.domain {
    public class Bar implements IBar {
        private var _waitress:IWaitress;

        public function Bar(waitress:IWaitress) {
            this._waitress = waitress;
        }
		
		public function open():void {
			// just demo...
		}
		
        public function getMojito(client:IThirstyClient):void {
			_waitress.makeMojito(client);
        }

        public function get waitress():IWaitress {
            return _waitress;
        }
    }
}
