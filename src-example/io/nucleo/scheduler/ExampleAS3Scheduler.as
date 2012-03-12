package io.nucleo.scheduler {
    import io.nucleo.scheduler.tasks.boring_test.*;

    public class ExampleAS3Scheduler extends SequenceScheduler {

        public function ExampleAS3Scheduler() {
            // Build up the structure from inside to outside...
            // The MXML version is much better readable and has nearly no overhead from the generated code.
            // So it is not recommended to use this version for complex schedulers.

            var sequenceScheduler4:SequenceScheduler = new SequenceScheduler();
            sequenceScheduler4.runnableElements = [   new AsyncExampleTask1(), new AsyncExampleTask2()];

            var sequenceScheduler3:SequenceScheduler = new SequenceScheduler();
            sequenceScheduler3.runnableElements = [  new AsyncExampleTask2(), new AsyncExampleTask1()];

            var parallelScheduler1:ParallelScheduler = new ParallelScheduler();
            parallelScheduler1.runnableElements = [ new AsyncExampleTask1(), new AsyncExampleTask2(), sequenceScheduler4];

            var sequenceScheduler2:SequenceScheduler = new SequenceScheduler();
            sequenceScheduler2.runnableElements = [ parallelScheduler1, new ExampleTask1(), sequenceScheduler3, new AsyncExampleTask1()];

            var dependencyManagedScheduler1:DependencyManagedScheduler = new DependencyManagedScheduler();
            dependencyManagedScheduler1.runnableElements = [new DependencyManagedAsyncExampleTask1(), new DependencyManagedAsyncExampleTask2()]

            var sequenceScheduler1:SequenceScheduler = new SequenceScheduler();
            sequenceScheduler1.runnableElements = [ dependencyManagedScheduler1, new AsyncExampleTask1()];

            runnableElements = [sequenceScheduler1, new ExampleTask1(), sequenceScheduler2];
        }

    }
}
