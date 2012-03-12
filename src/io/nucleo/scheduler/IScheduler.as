package io.nucleo.scheduler {
    import io.nucleo.scheduler.runnables.IRunnable;

    public interface IScheduler extends IRunnable {

        /**
         * @return
         */
        function get runnableElements():Array;

        /**
         *
         * @param value
         */
        function set runnableElements(value:Array):void;
    }
}
