package io.nucleo.scheduler.runnables {
    public interface IRunnableObserver {

        /**
         * Called when a IRunnable object is completed.
         */
        function onRunnableComplete():void;

        /**
         * Called when a IRunnable object has failed.
         * @param runnableFault
         */
        function onRunnableFault(runnableFault:RunnableFault):void;
    }
}
