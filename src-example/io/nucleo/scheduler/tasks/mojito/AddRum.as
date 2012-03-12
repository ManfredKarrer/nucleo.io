package io.nucleo.scheduler.tasks.mojito {
    import io.nucleo.scheduler.tasks.*;
    public class AddRum extends ADependencyManagedTask {
        private var rum:Object;

        public function AddRum() {
        }

        override protected function initReadDependencies():void {
            rum = read("rum");
        }

        override public function run():void {
            super.run();

            trace("Add " + rum.quantity + " of " + rum.ingredient + ".");

            complete();
        }


        override protected function destroy():void {
        }

    }
}
