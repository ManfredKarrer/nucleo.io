package io.nucleo.scheduler.runnables {
    import mx.logging.ILogger;

    /**
     * The base interface for all runnable objects (tasks, schedulers)
     */
    public interface IRunnable {

        /**
         * Starts the execution.
         */
        function run():void;

        /**
         *
         * @param observer          The IRunnableObserver instance getting notified on complete and fault.
         */
        function setObserver(scheduler:IRunnableObserver):void;

        /**
         *
         * @param model             The model used as shared data storage between the tasks.
         */
        function setModel(model:Object):void;

        /**
         *
         * @param logger            The logger used for debug and error messages.
         * @param logTasksOnly      If true (default) only the tasks (implementing ITask) are used for logging, not the
         *                          schedulers.
         */
        function setLogger(logger:ILogger,
                           logTasksOnly:Boolean = true):void;

    }
}
