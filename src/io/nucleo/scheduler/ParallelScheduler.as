package io.nucleo.scheduler {
    import io.nucleo.scheduler.runnables.IRunnable;
    import io.nucleo.scheduler.runnables.scheduler_internal;
    import io.nucleo.scheduler.tasks.ADependencyManagedTask;

    /**
     * Start executing all children (IRunnable instances) at once without waiting for any complete callback.
     */
    public class ParallelScheduler extends AScheduler {

        protected var numOfChildrenCompleted:uint;

        public function ParallelScheduler() {
        }


        // -------------------------------------------------------------------
        // IRunnable implementation
        // -------------------------------------------------------------------

        override public function run():void {
            super.run();

            if (runnableElements) {
                numOfChildrenCompleted = runnableElements.length;
                for (var i:int = 0; runnableElements && i < runnableElements.length; i++) {
                    var runnable:IRunnable = IRunnable(runnableElements[i]);
                    runnableElements.shift();
                    i--;

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
                }
            } else {
                complete();
            }
        }

        // -------------------------------------------------------------------
        // IRunnableObserver implementation
        // -------------------------------------------------------------------

        override public function onRunnableComplete():void {
            numOfChildrenCompleted--;
            if (numOfChildrenCompleted == 0) {
                super.complete();
            }
        }

    }
}
