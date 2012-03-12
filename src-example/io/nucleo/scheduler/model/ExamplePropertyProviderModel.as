package io.nucleo.scheduler.model {
    public class ExamplePropertyProviderModel extends PropertyProviderModel {
        public function ExamplePropertyProviderModel(flashVars:Object) {
            super();

            // register properties which are available at startup
            registerObject("flashVars", flashVars);
        }


        override protected function registerKeys():void {
            // register properties which will be written by a task and not available at startup
            registerKey("user");
        }
    }
}