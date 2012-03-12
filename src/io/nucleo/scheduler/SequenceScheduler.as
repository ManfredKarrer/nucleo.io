package io.nucleo.scheduler {
    import io.nucleo.scheduler.runnables.IRunnable;
    import io.nucleo.scheduler.runnables.scheduler_internal;
    import io.nucleo.scheduler.tasks.ADependencyManagedTask;

    /**
     * Executing all children (IRunnable instances) in a sequential order.
     * Start the next IRunnable instances after one IRunnable instances has completed.
     */
    public class SequenceScheduler extends AScheduler {

        public function SequenceScheduler() {
        }


        // -------------------------------------------------------------------
        // IRunnable implementation
        // -------------------------------------------------------------------
        override public function run():void {
            super.run();

            if (runnableElements) {
                runNext();
            }
            else {
                complete();
            }
        }


        // -------------------------------------------------------------------
        // IRunnableObserver implementation
        // -------------------------------------------------------------------

        override public function onRunnableComplete():void {
            runNext();
        }


        // -------------------------------------------------------------------
        // Private
        // -------------------------------------------------------------------

        private function runNext():void {
            if (runnableElements.length > 0 && !isFailed) {
                var runnable:IRunnable = IRunnable(runnableElements.shift());

                if (runnable is ADependencyManagedTask) {
                    var dependencyManagedTask:ADependencyManagedTask = ADependencyManagedTask(runnable);
                    dependencyManagedTask.setModel(model);
                    dependencyManagedTask.scheduler_internal::setup();
                } else {
                    runnable.setModel(model);
                }

                runnable.setObserver(this);
                runnable.setLogger(logger, logTasksOnly);
                runnable.run();
            } else {
                complete();
            }
        }


    }
}
