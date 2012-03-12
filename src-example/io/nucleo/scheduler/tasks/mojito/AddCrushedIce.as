package io.nucleo.scheduler.tasks.mojito {
    import io.nucleo.scheduler.tasks.*;
    public class AddCrushedIce extends ADependencyManagedTask {
        private var crushedIce:Object;

        public function AddCrushedIce() {
        }


        override protected function initReadDependencies():void {
            crushedIce = read("crushedIce");
        }

        override public function run():void {
            super.run();

            trace("Add " + crushedIce.state + " " + crushedIce.ingredient + ".");

            complete();
        }


        override protected function destroy():void {
        }

    }
}
