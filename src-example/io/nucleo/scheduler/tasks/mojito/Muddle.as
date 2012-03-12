package io.nucleo.scheduler.tasks.mojito {
    import io.nucleo.scheduler.tasks.*;
	import flash.utils.setTimeout;

    public class Muddle extends ATask {

        public function Muddle() {
        }

        override public function run():void {
            super.run();

            trace("Muddle, that takes a while...");

			setTimeout(onMuddleComplete, 100)
		}

		private function onMuddleComplete():void {
			trace("Muddled enough");

			complete();
		}

        override protected function destroy():void {
        }

    }
}
