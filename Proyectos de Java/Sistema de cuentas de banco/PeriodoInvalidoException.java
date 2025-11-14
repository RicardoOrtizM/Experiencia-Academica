/**
 * Excepci&oacute;n PeriodoInvalidoException
 * @author Ricardo Ortiz Meza
 * @version "Java 19.0.2"
 */

public class PeriodoInvalidoException extends Exception{

    /**
     * M&eacute;todo constructor por omisi&oacute;n.
     */
    public PeriodoInvalidoException () {
        super();
    }

    /**
     * M&eacute;todo constructor.
     * @param s - Cadena con el mensaje descriptivo de la excepci&oacute;n.
     */
    public PeriodoInvalidoException (String s) {
        super(s);
    }
}
