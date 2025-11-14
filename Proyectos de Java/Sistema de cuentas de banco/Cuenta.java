import javax.swing.plaf.ColorUIResource;
import java.io.*;
import java.sql.Array;
import java.sql.SQLOutput;
import java.util.*;

/**
 * Clase Cuenta
 * @author Ricardo Ortiz Meza
 * @version "Java 19.0.2"
 */

public abstract class Cuenta {
    private String numeroCuenta;
    private String tipo; // tipo de cuenta
    private double montoMinimo; // monto minimo para abrir la cuenta
    private double almacenMaximo; // capacidad maxima de la cuenta
    private int periodo; // periodo en que se pueden realizar operaciones con la cuenta
    private double saldo;
    private int contador; // dia actual
    private double depositoMinimo;
    private double retiroMaximo;
    private double retirosDelDia;
    private String rfc;
    private int diaUltimoMovimiento;
    private int diaApertura;


    /*

     * @param tipo - Tipo de cuenta.
     * @param montoMinimo - Monto m&iacute;nimo para abrir la cuenta.
     * @param almacenMaximo - Monto m&aacute;ximo que puede almacenar la cuenta.
     * @param periodo - Periodo en que se pueden realizar operaciones con la cuenta.
     * @param saldo - Monto de saldo actual que hay en la cuenta.
     * @param depositoMinimo - Monto de dep&oacute;sito m&iacute;nimo de la cuenta.
     * @param retiroMaximo - Monto de retiro m&aacute;ximo de la cuenta.
     */

    /**
     * M&eacute;todo constructor por omisi&oacute;n.
     */
    //public Cuenta(String tipo, double montoMinimo, double almacenMaximo, int periodo, double saldo, double depositoMinimo, double retiroMaximo) {
    public Cuenta() {
        int num1 = (int) (10*Math.random());
        int num2 = (int) (10*Math.random());
        this.numeroCuenta = "98765432" + num1 + num2;
        this.setRetirosDelDia(0);
        /*
        this.tipo = tipo;
        this.montoMinimo = montoMinimo;
        this.almacenMaximo = almacenMaximo;
        this.periodo = periodo;
        this.saldo = saldo;
        this.contador = 0;
        this.depositoMinimo = depositoMinimo;
        this.retiroMaximo = retiroMaximo;
        this.rfc = "x";
         */
    }

    /**
     * M&eacute;todo getNumeroCuenta()
     * <br>M&eacute;todo de acceso al n&uacute;mero de la cuenta.
     * @return String - N&uacute;mero de la cuenta.
     */
    public String getNumeroCuenta() {
        return this.numeroCuenta;
    }

    /**
     * M&eacute;todo setNumeroCuenta(String numeroCuenta)
     * <br>M&eacute;todo de modificaci&oacute;n al n&uacute;mero de la cuenta.
     * @param numeroCuenta - N&uacute;mero de la cuenta.
     */
    public void setNumeroCuenta(String numeroCuenta) {
        this.numeroCuenta = numeroCuenta;
    }

    /**
     * M&eacute;todo getTipo()
     * <br>M&eacute;todo de acceso al tipo de cuenta.
     * @return String - Tipo de cuenta.
     */
    public String getTipo() {
        return this.tipo;
    }

    /**
     * M&eacute;todo setTipo(String tipo)
     * <br>M&eacute;todo de modificaci&oacute;n al tipo de cuenta.
     * @param tipo - Tipo de cuenta.
     */
    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    /**
     * M&eacute;todo getMontoMinimo()
     * <br>M&eacute;todo de acceso al monto m&iacute;nimo para abrir la cuenta.
     * @return double - Monto m&iacute;nimo para abrir la cuenta.
     */
    public double getMontoMinimo() {
        return this.montoMinimo;
    }

    /**
     * M&eacute;todo setMontoMinimo(double montoMinimo)
     * <br>M&eacute;todo de modificaci&oacute;n al monto m&iacute;nimo para abrir la cuenta.
     * @param montoMinimo - Monto m&iacute;nimo para abrir la cuenta.
     */
    public void setMontoMinimo(double montoMinimo) {
        this.montoMinimo = montoMinimo;
    }

    /**
     * M&eacute;todo getAlmacenMaximo()
     * <br>M&eacute;todo de acceso al monto m&aacute;ximo que puede almacenar la cuenta.
     * @return double - Monto m&aacute;ximo que puede almacenar la cuenta.
     */
    public double getAlmacenMaximo() {
        return this.almacenMaximo;
    }

    /**
     * M&eacute;todo setAlmacenMaximo(double almacenMaximo)
     * <br>M&eacute;todo de modificaci&oacute;n al monto m&aacute;ximo que puede almacenar la cuenta.
     * @param almacenMaximo - Monto m&aacute;ximo que puede almacenar la cuenta.
     */
    public void setAlmacenMaximo(double almacenMaximo) {
        this.almacenMaximo = almacenMaximo;
    }

    /**
     * M&eacute;todo getSaldo()
     * <br>M&eacute;todo de acceso al saldo actual de la cuenta.
     * @return double - Saldo actual de la cuenta.
     */
    public double getSaldo() {
        return this.saldo;
    }

    /**
     * M&eacute;todo setSaldo(double saldo)
     * <br>M&eacute;todo de modificaci&oacute;n al saldo actual de la cuenta.
     * @param saldo - Saldo actual de la cuenta.
     */
    public void setSaldo(double saldo) {
        this.saldo = saldo;
    }

    /**
     * M&eacute;todo getContador()
     * <br>M&eacute;todo de acceso al d&iacute;a que se ingresa al sistema.
     * @return int - D&iacute;a que se ingresa al sistema.
     */
    public int getContador() {
        return this.contador;
    }

    /**
     * M&eacute;todo setContador(int contador)
     * <br>M&eacute;todo de modificaci&oacute;n al d&iacute;a que se ingresa al sistema.
     * @param contador - D&iacute;a que se ingresa al sistema.
     */
    public void setContador(int contador) {
        this.contador = contador;
    }

    /**
     * M&eacute;todo getPeriodo()
     * <br>M&eacute;todo de acceso al periodo en que se pueden realizar operaciones con la cuenta.
     * @return int - Periodo en que se pueden realizar operaciones con la cuenta.
     */
    public int getPeriodo() {
        return this.periodo;
    }

    /**
     * M&eacute;todo setPeriodo(int periodo)
     * <br>M&eacute;todo de modificaci&oacute;n al periodo en que se pueden realizar operaciones con la cuenta.
     * @param periodo - Periodo en que se pueden realizar operaciones con la cuenta.
     */
    public void setPeriodo(int periodo) {
        this.periodo = periodo;
    }

    /**
     * M&eacute;todo getDepositoMinimo()
     * <br>M&eacute;todo de acceso al monto de dep&oacute;sito m&iacute;nimo de la cuenta.
     * @return double - Monto de dep&oacute;sito m&iacute;nimo de la cuenta.
     */
    public double getDepositoMinimo() {
        return this.depositoMinimo;
    }

    /**
     * M&eacute;todo setDepositoMinimo(double depositoMinimo)
     * <br>M&eacute;todo de modificaci&oacute;n al monto de dep&oacute;sito m&iacute;nimo de la cuenta.
     * @param depositoMinimo - Monto de dep&oacute;sito m&iacute;nimo de la cuenta.
     */
    public void setDepositoMinimo(double depositoMinimo) {
        this.depositoMinimo = depositoMinimo;
    }

    /**
     * M&eacute;todo getRetiroMaximo()
     * <br>M&eacute;todo de acceso al monto de retiro m&aacute;ximo de la cuenta.
     * @return double - Monto de retiro m&aacute;ximo de la cuenta.
     */
    public double getRetiroMaximo() {
        return this.retiroMaximo;
    }

    /**
     * M&eacute;todo setRetiroMaximo(double retiroMaximo)
     * <br>M&eacute;todo de modificaci&oacute;n al monto de retiro m&aacute;ximo de la cuenta.
     * @param retiroMaximo - Monto de retiro m&aacute;ximo de la cuenta.
     */
    public void setRetiroMaximo(double retiroMaximo) {
        this.retiroMaximo = retiroMaximo;
    }

    /**
     * M&eacute;todo getRetirosDelDia()
     * <br>M&eacute;todo de acceso al monto total de retiros hechos en el d&iacute;a con la cuenta.
     * @return double - Monto total de retiros hechos en el d&iacute;a con la cuenta.
     */
    public double getRetirosDelDia() {
        return this.retirosDelDia;
    }

    /**
     * M&eacute;todo setRetirosDelDia(double retirosDelDia)
     * <br>M&eacute;todo de modificaci&oacute;n al monto total de retiros hechos en el d&iacute;a con la cuenta.
     * @param retirosDelDia - Monto total de retiros hechos en el d&iacute;a con la cuenta.
     */
    public void setRetirosDelDia(double retirosDelDia) {
        this.retirosDelDia = retirosDelDia;
    }

    /**
     * M&eacute;todo getRfc()
     * <br>M&eacute;todo de acceso al rfc del dueño de la cuenta.
     * @return String - rfc del dueño de la cuenta.
     */
    public String getRfc() {
        return this.rfc;
    }

    /**
     * M&eacute;todo setRfc(String rfc)
     * <br>M&eacute;todo de modificaci&oacute;n al rfc del dueño de la cuenta.
     * @param rfc - rfc del dueño de la cuenta.
     */
    public void setRfc(String rfc) {
        this.rfc = rfc;
    }

    /**
     * M&eacute;todo getDiaUltimoMovimiento()
     * <br>M&eacute;todo de acceso al d&iacute;a del ultimo movimiento de la cuenta.
     * @return int - D&iacute;a del ultimo movimiento de la cuenta.
     */
    public int getDiaUltimoMovimiento() {
        return this.diaUltimoMovimiento;
    }

    /**
     * M&eacute;todo setDiaUltimoMovimiento(int diaUltimoMovimiento)
     * <br>M&eacute;todo de modificaci&oacute;n al d&iacute;a del ultimo movimiento de la cuenta.
     * @param diaUltimoMovimiento - D&iacute;a del ultimo movimiento de la cuenta.
     */
    public void setDiaUltimoMovimiento(int diaUltimoMovimiento) {
        this.diaUltimoMovimiento = diaUltimoMovimiento;
    }

    /**
     * M&eacute;todo getDiaApertura()
     * <br>M&eacute;todo de acceso al d&iacute;a de la apertura de la cuenta.
     * @return int - D&iacute;a de la apertura de la cuenta.
     */
    public int getDiaApertura() {
        return this.diaApertura;
    }

    /**
     * M&eacute;todo setDiaApertura(int diaApertura)
     * <br>M&eacute;todo de modificaci&oacute;n al d&iacute;a de la apertura de la cuenta.
     * @param diaApertura - D&iacute;a de la apertura de la cuenta.
     */
    public void setDiaApertura(int diaApertura) {
        this.diaApertura = diaApertura;
    }

    /**
     * M&eacute;todo apertura (double monto, int diaActual)
     * <br>M&eacute;todo que crea una cuenta, crea su archivo de cuenta y de movimientos.
     * @param monto - Monto con el que se va iniciar la cuenta.
     * @param diaActual - Dia actual, dia en que se va a crear la cuenta.
     * @return String - Mensaje que dice si se pudo crear la cuenta o no
     */
    public String apertura (double monto, int diaActual) {
        if ((monto >= this.getMontoMinimo()) && (monto<=this.getAlmacenMaximo())) {
            this.saldo += monto;
            this.setContador(diaActual);
            this.setDiaApertura(diaActual);
            this.grabarArchivoCuenta(); // crear el archivo de cuenta
            this.grabarArchivoMovimientos("Apertura", monto);// grabar movimiento
            /*this.setContador(diaActual);
            this.setDiaApertura(diaActual);

             */
            return "Se pudo abrir la cuenta exitosamente" + "\nNumero de cuenta: " + this.getNumeroCuenta();
        } else {
            return "No se pudo abrir la cuenta por monto insuficiente o monto que excede la capacidad maxima, recuerda que necesitas por lo menos $" + this.getMontoMinimo() + " o hasta " + this.getAlmacenMaximo() + " para poder abrir la cuenta";
        }
    }

    /**
     * M&eacute;todo grabarArchivoCuenta()
     * <br>M&eacute;todo que graba el estado de la cuenta en un archivo.
     */
    public void grabarArchivoCuenta() {
        try {
            File miArchivo = new File(this.getTipo() + this.getRfc() + ".csv"); //crea el archivo con ese nombre y extension
            FileWriter fileWriter = new FileWriter(miArchivo); // abre el archivo recien creado como de escritura
            BufferedWriter bW = new BufferedWriter(fileWriter); // este es el que permite grabar en el archivo que se creo y abrio
            bW.write(this.getNumeroCuenta() + "\n"); // un write por cada linea que quieres que se guarde
            bW.write(this.getTipo() + "\n");
            String saldo = String.valueOf(this.getSaldo() + "\n");
            bW.write(saldo);
            String diaApertura = String.valueOf(this.getDiaApertura() + "\n");
            bW.write(diaApertura);
            String diaUltimoMovimiento = String.valueOf(this.getDiaUltimoMovimiento());
            bW.write(diaUltimoMovimiento);
            bW.close(); // es para cerrar el archivo
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * M&eacute;todo leerArchivoCuenta()
     * <br>M&eacute;todo que lee el archivo con el estado de la cuenta.
     */
    public void leerArchivoCuenta() {
        this.leerArchivoCuenta(true);
    }

    /**
     * M&eacute;todo leerArchivoCuenta()
     * <br>M&eacute;todo que lee el archivo con el estado de la cuenta.
     * @param imprime - Opcion de imprimir o no el estado de la cuenta.
     */
    public void leerArchivoCuenta(boolean imprime) {
        try {
            Scanner archivo = new Scanner (new File (this.getTipo() + this.getRfc() + ".csv")); // abre el archivo
            //archivo.nextLine(); // lee una linea del archivo
            this.setNumeroCuenta(archivo.nextLine());
            this.setTipo(archivo.nextLine());
            this.setSaldo(archivo.nextDouble());
            this.setDiaApertura(archivo.nextInt());
            this.setDiaUltimoMovimiento(archivo.nextInt());
            if (imprime) {
                System.out.println(Color.VERDE + "\nEstado de la Cuenta");
                System.out.println("\tNumero de cuenta: " + this.getNumeroCuenta());
                System.out.println("\tTipo de Cuenta: " + this.getTipo());
                System.out.println("\tSaldo Actual: $" + this.getSaldo());
                System.out.println("\tDia de apertura de la cuenta: " + this.getDiaApertura());
                System.out.println("\tDia ultimo movimiento: " + this.getDiaUltimoMovimiento() + Color.RESET);
            }
        } catch (Exception e) {
            System.out.println (Color.ROJO + "Error en la lectura, ese archivo no se puede leer porque no existe: "+e + Color.RESET);
            // ponemos el objeto e para obtener mas info
            e.printStackTrace();
        }
    }

    /**
     * M&eacute;todo grabarArchivoMovimientos(String tipoMov, double monto)
     * <br>M&eacute;todo que graba los movimientos de la cuenta en un archivo.
     * @param tipoMov - Tipo de movimiento hecho.
     * @param monto - Monto del movimiento.
     */
    public void grabarArchivoMovimientos(String tipoMov, double monto) {
        try {
            File miArchivo = new File("Movimientos" + this.getTipo() + this.getNumeroCuenta() + ".csv"); //crea el archivo con ese nombre y extension
            FileWriter fileWriter = new FileWriter(miArchivo, true); // abre el archivo recien creado como de escritura
            // el true
            BufferedWriter bW = new BufferedWriter(fileWriter); // este es el que permite grabar en el archivo que se creo y abrio
            String diaMov = String.valueOf(this.getContador());
            bW.write(diaMov+ ","); // un write por cada linea que quieres que se guarde
            bW.write(tipoMov + ",");
            String montoMov = String.valueOf(monto);
            bW.write(montoMov + ",");
            String saldo = String.valueOf(this.getSaldo()) + "\n";
            bW.write(saldo);
            bW.close(); // es para cerrar el archivo
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * M&eacute;todo leerArchivoMovimientos()
     * <br>M&eacute;todo que lee el archivo con los movimientos de la cuenta e imprime solamente los ultimos 10.
     */
    public void leerArchivoMovimientos() {
        String linea;
        try {
            File miArchivo = new File("Movimientos" + this.getTipo() + this.getNumeroCuenta() + ".csv");
            Scanner archivo = new Scanner(miArchivo);
            String[] campos;
            String[] movimientos = {"Dia: ", "Tipo de Movimiento: ", "Monto movimiento: $", "Saldo Final: $"}; // que va a tener cada movimiento

            ArrayList<String> listaMovimientos = new ArrayList<String>();
            while (archivo.hasNextLine()){ // mientras haya una linea
                String movimiento = "";
                linea = archivo.nextLine(); // lee una linea del archivo, cada linea es un movimiento
                campos = linea.split(","); // genera un arreglo que guardamos en campos, que tiene cada dato del movimiento
                for (int i=0; i < campos.length; i++) {
                    movimiento += "\n\t" + movimientos[i] + campos[i]; // guarda cada campo y dato en movimiento
                }
                listaMovimientos.add(movimiento); // guarda el movimiento completo en la lista de movimientos
            }

            int inicio = 0;
            if (listaMovimientos.size() > 10) {
                // si hay mas de 10 movimientos
                inicio = listaMovimientos.size()-10;
            }

            for (int i=inicio; i<listaMovimientos.size(); i++) {
                System.out.println(listaMovimientos.get(i));
            }

        } catch (Exception e) {
            System.out.println(Color.ROJO + "Problemas"+e + Color.RESET);
        }
    }


    /**
     * M&eacute;todo depositar()
     * <br>M&eacute;todo para depositar cierto monto a la cuenta.
     * @param montoDeposito - Monto que se desea depositar a la cuenta.
     */
    public void depositar(double montoDeposito) {
        try {
            if (((this.getContador() - this.getDiaUltimoMovimiento()) % this.getPeriodo()) == 0) {
                // Si contador es divisible entre el periodo
                if (montoDeposito >= this.depositoMinimo) {
                    // si el deposito es mayor a depositoMinimo
                    if ((this.saldo + montoDeposito) <= this.almacenMaximo) {
                        // si el deposito+saldo no es mayor a almacenMaximo
                        this.setSaldo(this.getSaldo() + montoDeposito);
                        this.setDiaUltimoMovimiento(this.getContador());
                        this.grabarArchivoCuenta();
                        this.grabarArchivoMovimientos("Deposito", montoDeposito);// grabar movimiento
                    } else {
                        throw new AlmacenMaximoException();
                    }
                } else {
                    throw new DepositoMinimoException();
                }
            } else {
                // si contador no es divisible entre el periodo
                throw  new PeriodoInvalidoException();
            }
        } catch (PeriodoInvalidoException e) {
            System.out.println(Color.ROJO + "Solo puedes realizar movimientos cada " + this.getPeriodo() + " dias" + Color.RESET);
        } catch (DepositoMinimoException e) {
            System.out.println(Color.ROJO + "El deposito debe ser mayor o igual a $" + this.getDepositoMinimo() + Color.RESET);
        } catch (AlmacenMaximoException e) {
            System.out.println(Color.ROJO + "No puedes realizar el deposito porque excede el almacen maximo de la cuenta, que es de $" + this.getAlmacenMaximo() + Color.RESET);
        } catch (Exception e) {
            System.out.println(Color.ROJO + "Algo salio mal" + Color.RESET);
        }
    }

    /**
     * M&eacute;todo retirar()
     * <br>M&eacute;todo para retirar cierto monto a la cuenta.
     * @param montoRetiro - Monto que se desea retirar a la cuenta.
     */
    public void retirar(double montoRetiro) {
        try {
            if (((this.getContador() - this.getDiaUltimoMovimiento()) % this.periodo) == 0) {
                // Si contador es divisible entre el periodo
                if ((this.retirosDelDia + montoRetiro) <= this.retiroMaximo) {
                    // si el los retiros del dia son menores a retiroMaximo
                    if ((this.saldo - montoRetiro) >= 0.0) {
                        // si el saldo no queda como negativo
                        this.saldo -= montoRetiro;
                        this.retirosDelDia += montoRetiro;
                        this.setDiaUltimoMovimiento(this.getContador());
                        this.grabarArchivoCuenta();
                        this.grabarArchivoMovimientos("Retiro", montoRetiro);// grabar movimiento
                    } else {
                        throw new SaldoInsuficienteException();
                    }
                } else {
                    throw new RetiroMaximoException();
                }
            } else {
                // si contador no es divisible entre el periodo
                throw  new PeriodoInvalidoException();
            }
        } catch (PeriodoInvalidoException e) {
            System.out.println(Color.ROJO + "Solo puedes realizar movimientos cada " + this.getPeriodo() + " dias" + Color.RESET);
        } catch (RetiroMaximoException e) {
            System.out.println(Color.ROJO + "El retiro debe ser menor o igual a $" + this.getRetiroMaximo() + " al dia" + Color.RESET);
        } catch (SaldoInsuficienteException e) {
            System.out.println(Color.ROJO + "No cuentas con el saldo suficiente, solo tienes $" + this.getSaldo() + Color.RESET);
        } catch (Exception e) {
            System.out.println(Color.ROJO + "Algo salio mal" + Color.RESET);
        }
    }

    /**
     * M&eacute;todo existeCuenta(String tipo, String rfc)
     * <br>M&eacute;todo para retirar cierto monto a la cuenta.
     * @param tipo - Tipo de cuenta.
     * @param rfc - Rfc de la persona propietaria de la cuenta.
     * @return boolean - True si existe ese tipo de cuenta propiedad de dicha persona, False en otro caso
     */
    public static boolean existeCuenta(String tipo, String rfc) {
        File miArchivo = new File(tipo + rfc +".csv"); //crea el archivo con ese nombre y extension
        return miArchivo.exists();
    }

    /**
     * M&eacute;todo equals(Object obj)
     * <br>M&eacute;todo que verifica si dos cuentas son iguales.
     * @param obj - Objeto con el cual se va a comparar.
     * @return boolean - "true" si los dos objetos son iguales, "false" en otro caso.
     */
    @Override
    public boolean equals(Object obj) {
        boolean iguales = false;

        if (obj instanceof Cuenta) {
            Cuenta nuevaCuenta = (Cuenta) obj;
            String numCuentaN = nuevaCuenta.getNumeroCuenta();
            String tipoN = nuevaCuenta.getTipo();
            double montoMinimoN = nuevaCuenta.getMontoMinimo();
            double almacenMaximoN = nuevaCuenta.getAlmacenMaximo();
            int periodoN = nuevaCuenta.getPeriodo();
            double saldoN = nuevaCuenta.getSaldo();
            double depositoMinimoN = nuevaCuenta.getDepositoMinimo();
            double retiroMaximoN = nuevaCuenta.getRetiroMaximo();

            if ((this.numeroCuenta.equals(numCuentaN)) && (this.tipo.equals(tipoN)) && (this.montoMinimo == montoMinimoN) && (this.almacenMaximo == almacenMaximoN) && (this.periodo == periodoN) && (this.saldo == saldoN) && (this.depositoMinimo == depositoMinimoN) && (this.retiroMaximo == retiroMaximoN)) {
                iguales = true;
            }
        }
        return iguales;
    }

    /**
     * M&eacute;todo toString()
     * <br>M&eacute;todo que devuelve una cuenta en formato de cadena.
     * @return String - Cuenta en formato de cadena.
     */
    @Override
    public String toString() {
        String cadena = "\nCaracteristicas de la cuenta:";
        cadena += "\n\tTipo: " + this.getTipo();
        cadena += "\n\tMonto minimo para abrir la cuenta: $" + this.montoMinimo;
        cadena += "\n\tMonto maximo que puede almacenar la cuenta: $" + this.almacenMaximo;
        cadena += "\n\tPeriodo en que se pueden realizar operaciones con la cuenta: Cada " + this.periodo + " dias";
        cadena += "\n\tMonto de deposito minimo que puede realizar cada " + this.periodo + " dias: $" + this.depositoMinimo;
        cadena += "\n\tMonto de retiro maximo al dia que se puede realizar cada " + this.periodo + " dias: $" + this.retiroMaximo;
        return cadena;
    }
}