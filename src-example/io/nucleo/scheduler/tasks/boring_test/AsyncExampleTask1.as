package io.nucleo.scheduler.tasks.boring_test {
    import io.nucleo.scheduler.tasks.*;
    import flash.utils.setTimeout;

    public class AsyncExampleTask1 extends ATask {

        public function AsyncExampleTask1() {
        }

        override public function run():void {
            super.run();

            trace("start some async work...");

            setTimeout(asyncCallback, 100)
        }

        private function asyncCallback():void {
            trace("async work done...");

            complete();
        }


        override protected function destroy():void {
        }

    }
}
