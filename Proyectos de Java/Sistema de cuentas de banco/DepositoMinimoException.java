/**
 * Excepci&oacute;n DepositoMinimoException
 * @author Ricardo Ortiz Meza
 * @version "Java 19.0.2"
 */

public class DepositoMinimoException extends Exception{

    /**
     * M&eacute;todo constructor por omisi&oacute;n.
     */
    public DepositoMinimoException () {
        super();
    }

    /**
     * M&eacute;todo constructor.
     * @param s - Cadena con el mensaje descriptivo de la excepci&oacute;n.
     */
    public DepositoMinimoException (String s) {
        super(s);
    }
}
