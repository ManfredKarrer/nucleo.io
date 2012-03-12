package io.nucleo.scheduler {
    import io.nucleo.scheduler.runnables.ARunnable;
    import io.nucleo.scheduler.runnables.IRunnableObserver;
    import io.nucleo.scheduler.runnables.RunnableFault;

    [DefaultProperty("runnableElements")]
    public class AScheduler extends ARunnable implements IScheduler, IRunnableObserver {

        [ArrayElementType("io.nucleo.scheduler.runnables.IRunnable")]
        private var _runnableElements:Array;

        public function AScheduler() {
            super();
        }

        // -------------------------------------------------------------------
        // IScheduler implementation
        // -------------------------------------------------------------------

        public function get runnableElements():Array {
            return _runnableElements;
        }

        public function set runnableElements(value:Array):void {
            _runnableElements = value;
        }


        // -------------------------------------------------------------------
        // IRunnableObserver implementation
        // -------------------------------------------------------------------

        public function onRunnableComplete():void {
            observer.onRunnableComplete();
        }

        public function onRunnableFault(runnableFault:RunnableFault):void {
            observer.onRunnableFault(runnableFault);
        }


        // -------------------------------------------------------------------
        // Protected Methods
        // -------------------------------------------------------------------

        override protected function destroy():void {
            _runnableElements = null;
        }
    }
}
