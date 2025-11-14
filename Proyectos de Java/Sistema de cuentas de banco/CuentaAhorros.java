/**
 * Clase CuentaAhorros
 * @author Ricardo Ortiz Meza
 * @version "Java 19.0.2"
 */

public class CuentaAhorros extends Cuenta {

    /**
     * M&eacute;todo constructor con par&aacute;metros de entrada.
     * @param diaActual - Dia actual en que se maneja la cuenta
     * @param rfc - Rfc de la persona propietaria de la cuenta
     */
    public CuentaAhorros(int diaActual, String rfc) {
        //super("CuentaAhorros", 2500.00, Double.MAX_VALUE, 18, 0,500.00, 5000.00);
        super();
        this.setTipo("CuentaAhorros");
        this.setMontoMinimo(2500.00);
        this.setAlmacenMaximo(Double.MAX_VALUE);
        this.setPeriodo(18);
        this.setSaldo(0);
        this.setDepositoMinimo(500.00);
        this.setRetiroMaximo(5000.00);
        this.setContador(diaActual);
        this.setRfc(rfc);
    }

    /**
     * M&eacute;todo equals(Object obj)
     * <br>M&eacute;todo que verifica si dos cuentas de ahorros son iguales.
     * @param obj - Objeto con el cual se va a comparar.
     * @return boolean - "true" si los dos objetos son iguales, "false" en otro caso.
     */
    @Override
    public boolean equals(Object obj) {
        return super.equals(obj);
    }

    /**
     * M&eacute;todo toString()
     * <br>M&eacute;todo que devuelve una cuenta de ahorros en formato de cadena.
     * @return String - Cuenta de ahorros en formato de cadena.
     */
    @Override
    public String toString() {
        return super.toString();
    }

}
