package io.nucleo.scheduler.tasks {

    public class DependencyManagedAsyncExampleTask1 extends ADependencyManagedTask {

        private var user:Object;

        public function DependencyManagedAsyncExampleTask1() {
        }

        override protected function initReadDependencies():void {
            user = read("user");
        }

        override public function run():void {
            super.run();

            trace("do something with user.userName = " + user.userName);

            complete();
        }


        override protected function destroy():void {
        }

    }
}
