package io.nucleo.scheduler.tasks {
    import io.nucleo.errors.AbstractMethodInvocationError;
    import io.nucleo.scheduler.model.IPropertyProviderModel;
    import io.nucleo.scheduler.runnables.scheduler_internal;

    use namespace scheduler_internal;

    /**
     * The base class for all tasks using a IPropertyProviderModel instance as a shared model.
     */
    public class ADependencyManagedTask extends ATask {

        private var propertyProviderModel:IPropertyProviderModel;
        private var readDependencyKeys:Array = [];

        public function ADependencyManagedTask() {
        }

        // -------------------------------------------------------------------
        // IRunnable implementation
        // -------------------------------------------------------------------

        /**
         * @inheritDoc
         */
        override public function setModel(model:Object):void {
            propertyProviderModel = IPropertyProviderModel(model);

            super.setModel(model);
        }


        // -------------------------------------------------------------------
        // Abstract Methods
        // -------------------------------------------------------------------

        /**
         * To be overwritten in subclasses
         * Used to read the needed data objects for the task.
         * Typically stored as instance variable in the task.
         */
        protected function initReadDependencies():void {
            // user = read(IUser);
            // channel = read("channel");
            throw new AbstractMethodInvocationError(this, "initReadDependencies");
        }


        // -------------------------------------------------------------------
        // Final protected
        // -------------------------------------------------------------------

        final protected function read(key:Object):* {
            readDependencyKeys.push(key);

            return propertyProviderModel.read(key);
        }

        final protected function write(key:Object,
                                       value:Object):void {
            propertyProviderModel.write(key, value);
        }


        // -------------------------------------------------------------------
        // scheduler_internal
        // -------------------------------------------------------------------

        scheduler_internal function areAllDependenciesAvailable():Boolean {
            return propertyProviderModel.areAllDependenciesAvailable(readDependencyKeys);
        }

        scheduler_internal function setup():void {
            initReadDependencies();
        }


    }
}
