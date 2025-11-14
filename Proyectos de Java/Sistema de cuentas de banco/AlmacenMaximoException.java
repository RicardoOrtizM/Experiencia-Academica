/**
 * Excepci&oacute;n AlmacenMaximoException
 * @author Ricardo Ortiz Meza
 * @version "Java 19.0.2"
 */

public class AlmacenMaximoException extends Exception {

    /**
     * M&eacute;todo constructor por omisi&oacute;n.
     */
    public AlmacenMaximoException () {
        super();
    }

    /**
     * M&eacute;todo constructor.
     * @param s - Cadena con el mensaje descriptivo de la excepci&oacute;n.
     */
    public AlmacenMaximoException (String s) {
        super(s);
    }
}
