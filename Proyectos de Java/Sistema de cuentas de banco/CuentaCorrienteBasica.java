/**
 * Clase CuentaCorrienteBasica
 * @author Ricardo Ortiz Meza
 * @version "Java 19.0.2"
 */

public class CuentaCorrienteBasica extends CuentaCorriente {

    /**
     * M&eacute;todo constructor con par&aacute;metros de entrada.
     * @param diaActual - Dia actual en que se maneja la cuenta
     * @param rfc - Rfc de la persona propietaria de la cuenta
     */
    public CuentaCorrienteBasica (int diaActual, String rfc) {
        //super ("CuentaCorrienteBasica", 7000.00, 0, 1000.00, 0.05);
        super();
        this.setTipo("CuentaCorrienteBasica");
        this.setAlmacenMaximo(7000.00);
        this.setSaldo(0);
        this.setRetiroMaximo(1000.00);
        this.setBonificacionCompra(0.05);
        this.setContador(diaActual);
        this.setRfc(rfc);
    }

    /**
     * M&eacute;todo equals(Object obj)
     * <br>M&eacute;todo que verifica si dos cuentas corrientes b&aacute;sicas son iguales.
     * @param obj - Objeto con el cual se va a comparar.
     * @return boolean - "true" si los dos objetos son iguales, "false" en otro caso.
     */
    @Override
    public boolean equals(Object obj) {
        return super.equals(obj);
    }

    /**
     * M&eacute;todo toString()
     * <br>M&eacute;todo que devuelve una cuenta corriente b&aacute;sica en formato de cadena.
     * @return String - Cuenta corriente b&aacute;sica en formato de cadena.
     */
    @Override
    public String toString() {
        return super.toString();
    }
}
