package io.nucleo.scheduler.tasks.mojito {
    import io.nucleo.scheduler.tasks.*;
    public class PlaceMintLeavesInBottomOfGlass extends ATask {

        public function PlaceMintLeavesInBottomOfGlass() {
        }

        override public function run():void {
            super.run();

            trace("Place Mint Leaves In Bottom Of Glass");

            complete();
        }


        override protected function destroy():void {
        }

    }
}
