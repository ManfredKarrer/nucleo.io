package io.nucleo.scheduler.tasks {
    import flash.utils.setTimeout;

    public class DependencyManagedAsyncExampleTask2 extends ADependencyManagedTask {
        private var flashVars:Object;

        public function DependencyManagedAsyncExampleTask2() {
        }

        override protected function initReadDependencies():void {
            flashVars = read("flashVars");
        }

        override public function run():void {
            super.run();

            trace("start some async work...");

            setTimeout(asyncCallback, 100)
        }

        private function asyncCallback():void {
            trace("async work done. lets write the user object.");

            var user:Object = {userName:flashVars.userName, sessionID:"1234"}
            write("user", user);

            complete();
        }


        override protected function destroy():void {
        }

    }
}
