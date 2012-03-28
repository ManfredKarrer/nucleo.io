package io.nucleo.inject.mojito.domain {

    public class Client implements IThirstyClient, IChico {
        private var bar:IBar;
        private var theFewSpanishWords:String;

        public function Client(theFewSpanishWords:String,
                               bar:IBar) {
            this.theFewSpanishWords = theFewSpanishWords;
            this.bar = bar;
        }


        // -------------------------------------------------------------------
        // IThirstyClient role
        // -------------------------------------------------------------------

        public function orderMojito():void {
            trace("Client: order Mojito")
            bar.getMojito(this)
        }

        public function onDeliverMojito(mojito:Mojito):void {
            trace("Client: "+theFewSpanishWords)
            bar.waitress.flirt(this, theFewSpanishWords);
        }


        // -------------------------------------------------------------------
        // IChico role
        // -------------------------------------------------------------------

        public function onReaction(reaction:String):void {
            trace("Client: :-)");
        }
    }
}
