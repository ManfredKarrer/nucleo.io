package io.nucleo.scheduler.tasks.mojito {
    import io.nucleo.scheduler.tasks.*;
    public class AddLimeJuice extends ADependencyManagedTask {
        private var limeJuice:Object;

        public function AddLimeJuice() {
        }

        override protected function initReadDependencies():void {
            limeJuice = read("limeJuice");
        }

        override public function run():void {
            super.run();

            trace("Add " + limeJuice.quantity + " " + limeJuice.ingredient + ".");

            complete();
        }

        override protected function destroy():void {
        }

    }
}
