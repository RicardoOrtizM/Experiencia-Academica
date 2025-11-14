import java.io.*;
import java.util.*;
/**
 * Clase Sistema
 * @author Ricardo Ortiz M.
 * @version "Java 19.0.2"
 */
public class Sistema {
    static Scanner teclado = new Scanner(System.in);
    static Persona cliente = new Persona(1);
    static int diaActual = obtenerDiaActual();

    public static void main (String[]args){
        if (diaActual != -1) {
            System.out.println(Color.CYAN);
            System.out.println("-----------------------------------------------------------------------------------------");
            System.out.println("\t\t\t\t\t\t\t** Bienvenido a BancoUNAM **");
            System.out.println("-----------------------------------------------------------------------------------------");

            System.out.println(Color.RESET);
            System.out.println("Dia Calendario: " + diaActual);

            System.out.println();
            System.out.println(Color.AMARILLO + "Cliente: " + cliente + Color.RESET);

            obtenerRendimientos();

            int opcionMenu = 0;
            String[] opciones = {"Crear nueva cuenta", "Acceder a cuenta corriente", "Acceder a cuenta de ahorros", "Acceder a cuenta de inversion", "Ver caracteristicas cuentas", "Salir"};

            while (opcionMenu != opciones.length) {
                opcionMenu = menu(opciones, "MENU PRINCIPAL");

                switch (opcionMenu) {
                    case 1:
                        menuCrearCuenta();
                        break;
                    case 2:
                        menuAccederCuentaCorriente();
                        break;
                    case 3:
                        menuAccederCuentaAhorro();
                        break;
                    case 4:
                        menuAccederCuentaInversion();
                        break;
                    case 5:
                        menuCaracteristicas();
                        break;
                    case 6:
                        break;
                    default:
                        System.out.println(Color.ROJO + "Esa opcion no existe en el menu, vuelve a intentarlo" + Color.RESET);
                }

            }

            System.out.println();
            System.out.println("Vuelva pronto");

        } else {
            System.out.println(Color.ROJO + "Se acaba de crear el archivo con el dia actual, vuelve a intentarlo" + Color.RESET);
        }
    }


    private static int obtenerDiaActual() {
        try {
            Scanner archivo = new Scanner(new File("DiaActual.csv")); // abre el archivo con dicho nombre
            //archivo.nextLine(); // lee una linea del archivo
            int diaActual = archivo.nextInt() + 1;
            guardarDiaActual(diaActual);
            return diaActual;
        } catch (Exception e) {
            System.out.println(Color.ROJO + "Error en la lectura, el archivo con el dia actual no se puede leer porque no existe: " + e + Color.RESET); // ponemos el objeto e para obtener mas info
            guardarDiaActual(-1);
            return -1;
        }
    }


    private static void guardarDiaActual(int diaActual) {
        try {
            File miArchivo = new File("DiaActual.csv"); //crea el archivo con ese nombre y extension
            FileWriter fileWriter = new FileWriter(miArchivo); // abre el archivo recien creado como de escritura
            BufferedWriter bW = new BufferedWriter(fileWriter); // este es el que permite grabar en el archivo que se creo y abrio
            String diaActualString = String.valueOf(diaActual);
            bW.write(diaActualString); // un write por cada linea que quieres que se guarde
            bW.close(); // es para cerrar el archivo
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // Para imprimir cualquier menu y solo devolver un int con el numero de la opcion si es valido (si esta dentro del rango y recibio un int de parte del usuario)
    private static int menu(String[] arreglo, String titulo) {
        int opcionMenu = 0;
        while ((opcionMenu < 1) || (opcionMenu > arreglo.length)) {
            // ya que las opciones van del 1 hasta cierto numero
            try {
                System.out.println(Color.AZUL);
                System.out.println(titulo);
                // Imprime las opciones
                for (int i = 0; i < arreglo.length; i++) {
                    System.out.println("\t" + (i + 1) + ". " + arreglo[i]);
                }
                System.out.println(Color.RESET);

                System.out.print("Opcion a realizar: ");
                opcionMenu = teclado.nextInt();
                teclado.nextLine();

                if ((opcionMenu < 1) || (opcionMenu > arreglo.length)) {
                    System.out.println(Color.ROJO + "\nSolo acepto valores enteros entre 1 y " + arreglo.length + ", vuelve a intentarlo");
                    System.out.print("Da <Enter> para continuar " + Color.RESET);
                    teclado.nextLine();
                }
            } catch (InputMismatchException e) {
                System.out.println(Color.ROJO + "\nSolo acepto valores enteros entre 1 y " + arreglo.length + ", vuelve a intentarlo");
                System.out.print("Da <Enter> para continuar "  + Color.RESET);
                teclado.nextLine();
                teclado.nextLine();
            }
        }

        return opcionMenu;
    }


    private static void menuCrearCuenta() {
        int opcionMenu = 0;
        String[] opciones = {"Crear nueva cuenta corriente", "Crear nueva cuenta de ahorros", "Crear nueva cuenta de inversion", "Volver a menu anterior"};
        double monto;

        while (opcionMenu != opciones.length) {
            opcionMenu = menu(opciones, "MENU CREAR CUENTA");

            switch (opcionMenu) {
                case 1:
                    menuCrearCuentaCorriente();
                    break;
                case 2:
                    // crea cuenta de ahorro
                    if (Cuenta.existeCuenta("CuentaAhorros", cliente.getRfc())) {
                        System.out.println(Color.ROJO + "\nYa tiene una cuenta de ahorros" + Color.RESET);
                    } else {
                        CuentaAhorros cuentaA = new CuentaAhorros(diaActual, cliente.getRfc());
                        System.out.println("\nPara poder abrirla necesitas al menos: $" + cuentaA.getMontoMinimo());
                        System.out.println("Recuerda que esta cuenta no tiene limite de dinero para almacenar");
                        monto = captura();
                        System.out.println(Color.ROJO + cuentaA.apertura(monto, diaActual) + Color.RESET);
                        //opcionMenu = opciones.length;
                    }
                    break;
                case 3:
                    // crea cuenta de inversion
                    if (Cuenta.existeCuenta("CuentaInversion", cliente.getRfc())) {
                        System.out.println(Color.ROJO + "\nYa tiene una cuenta de inversion" + Color.RESET);
                    } else {
                        CuentaInversion cuentaI = new CuentaInversion(diaActual, cliente.getRfc());
                        System.out.println("\nPara poder abrirla necesitas al menos: $" + cuentaI.getMontoMinimo());
                        System.out.println("Recuerda que esta cuenta no tiene limite de dinero para almacenar");
                        monto = captura();
                        System.out.println(Color.ROJO + cuentaI.apertura(monto, diaActual));
                        //opcionMenu = opciones.length;
                    }
                    break;
                case 4:
                    break;
                default:
                    System.out.println(Color.ROJO + "Esa opcion no existe en el menu, vuelve a intentarlo" + Color.RESET);
            }

        }
    }


    private static void menuCrearCuentaCorriente() {
        if ((Cuenta.existeCuenta("CuentaCorrienteBasica", cliente.getRfc())) || (Cuenta.existeCuenta("CuentaCorrienteOro", cliente.getRfc())) || (Cuenta.existeCuenta("CuentaCorrientePlatino", cliente.getRfc()))) {
            System.out.println(Color.ROJO + "\nYa tiene una cuenta corriente" + Color.RESET);
        } else {
            int opcionMenu = 0;
            String[] opciones = {"Crear nueva cuenta corriente basica", "Crear nueva cuenta corriente oro", "Crear nueva cuenta corriente platino", "Volver a menu anterior"};
            double monto;
            while (opcionMenu != opciones.length) {
                opcionMenu = menu(opciones, "MENU CREAR CUENTA CORRIENTE");

                switch (opcionMenu) {
                    case 1:
                        // crea cuenta corriente basica
                        CuentaCorrienteBasica cuentaCB = new CuentaCorrienteBasica(diaActual, cliente.getRfc());
                        System.out.println("\nPara poder abrirla necesitas al menos: $" + cuentaCB.getMontoMinimo());
                        System.out.println("Recuerda que esta cuenta solo puede guardar hasta: $" + cuentaCB.getAlmacenMaximo());
                        monto = captura();
                        System.out.println(Color.ROJO + cuentaCB.apertura(monto, diaActual) + Color.RESET);
                        opcionMenu = opciones.length;
                        break;
                    case 2:
                        // crea cuenta corriente oro
                        CuentaCorrienteOro cuentaCO = new CuentaCorrienteOro(diaActual, cliente.getRfc());
                        System.out.println("\nPara poder abrirla necesitas al menos: $" + cuentaCO.getMontoMinimo());
                        System.out.println("Recuerda que esta cuenta solo puede guardar hasta: $" + cuentaCO.getAlmacenMaximo());
                        monto = captura();
                        System.out.println(Color.ROJO + cuentaCO.apertura(monto, diaActual) + Color.RESET);
                        opcionMenu = opciones.length;
                        break;
                    case 3:
                        // crea cuenta corriente platino
                        CuentaCorrientePlatino cuentaCP = new CuentaCorrientePlatino(diaActual, cliente.getRfc());
                        System.out.println("\nPara poder abrirla necesitas al menos: $" + cuentaCP.getMontoMinimo());
                        System.out.println("Recuerda que esta cuenta no tiene limite de dinero para almacenar");
                        monto = captura();
                        System.out.println(Color.ROJO + cuentaCP.apertura(monto, diaActual) + Color.RESET);
                        opcionMenu = opciones.length;
                        break;
                    case 4:
                        break;
                    default:
                        System.out.println(Color.ROJO + "Esa opcion no existe en el menu, vuelve a intentarlo"  + Color.RESET);
                }
            }
        }
    }


    private static void menuAccederCuentaCorriente() {
        if ((Cuenta.existeCuenta("CuentaCorrienteBasica", cliente.getRfc())) || (Cuenta.existeCuenta("CuentaCorrienteOro", cliente.getRfc())) || (Cuenta.existeCuenta("CuentaCorrientePlatino", cliente.getRfc()))) {
            int opcionMenu = 0;
            String[] opciones = {"Depositar", "Retirar", "Comprar", "Mostrar ultimos 10 movimientos de la cuenta", "Volver a menu anterior"};
            CuentaCorriente cuentaC = null;

            if (Cuenta.existeCuenta("CuentaCorrienteBasica", cliente.getRfc())) {
                cuentaC = new CuentaCorrienteBasica (diaActual, cliente.getRfc());
            } else if (Cuenta.existeCuenta("CuentaCorrienteOro", cliente.getRfc())) {
                cuentaC = new CuentaCorrienteOro (diaActual, cliente.getRfc());
            } else if (Cuenta.existeCuenta("CuentaCorrientePlatino", cliente.getRfc())) {
                cuentaC = new CuentaCorrientePlatino (diaActual, cliente.getRfc());
            }

            double monto;

            while (opcionMenu != opciones.length) {
                cuentaC.leerArchivoCuenta();
                //System.out.println("Dia de apertura de la cuenta: " + cuentaC.getDiaApertura());
                opcionMenu = menu(opciones, "MENU ACCEDER CUENTA CORRIENTE");

                switch (opcionMenu) {
                    case 1:
                        System.out.println("\nPara poder hacer un deposito se necesita al menos: $" + cuentaC.getDepositoMinimo());

                        if (cuentaC.getTipo().equals("CuentaCorrientePlatino")) {
                            System.out.println("Recuerda que esta cuenta no tiene limite de dinero para almacenar");
                        } else {
                            System.out.println("Recuerda que tu cuenta solo puede guardar hasta: $" + cuentaC.getAlmacenMaximo());
                        }

                        monto = captura();
                        cuentaC.depositar(monto);
                        break;
                    case 2:
                        System.out.println("\nPara poder hacer un retiro no se puede exceder: $" + cuentaC.getRetiroMaximo() + " al dia");
                        System.out.println("Hasta ahora has retirado: $" + cuentaC.getRetirosDelDia() + " en el dia");
                        monto = captura();
                        cuentaC.retirar(monto);
                        break;
                    case 3:
                        System.out.println("\nPara poder hacer una compra no se puede exceder: $" + cuentaC.getSaldo());
                        System.out.println("Por cada compra se bonifica el: " + (cuentaC.getBonificacionCompra() * 100) + "%");
                        monto = captura();
                        cuentaC.comprar(monto);
                        break;
                    case 4:
                        System.out.println("\nUltimos 10 movimientos de la cuenta: ");
                        cuentaC.leerArchivoMovimientos();
                        break;
                    case 5:
                        break;
                    default:
                        System.out.println(Color.ROJO + "Esa opcion no existe en el menu, vuelve a intentarlo" + Color.RESET);
                }

            }
        } else {
            System.out.println(Color.ROJO + "No existe una cuenta corriente, crea una primero para utilizarla" + Color.RESET);
        }
    }


    private static void menuAccederCuentaAhorro() {
        if (Cuenta.existeCuenta("CuentaAhorros", cliente.getRfc())) {
            int opcionMenu = 0;
            String[] opciones = {"Depositar", "Retirar", "Mostrar ultimos 10 movimientos de la cuenta", "Volver a menu anterior"};
            CuentaAhorros cuentaA = new CuentaAhorros(diaActual, cliente.getRfc());
            //cuentaA.leerArchivoCuenta();
            double monto;

            while (opcionMenu != opciones.length) {
                cuentaA.leerArchivoCuenta();
                int diasFaltantes = cuentaA.getPeriodo() - ((diaActual - cuentaA.getDiaUltimoMovimiento()) % cuentaA.getPeriodo());
                //System.out.println("\nDia de apertura de la cuenta: " + cuentaA.getDiaApertura());
                System.out.println("\nRecuerda que solo puede realizar operaciones cada: " + cuentaA.getPeriodo() + " dias y faltan " + diasFaltantes + " dias");
                opcionMenu = menu(opciones, "MENU ACCEDER CUENTA DE AHORROS");

                switch (opcionMenu) {
                    case 1:
                        System.out.println("\nPara poder hacer un deposito se necesita al menos: $" + cuentaA.getDepositoMinimo());
                        System.out.println("Recuerda que esta cuenta no tiene limite de dinero para almacenar");                        monto = captura();
                        cuentaA.depositar(monto);
                        break;
                    case 2:
                        System.out.println("\nPara poder hacer un retiro no se puede exceder: $" + cuentaA.getRetiroMaximo() + " al dia");
                        System.out.println("Hasta ahora has retirado: $" + cuentaA.getRetirosDelDia() + " en el dia");
                        monto = captura();
                        cuentaA.retirar(monto);
                        break;
                    case 3:
                        System.out.println("\nUltimos 10 movimientos de la cuenta: ");
                        cuentaA.leerArchivoMovimientos();
                        break;
                    case 4:
                        break;
                    default:
                        System.out.println(Color.ROJO + "Esa opcion no existe en el menu, vuelve a intentarlo" + Color.RESET);
                }
            }
        } else {
            System.out.println(Color.ROJO + "No existe una cuenta de ahorros, crea una primero para utilizarla" + Color.RESET);
        }
    }


    private static void menuAccederCuentaInversion() {
        if (Cuenta.existeCuenta("CuentaInversion", cliente.getRfc())) {
            int opcionMenu = 0;
            String[] opciones = {"Depositar", "Retirar", "Mostrar ultimos 10 movimientos de la cuenta", "Volver a menu anterior"};
            CuentaInversion cuentaI = new CuentaInversion(diaActual, cliente.getRfc());
            cuentaI.leerArchivoCuenta(false);
            double monto;

            while (opcionMenu != opciones.length) {
                cuentaI.leerArchivoCuenta();
                int diasFaltantes = cuentaI.getPeriodo() - ((diaActual - cuentaI.getDiaUltimoMovimiento()) % cuentaI.getPeriodo());
                //System.out.println("\nDia de apertura de la cuenta: " + cuentaI.getDiaApertura());
                System.out.println("\nRecuerda que solo puede realizar operaciones cada: " + cuentaI.getPeriodo() + " dias y faltan " + diasFaltantes + " dias");
                opcionMenu = menu(opciones, "MENU ACCEDER CUENTA DE INVERSION");

                switch (opcionMenu) {
                    case 1:
                        System.out.println("\nPara poder hacer un deposito se necesita al menos: $" + cuentaI.getDepositoMinimo());
                        System.out.println("Recuerda que esta cuenta no tiene limite de dinero para almacenar");                        monto = captura();
                        cuentaI.depositar(monto);
                        break;
                    case 2:
                        System.out.println("\nPara poder hacer un retiro no se puede exceder: $" + cuentaI.getRetiroMaximo() + " al dia");
                        System.out.println("Hasta ahora has retirado: $" + cuentaI.getRetirosDelDia() + " en el dia");
                        monto = captura();
                        cuentaI.retirar(monto);
                        break;
                    case 3:
                        System.out.println("\nUltimos 10 movimientos de la cuenta: ");
                        cuentaI.leerArchivoMovimientos();
                        break;
                    case 4:
                        break;
                    default:
                        System.out.println(Color.ROJO + "Esa opcion no existe en el menu, vuelve a intentarlo" + Color.RESET);
                }

            }
        } else {
            System.out.println(Color.ROJO + "No existe una cuenta de inversion, crea una primero para utilizarla" + Color.RESET);
        }
    }


    private static void menuCaracteristicas() {
        System.out.println();
        System.out.println("CARACTERISTICAS CUENTAS");

        CuentaCorrienteBasica cuentaCB = new CuentaCorrienteBasica(diaActual, cliente.getRfc());
        System.out.println(cuentaCB);

        CuentaCorrienteOro cuentaCO = new CuentaCorrienteOro(diaActual, cliente.getRfc());
        System.out.println(cuentaCO);

        CuentaCorrientePlatino cuentaCP = new CuentaCorrientePlatino(diaActual, cliente.getRfc());
        System.out.println(cuentaCP);

        CuentaAhorros cuentaA = new CuentaAhorros(diaActual, cliente.getRfc());
        System.out.println(cuentaA);

        CuentaInversion cuentaI = new CuentaInversion(diaActual, cliente.getRfc());
        System.out.println(cuentaI);

        System.out.println();
    }


    private static void obtenerRendimientos() {
        if (Cuenta.existeCuenta("CuentaInversion", cliente.getRfc())) {
            CuentaInversion cuentaI = new CuentaInversion(diaActual, cliente.getRfc());
            cuentaI.leerArchivoCuenta(false);
            if ((diaActual - cuentaI.getDiaUltimoMovimiento()) % cuentaI.getPeriodo() == 0) {
                /*cuentaI.setSaldo(cuentaI.getSaldo() + (cuentaI.getSaldo() * cuentaI.getPorcentajeRendimientos()));
                cuentaI.grabarArchivoMovimientos("Obtencion de rendimientos", (cuentaI.getSaldo() * cuentaI.getPorcentajeRendimientos()));

                 */
                cuentaI.obtenerRendimientos();
            }
        }
    }


    private static double captura() {
        double monto = -1;
        while (monto < 0) {
            try {
                System.out.println();
                System.out.print("Monto: ");
                monto = teclado.nextDouble();
                teclado.nextLine();

                if (monto < 0) {
                    System.out.println(Color.ROJO + "\nSolo acepto valores doubles (reales) positivos, vuelve a intentarlo");
                    System.out.print("Da <Enter> para continuar " + Color.RESET);
                    teclado.nextLine();
                }
            } catch (InputMismatchException e) {
                System.out.println(Color.ROJO + "\nSolo acepto valores doubles (reales) positivos, vuelve a intentarlo");
                System.out.print("Da <Enter> para continuar " + Color.RESET);
                teclado.nextLine();
                teclado.nextLine();
            }
        }
        return monto; // solo regresa cuando dan un valor double positivo
    }

} // cierra el class
