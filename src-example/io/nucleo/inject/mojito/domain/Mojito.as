package io.nucleo.inject.mojito.domain {
    import io.nucleo.scheduler.PrepareMojitoScheduler;
    import io.nucleo.scheduler.model.MojitoModel;
    import io.nucleo.scheduler.runnables.IRunnableObserver;
    import io.nucleo.scheduler.runnables.RunnableFault;

    public class Mojito implements IRunnableObserver{
        private var mixer:IMixer;

        public function Mojito(mixer:IMixer) {
            this.mixer = mixer;

            var ice:Object = {ingredient:"ice", state:"solid" }
            var rum:Object = {ingredient:"rum", quantity:"1.25 oz"  }
            var mintLeaves:Object = {ingredient:"mint leaves", quantity:"12" }
            var sugar:Object = {ingredient:"sugar", quantity:"1.25 oz"  };
            var limeJuice:Object = {ingredient:"lime juice", quantity:"0.5 oz" }
            var sodaWater:Object = {ingredient:"sodaWater", quantity:"2 oz"  }
            var ingredients:Object = new MojitoModel(ice, rum, mintLeaves, sugar, limeJuice, sodaWater);

            var prepareMojitoScheduler:PrepareMojitoScheduler = new PrepareMojitoScheduler();
            prepareMojitoScheduler.setModel(ingredients);
            //prepareMojitoScheduler.setLogger(Log.getLogger("testLogger"));
            prepareMojitoScheduler.setObserver(this);
            prepareMojitoScheduler.run();
        }

        public function onRunnableComplete():void {
            trace("Mojito ready to serve");
            mixer.mojitoDone();
        }

        public function onRunnableFault(runnableFault:RunnableFault):void {
            trace("damn");
        }

    }
}
