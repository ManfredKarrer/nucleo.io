package io.nucleo.scheduler.tasks.mojito {
    import io.nucleo.scheduler.tasks.*;
    import flash.utils.setTimeout;

    public class PrePareCrushedIce extends ADependencyManagedTask {

        private var ice:Object;

        public function PrePareCrushedIce() {
        }

        override protected function initReadDependencies():void {
            ice = read("ice");
        }

        override public function run():void {
            super.run();

            trace("Prepare crushed ice, that takes a while...");

            setTimeout(onCrushedComplete, 100)
        }

        private function onCrushedComplete():void {
            trace("Crushed ice is done");

            var crushedIce:Object = {ingredient: ice.ingredient,  state:"crushed" }
            write("crushedIce", crushedIce);

            complete();
        }


        override protected function destroy():void {
        }

    }
}
