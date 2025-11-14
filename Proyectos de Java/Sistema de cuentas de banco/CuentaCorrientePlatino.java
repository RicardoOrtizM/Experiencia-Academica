/**
 * Clase CuentaCorrientePlatino
 * @author Ricardo Ortiz Meza
 * @version "Java 19.0.2"
 */

public class CuentaCorrientePlatino extends CuentaCorriente {

    /**
     * M&eacute;todo constructor con par&aacute;metros de entrada.
     * @param diaActual - Dia actual en que se maneja la cuenta
     * @param rfc - Rfc de la persona propietaria de la cuenta
     */
    public CuentaCorrientePlatino (int diaActual, String rfc) {
        //super("CuentaCorrientePlatino", Double.MAX_VALUE, 0, 8000.00, 0.15);
        super();
        this.setTipo("CuentaCorrientePlatino");
        this.setAlmacenMaximo(Double.MAX_VALUE);
        this.setSaldo(0);
        this.setRetiroMaximo(8000.00);
        this.setBonificacionCompra(0.15);
        this.setContador(diaActual);
        this.setRfc(rfc);
    }

    /**
     * M&eacute;todo equals(Object obj)
     * <br>M&eacute;todo que verifica si dos cuentas corrientes platino son iguales.
     * @param obj - Objeto con el cual se va a comparar.
     * @return boolean - "true" si los dos objetos son iguales, "false" en otro caso.
     */
    @Override
    public boolean equals(Object obj) {
        return super.equals(obj);
    }

    /**
     * M&eacute;todo toString()
     * <br>M&eacute;todo que devuelve una cuenta corriente platino en formato de cadena.
     * @return String - Cuenta corriente oro en formato de cadena.
     */
    @Override
    public String toString() {
        return super.toString();
    }
}
