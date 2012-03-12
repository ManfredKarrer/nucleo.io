package io.nucleo.scheduler.tasks.boring_test {
    import io.nucleo.scheduler.tasks.*;
    public class ExampleTask1 extends ATask {

        public function ExampleTask1() {
        }

        override public function run():void {
            super.run();

            trace("do something...");

            complete();
        }


        override protected function destroy():void {
        }

    }
}
