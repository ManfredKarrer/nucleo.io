package io.nucleo.scheduler.runnables {

    public class RunnableFault {
        private var _message:String;
        private var _data:Object;

        /**
         *
         * @param message
         * @param data
         */
        public function RunnableFault(message:String,
                                      data:Object = null) {
            this._message = message;
            this._data = data;
        }

        public function get message():String {
            return _message;
        }

        public function get data():Object {
            return _data;
        }

        public function toString():String {
            return message;
        }

    }
}
