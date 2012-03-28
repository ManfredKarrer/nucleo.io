package io.nucleo.inject.mojito.domain {

    public class Waitress implements IWaitress, IMixer {
        private var _isInTheMood:Boolean;
        private var mojito:Mojito;
        private var client:IThirstyClient;

        public function Waitress(isInTheMood:Boolean) {
            _isInTheMood = isInTheMood;
        }


        // -------------------------------------------------------------------
        // IWaitress role
        // -------------------------------------------------------------------

        public function makeMojito(client:IThirstyClient):void {
            this.client=client;
            trace("Waitress: make Mojito")
            mojito = new Mojito(this);
        }

        public function flirt(chico:IChico,
                              words:String):void {
            var reaction:String = (isInTheMood && like(chico)) ? kiss : "de nada...";
            trace("Waitress: " + reaction);
            chico.onReaction(reaction);
        }

        // -------------------------------------------------------------------
        // IMixer role
        // -------------------------------------------------------------------

        public function mojitoDone():void {
            client.onDeliverMojito(mojito);
        }


        // -------------------------------------------------------------------
        // Private
        // -------------------------------------------------------------------

        private function like(chico:IChico):Boolean {
            return (Math.random() > 0.3)
        }

        private function get kiss():* {
            return "Me gustas!";
        }

        private function get isInTheMood():Boolean {
            return _isInTheMood;
        }
    }
}
