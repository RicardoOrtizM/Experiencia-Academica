

import java.io.*; // Para usar la clase File
import java.util.*; // Para usar la clase Scanner

/**
 * Clase Persona
 * @author Ricardo Ortiz Meza
 * @version "Java 19.0.2"
 */
public class Persona {
    // Atributos
    private String nombre;
    private String apellidoPaterno;
    private String apellidoMaterno;
    private String fechaNacimiento;
    private String rfc;

    /**
     * M&eacute;todo constructor con par&aacute;metros de entrada, que calcula el RFC de la persona dentro de este.
     * @param num  - Crea una persona ya establecida en el archivo "Cliente.csv", sino existe dicho documento lo crea
     */
    public Persona (int num) {
        File miArchivo = new File("Cliente.csv"); //crea el archivo con ese nombre y extension
        if (!(miArchivo.exists())) {
            crearArchivoPersona();
        }
        try {
            //Scanner archivo = new Scanner (new File ("Cliente.csv")); // abre el archivo
            /*File x = new File ("ClienteROM.csv");
            x.createNewFile();
            System.out.println(x.exists());*/
            Scanner archivo = new Scanner(new File("Cliente.csv")); // abre el archivo
            //archivo.nextLine(); // lee una linea del archivo
            this.nombre = archivo.nextLine();
            this.apellidoPaterno = archivo.nextLine();
            this.apellidoMaterno = archivo.nextLine();
            this.fechaNacimiento = archivo.nextLine();
            this.rfc = calculoRFC(this.nombre, this.apellidoPaterno, this.apellidoMaterno, this.fechaNacimiento);
            //this.rfc = archivo.nextLine();
        } catch (Exception e) {
            System.out.println("Error en la lectura, ese mensaje no se puede leer porque no existe: " + e); // ponemos el objeto e para obtener mas info
        }
    }

    private void crearArchivoPersona() {
        try {
            File miArchivo = new File("Cliente.csv"); //crea el archivo con ese nombre y extension
            FileWriter fileWriter = new FileWriter(miArchivo); // abre el archivo recien creado como de escritura
            BufferedWriter bW = new BufferedWriter(fileWriter); // este es el que permite grabar en el archivo que se creo y abrio
            // Nombre de la persona
            bW.write("Margarito\n"); // un write por cada linea que quieres que se guarde
            // Apellido Paterno
            bW.write("Santos\n"); // un write por cada linea que quieres que se guarde
            // Apellido Materno
            bW.write("Kentucky\n"); // un write por cada linea que quieres que se guarde
            // Fecha de Nacimiento
            bW.write("14/03/1989\n"); // un write por cada linea que quieres que se guarde
            bW.close(); // es para cerrar el archivo
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * M&eacute;todo constructor con par&aacute;metros de entrada, que calcula el RFC de la persona dentro de este.
     * @param nombre - Nombre de la persona.
     * @param apellidoPaterno - Apellido paterno de la persona.
     * @param apellidoMaterno - Apellido materno de la persona.
     * @param fechaNacimiento - Fecha de nacimiento de la persona.
     */
    public Persona (String nombre, String apellidoPaterno, String apellidoMaterno, String fechaNacimiento) {
        this.nombre = nombre.trim();
        this.apellidoPaterno = apellidoPaterno.trim();
        this.apellidoMaterno = apellidoMaterno.trim();
        this.fechaNacimiento = fechaNacimiento.trim();
        this.rfc = calculoRFC(this.nombre, this.apellidoPaterno, this.apellidoMaterno, this.fechaNacimiento);
    }

    private String calculoRFC (String nombre, String apellidoPaterno, String apellidoMaterno, String fechaNacimiento) {

        // NombreCompleto: nombre, apellidoPaterno apellidoMaterno
        nombre = nombre.toUpperCase(); // Pone en mayusculas lo que tenga nombre
        apellidoPaterno = apellidoPaterno.toUpperCase(); // Pone en mayusculas lo que tenga apellidoPaterno
        apellidoMaterno = apellidoMaterno.toUpperCase(); // Pone en mayusculas lo que tenga apellidoMaterno

        /*System.out.println ();
        System.out.println ("Nombre(s): " + nombre);
        System.out.println ("Apellido paterno: " + apellidoPaterno);
        System.out.println ("Apellido materno: " + apellidoMaterno);
        */

        String primerLetra1rApellido = apellidoPaterno.substring(0, 1); // extrae la primer letra del primer apellido
        String rfc = primerLetra1rApellido; // para ir calculando el rfc

        String vocales = "AEIOU";
        //                01234
        String vocal = "";
        int caracterVocal = 0;
        int primerVocal = apellidoPaterno.length();

        for (int i=0; i < 5; i++) { // busca la primer vocal interna, recorre 5 veces, ya que es la cantidad de vocales
            vocal = vocales.substring(i, (i+1));
            caracterVocal = apellidoPaterno.substring(1).indexOf(vocal); // pues es la primera vocal interna del primer apellido

            if (caracterVocal >= 0) {
                primerVocal = Math.min(primerVocal, caracterVocal); // calcula el mínimo entre el numero de caracter del primer espacio y el numero de caracter de la coma y lo guarda en la variable "primero"
            }
        }

        String primerVocal1rApellido = apellidoPaterno.substring(1).substring(primerVocal, (primerVocal + 1)); // pues es la primera vocal interna del primer apellido
        rfc += primerVocal1rApellido;

        String primerLetra2oApellido = apellidoMaterno.substring(0, 1); // extrae la primer letra del segundo apellido
        rfc += primerLetra2oApellido;

        String primerLetraNombre = nombre.substring(0, 1); // extrae la primer letra del nombre
        rfc += primerLetraNombre;

        // d d / m m / a a a a
        // 0 1 2 3 4 5 6 7 8 9
        String anioNacimiento = fechaNacimiento.substring(8, 10); // obtiene los ultimos 2 digitos del año de nacimiento, el .substring extrae el fragmento de caracteres entre el 8 y un numero antes del 10, es decir, caracteres 8 y 9
        rfc += anioNacimiento;
        String mesNacimiento = fechaNacimiento.substring(3, 5); // obtiene los ultimos 2 digitos del mes de nacimiento, el .substring extrae el fragmento de caracteres entre el 3 y un numero antes del 5, es decir, caracteres 3 y 4
        rfc += mesNacimiento;
        String diaNacimiento = fechaNacimiento.substring(0, 2); // obtiene los ultimos 2 digitos del dia de nacimiento, el .substring extrae el fragmento de caracteres entre el 0 y un numero antes del 2, es decir, caracteres 0 y 1
        rfc += diaNacimiento;

        return rfc;
    }

    /**
     * M&eacute;todo getNombre()
     * <br>M&eacute;todo de acceso al nombre de la persona.
     * @return String - Nombre de la persona.
     */
    public String getNombre() {
        return this.nombre;
    }

    /**
     * M&eacute;todo getApellidoPaterno()
     * <br>M&eacute;todo de acceso al apellido paterno de la persona.
     * @return String - Apellido paterno de la persona.
     */
    public String getApellidoPaterno() {
        return this.apellidoPaterno;
    }

    /**
     * M&eacute;todo getApellidoMaterno()
     * <br>M&eacute;todo de acceso al apellido materno de la persona.
     * @return String - Apellido materno de la persona.
     */
    public String getApellidoMaterno() {
        return this.apellidoMaterno;
    }

    /**
     * M&eacute;todo getFechaNacimiento()
     * <br>M&eacute;todo de acceso a la fecha de nacimiento de la persona.
     * @return String - Fecha de nacimiento de la persona.
     */
    public String getFechaNacimiento() {
        return this.fechaNacimiento;
    }

    /**
     * M&eacute;todo getRfc()
     * <br>M&eacute;todo de acceso al RFC de la persona.
     * @return String - RFC de la persona.
     */
    public String getRfc() {
        return this.rfc;
    }

    /**
     * M&eacute;todo equals(Object obj)
     * <br>M&eacute;todo que verifica si dos personas son iguales.
     * @param obj - Objeto con el cual se va a comparar.
     * @return boolean - "true" si los dos objetos son iguales, "false" en otro caso.
     */
    @Override
    public boolean equals(Object obj) {
        boolean iguales = false;

        if (obj instanceof Persona) {
            Persona nuevaPersona = (Persona) obj;
            String nombreN = nuevaPersona.getNombre();
            String apellidoPaternoN = nuevaPersona.getApellidoPaterno();
            String apellidoMaternoN = nuevaPersona.getApellidoMaterno();
            String fechaNacimientoN = nuevaPersona.getFechaNacimiento();
            String rfcN = nuevaPersona.getRfc();

            if ((this.nombre.equals(nombreN)) && (this.apellidoPaterno.equals(apellidoPaternoN)) && (this.apellidoMaterno.equals(apellidoMaternoN)) && (this.fechaNacimiento.equals(fechaNacimientoN)) && (this.rfc.equals(rfcN))) {
                iguales = true;
            }
        }

        return iguales;
    }

    /**
     * M&eacute;todo toString()
     * <br>M&eacute;todo que devuelve una persona en formato de cadena.
     * @return String - Persona en formato de cadena.
     */
    @Override
    public String toString() {
        String cadena = "\n\tNombre: " + this.nombre + " " + this.apellidoPaterno + " " + this.apellidoMaterno;
        cadena += "\n\tFecha de nacimiento: " + this.fechaNacimiento;
        cadena += "\n\tRFC: " + this.rfc;

        return cadena;
    }
}
