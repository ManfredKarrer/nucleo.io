package io.nucleo.scheduler.tasks.mojito {
    import io.nucleo.scheduler.tasks.*;
    public class GarnishWithMintLeaves extends ADependencyManagedTask {
        private var mintLeaves:Object;

        public function GarnishWithMintLeaves() {
        }


        override protected function initReadDependencies():void {
            mintLeaves = read("mintLeaves");
        }

        override public function run():void {
            super.run();

            trace("Garnish with " + mintLeaves.quantity + " " + mintLeaves.ingredient + ".");

            complete();
        }


        override protected function destroy():void {
        }

    }
}
