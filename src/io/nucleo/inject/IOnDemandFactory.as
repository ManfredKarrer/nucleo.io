package io.nucleo.inject {
public interface IOnDemandFactory {

    /**
     *
     * @return  The object created on demand when it is needed.
     */
    function getObject():Object;
}
}
