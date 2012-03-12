package io.nucleo.scheduler.tasks.mojito {
    import io.nucleo.scheduler.tasks.*;
    public class AddSugar extends ADependencyManagedTask {
        private var sugar:Object;

        public function AddSugar() {
        }


        override protected function initReadDependencies():void {
            sugar = read("sugar");
        }

        override public function run():void {
            super.run();

            trace("Add " + sugar.quantity + " " + sugar.ingredient + ".");

            complete();
        }


        override protected function destroy():void {
        }

    }
}
