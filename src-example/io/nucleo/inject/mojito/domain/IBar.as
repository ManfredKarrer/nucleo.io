package io.nucleo.inject.mojito.domain {
    public interface IBar {
        function get waitress():IWaitress;

        function getMojito(client:IThirstyClient):void;
    }
}
