package io.nucleo.errors {
    import flash.utils.getQualifiedClassName;

    /**
     * Used to protect abstract methods, as abstract is not supported in AS3 we throw this error at runtime
     * to get a better protection against incorrect usage.
     */
    public class AbstractMethodInvocationError extends Error {

        /**
         *
         * @param instance      The class instance where the error is thrown
         * @param methodName    The name of the abstract method
         */
        public function AbstractMethodInvocationError(classInstance:Object,
                                                      methodName:String) {
            var message:String = "Invalid invocation of an abstract method. Abstract methods must be overwritten in a subclass.";
            message += " / class instance=" + getQualifiedClassName(classInstance);
            message += " / method=" + methodName;

            super(message);
        }

    }
}
