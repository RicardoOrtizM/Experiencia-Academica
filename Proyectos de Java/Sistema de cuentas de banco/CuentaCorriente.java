/**
 * Clase CuentaCorriente
 * @author Ricardo Ortiz Meza
 * @version "Java 19.0.2"
 */

public abstract class CuentaCorriente extends Cuenta {
    private double bonificacionCompra;

    /*

     * @param tipo - Tipo de cuenta.
     * @param almacenMaximo - Monto m&aacute;ximo que puede almacenar la cuenta corriente.
     * @param saldo - Monto de saldo actual en la cuenta corriente.
     * @param bonificacionCompra - Porcentaje de bonificaci&oacute;n por compra.
     */

    /**
     * M&eacute;todo constructor por omisi&oacute;n.
     */
    //public CuentaCorriente (String tipo, double almacenMaximo, double saldo, double retiroMaximo, double bonificacionCompra) {
    public CuentaCorriente() {
        //super (tipo, 0.0, almacenMaximo, 1, saldo, 0.0, retiroMaximo);
        super();
        this.setMontoMinimo(0.0);
        this.setPeriodo(1);
        this.setDepositoMinimo(0.0);
        //this.setBonificacionCompra(bonificacionCompra);
    }

    /**
     * M&eacute;todo getBonificacionCompra()
     * <br>M&eacute;todo de acceso al porcentaje de bonificacion por compra de la cuenta corriente.
     * @return double - Porcentaje de bonificacion por compra de la cuenta corriente.
     */
    public double getBonificacionCompra() {
        return this.bonificacionCompra;
    }

    /**
     * M&eacute;todo setBonificacionCompra(double bonificacionCompra)
     * <br>M&eacute;todo de modificaci&oacute;n al porcentaje de bonificacion por compra de la cuenta corriente.
     * @param bonificacionCompra - Porcentaje de bonificacion por compra de la cuenta corriente.
     */
    public void setBonificacionCompra(double bonificacionCompra) {
        this.bonificacionCompra = bonificacionCompra;
    }

    /**
     * M&eacute;todo comprar(double montoCompra)
     * <br>M&eacute;todo para comprar algo de cierto monto usando una cuenta corriente.
     * @param montoCompra - Monto de la compra hecha usando una cuenta corriente.
     */
    public void comprar (double montoCompra) {
        try {
            if (((this.getSaldo() - montoCompra) >= 0.0)) {
                // si el saldo no queda como negativo
                this.setSaldo(this.getSaldo() - montoCompra);
                System.out.println("Se bonificara $" + (montoCompra * this.getBonificacionCompra()));
                this.setSaldo(this.getSaldo() + (montoCompra * this.getBonificacionCompra()));
                this.setDiaUltimoMovimiento(this.getContador());
                this.grabarArchivoCuenta();
                this.grabarArchivoMovimientos("Compra", montoCompra);// grabar movimiento
            } else {
                throw new SaldoInsuficienteException();
            }
        } catch (SaldoInsuficienteException e) {
            System.out.println(Color.ROJO + "No cuentas con el saldo suficiente, solo tienes $" + this.getSaldo() + Color.RESET);
        } catch (Exception e) {
            System.out.println(Color.ROJO + "Algo salio mal" + Color.RESET);
        }
    }

    /**
     * M&eacute;todo equals(Object obj)
     * <br>M&eacute;todo que verifica si dos cuentas corrientes son iguales.
     * @param obj - Objeto con el cual se va a comparar.
     * @return boolean - "true" si los dos objetos son iguales, "false" en otro caso.
     */
    @Override
    public boolean equals(Object obj) {
        boolean iguales = false;

        if (obj instanceof CuentaCorriente) {
            CuentaCorriente nuevaCuenta = (CuentaCorriente) obj;
            double bonificacionCompraN = nuevaCuenta.getBonificacionCompra();

            if ((super.equals(obj)) && (this.bonificacionCompra == bonificacionCompraN)) {
                iguales = true;
            }
        }
        return iguales;
    }

    /**
     * M&eacute;todo toString()
     * <br>M&eacute;todo que devuelve una cuenta corriente en formato de cadena.
     * @return String - Cuenta corriente en formato de cadena.
     */
    @Override
    public String toString() {
        String cadena = super.toString();
        cadena += "\n\tBonificacion por compra: " + (this.bonificacionCompra*100) + "%" ;

        return cadena;
    }
}
