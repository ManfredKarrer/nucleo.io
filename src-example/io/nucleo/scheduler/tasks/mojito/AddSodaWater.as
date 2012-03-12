package io.nucleo.scheduler.tasks.mojito {
    import io.nucleo.scheduler.tasks.*;
    public class AddSodaWater extends ADependencyManagedTask {
        private var sodaWater:Object;

        public function AddSodaWater() {
        }


        override protected function initReadDependencies():void {
            sodaWater = read("sodaWater");
        }

        override public function run():void {
            super.run();

            trace("Add " + sodaWater.quantity + " " + sodaWater.ingredient + ".");

            complete();
        }

        override protected function destroy():void {
        }

    }
}
