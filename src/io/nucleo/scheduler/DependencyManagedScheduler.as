package io.nucleo.scheduler {
    import io.nucleo.scheduler.runnables.scheduler_internal;
    import io.nucleo.scheduler.tasks.ADependencyManagedTask;

    public class DependencyManagedScheduler extends AScheduler {

        private var numOfChildrenCompleted:uint;

        public function DependencyManagedScheduler() {
        }


        // -------------------------------------------------------------------
        // IRunnable implementation
        // -------------------------------------------------------------------

        override public function run():void {
            if (runnableElements) {
                numOfChildrenCompleted = runnableElements.length;
                runNext();
            } else {
                complete();
            }
        }


        // -------------------------------------------------------------------
        // IRunnableObserver implementation
        // -------------------------------------------------------------------

        override public function onRunnableComplete():void {
            if (!isFailed) {
                numOfChildrenCompleted--;
                if (numOfChildrenCompleted == 0) {
                    complete();
                } else {
                    runNext();
                }
            }
        }


        // -------------------------------------------------------------------
        // Private
        // -------------------------------------------------------------------

        private function runNext():void {
            for (var i:int = 0; runnableElements && i < runnableElements.length; i++) {

                var dependencyManagedTask:ADependencyManagedTask = ADependencyManagedTask(runnableElements[i]);
                dependencyManagedTask.setModel(model);
                dependencyManagedTask.scheduler_internal::setup();

                if (dependencyManagedTask.scheduler_internal::areAllDependenciesAvailable()) {
                    runnableElements.splice(i, 1)
                    i--;

                    dependencyManagedTask.setObserver(this);
                    dependencyManagedTask.setLogger(logger, logTasksOnly);
                    dependencyManagedTask.run();
                }
            }
        }

    }
}
