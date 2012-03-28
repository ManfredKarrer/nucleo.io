package io.nucleo.scheduler.runnables {
    import flash.utils.getTimer;

    import io.nucleo.errors.AbstractMethodInvocationError;
    import io.nucleo.scheduler.tasks.ITask;

    import mx.logging.ILogger;

    /**
     * The base class for all runnable objects (tasks, schedulers)
     */
    public class ARunnable implements IRunnable {

        protected var observer:IRunnableObserver;
        protected var model:Object;
        protected var logger:ILogger;
        protected var logTasksOnly:Boolean;
        protected var isFailed:Boolean;
        protected var startTime:int;

        public function ARunnable() {
        }

        // -------------------------------------------------------------------
        // IRunnable implementation
        // -------------------------------------------------------------------

        /**
         * @inheritDoc
         */
        public function run():void {
            startTime = getTimer();
            if (logger && (!logTasksOnly || this is ITask)) {
                logger.debug("Run: " + this);
            }
        }

        /**
         * @inheritDoc
         */
        public function setObserver(observer:IRunnableObserver):void {
            this.observer = observer;
        }

        /**
         * @inheritDoc
         */
        public function setModel(model:Object):void {
            this.model = model;
        }

        /**
         * @inheritDoc
         */
        public function setLogger(logger:ILogger,
                                  logTasksOnly:Boolean = true):void {
            this.logger = logger;
            this.logTasksOnly = logTasksOnly;
        }


        // -------------------------------------------------------------------
        // Abstract Methods
        // -------------------------------------------------------------------

        /**
         * To be used by sub classes for cleanup.
         */
        protected function destroy():void {
            throw new AbstractMethodInvocationError(this, "destroy");
        }


        // -------------------------------------------------------------------
        // Final protected
        // -------------------------------------------------------------------

        final protected function complete():void {
            if (logger && (!logTasksOnly || this is ITask)) {
                logger.error("Completed: " + this + " / duration: " + (getTimer() - startTime));
            }
            if (observer) {
                observer.onRunnableComplete();
            }

            destroy();
            scheduler_internal::destroy();
        }

        final protected function failed(fault:Object):void {
            isFailed = true;
            if (logger && (!logTasksOnly || this is ITask)) {
                logger.error("Failed: " + this);
            }
            if (observer) {
                observer.onRunnableFault(new RunnableFault("", fault));
            }

            destroy();
            scheduler_internal::destroy();
        }


        // -------------------------------------------------------------------
        // scheduler_internal
        // -------------------------------------------------------------------

        scheduler_internal function destroy():void {
            model = null;
            observer = null;
            logger = null;
        }

    }
}
