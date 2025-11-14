/**
 * Clase CuentaInversion
 * @author Ricardo Ortiz Meza
 * @version "Java 19.0.2"
 */

public class CuentaInversion extends Cuenta {
    private double porcentajeRendimientos;

    /**
     * M&eacute;todo constructor con par&aacute;metros de entrada.
     * @param diaActual - Dia actual en que se maneja la cuenta
     * @param rfc - Rfc de la persona propietaria de la cuenta
     */
    public CuentaInversion(int diaActual, String rfc) {
        //super("CuentaInversion", 5000.00, Double.MAX_VALUE, 28, 0,1500.00, 5000.00);
        super();
        this.setTipo("CuentaInversion");
        this.setMontoMinimo(5000.00);
        this.setAlmacenMaximo(Double.MAX_VALUE);
        this.setPeriodo(28);
        this.setSaldo(0);
        this.setDepositoMinimo(1500.00);
        this.setRetiroMaximo(5000.00);
        this.setContador(diaActual);
        this.setRfc(rfc);
        this.setPorcentajeRendimientos(0.18);
    }


    /**
     * M&eacute;todo getPorcentajeRendimientos()
     * <br>M&eacute;todo de acceso al porcentaje de rendimientos de la cuenta.
     * @return double - Porcentaje de rendimientos de la cuenta.
     */
    public double getPorcentajeRendimientos() {
        return this.porcentajeRendimientos;
    }


    /**
     * M&eacute;todo setPorcentajeRendimientos(double porcentajeRendimientos)
     * <br>M&eacute;todo de modificaci&oacute;n al porcentaje de rendimientos de la cuenta.
     * @param porcentajeRendimientos - Porcentaje de rendimientos de la cuenta.
     */
    public void setPorcentajeRendimientos(double porcentajeRendimientos) {
        this.porcentajeRendimientos = porcentajeRendimientos;
    }

    /**
     * M&eacute;todo SetPorcentajeRendimientos()
     * <br>M&eacute;todo para obtener los rendimientos de la cuenta cada periodo.
     */
    public void obtenerRendimientos() {
        try {
            if ((this.getContador() % this.getPeriodo()) == 0) {
                // Si contador es divisible entre el periodo
                //this.leerArchivoCuenta(false);
                double rendimientos = this.getSaldo() * this.getPorcentajeRendimientos();
                this.setSaldo(this.getSaldo() + rendimientos);
                this.grabarArchivoMovimientos("Obtencion de rendimientos", rendimientos);
                this.setDiaUltimoMovimiento(this.getContador());
                this.grabarArchivoCuenta();
            } else {
                // si contador no es divisible entre el periodo
                throw  new PeriodoInvalidoException();
            }
        } catch (PeriodoInvalidoException e) {
            System.out.println(Color.ROJO + "Solo puedes obtener rendimientos cada " + this.getPeriodo() + " dias" + Color.RESET);
        } catch (Exception e) {
            System.out.println(Color.ROJO + "Algo salio mal" + Color.RESET);
        }
    }

    /**
     * M&eacute;todo equals(Object obj)
     * <br>M&eacute;todo que verifica si dos cuentas de inversi&oacute;n son iguales.
     * @param obj - Objeto con el cual se va a comparar.
     * @return boolean - "true" si los dos objetos son iguales, "false" en otro caso.
     */
    @Override
    public boolean equals(Object obj) {
        return super.equals(obj);
    }

    /**
     * M&eacute;todo toString()
     * <br>M&eacute;todo que devuelve una cuenta de inversi&oacute;n en formato de cadena.
     * @return String - Cuenta de inversi&oacute;n en formato de cadena.
     */
    @Override
    public String toString() {
        return super.toString() + "\nPorcentaje Rendimientos: " + (this.getPorcentajeRendimientos()*100) + "%";
    }
}
