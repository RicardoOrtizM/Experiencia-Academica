/**
 * Excepci&oacute;n SaldoInsuficienteException
 * @author Ricardo Ortiz Meza
 * @version "Java 19.0.2"
 */

public class SaldoInsuficienteException extends Exception {

    /**
     * M&eacute;todo constructor por omisi&oacute;n.
     */
    public SaldoInsuficienteException () {
        super();
    }

    /**
     * M&eacute;todo constructor.
     * @param s - Cadena con el mensaje descriptivo de la excepci&oacute;n.
     */
    public SaldoInsuficienteException (String s) {
        super(s);
    }
}
