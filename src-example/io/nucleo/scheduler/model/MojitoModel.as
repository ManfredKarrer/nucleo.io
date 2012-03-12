package io.nucleo.scheduler.model {
    public class MojitoModel extends PropertyProviderModel {
        public function MojitoModel(ice:Object,
                                    rum:Object,
                                    mintLeaves:Object,
                                    sugar:Object,
                                    limeJuice:Object,
                                    sodaWater:Object) {
            super();

            // register properties which are available at startup
            registerObject("ice", ice);
            registerObject("rum", rum);
            registerObject("mintLeaves", mintLeaves);
            registerObject("sugar", sugar);
            registerObject("limeJuice", limeJuice);
            registerObject("sodaWater", sodaWater);
        }


        override protected function registerKeys():void {
            // register properties which will be written by a task and not available at startup
            registerKey("crushedIce");
        }
    }
}