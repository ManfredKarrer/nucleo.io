package io.nucleo.scheduler.tasks.boring_test {
    import io.nucleo.scheduler.tasks.*;
    import flash.utils.setTimeout;

    public class AsyncExampleTask2 extends ATask {

        public function AsyncExampleTask2() {
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
