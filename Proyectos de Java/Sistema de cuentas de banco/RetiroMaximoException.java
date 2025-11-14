/**
 * Excepci&oacute;n RetiroMaximoException
 * @author Ricardo Ortiz Meza
 * @version "Java 19.0.2"
 */
public class RetiroMaximoException extends Exception{

    /**
     * M&eacute;todo constructor por omisi&oacute;n.
     */
    public RetiroMaximoException () {
        super();
    }

    /**
     * M&eacute;todo constructor.
     * @param s - Cadena con el mensaje descriptivo de la excepci&oacute;n.
     */
    public RetiroMaximoException (String s) {
        super(s);
    }
}
