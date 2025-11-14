/**
 * Enumeracion Color
 * @author Ricardo Ortiz Meza
 * @version "Java 19.0.2"
*/
public enum Color {

	/** Reiniciar el color**/ RESET("\u001B[0m"), 
	/** Color ROJO**/ ROJO("\u001B[31m"), 
	/** Color NEGRO **/ NEGRO("\u001B[30m"), 
	/** Color AZUL **/ AZUL("\u001B[34m"), 
	/** Color VERDE **/ VERDE("\u001B[32m"), 
	/** Color AMARILLO **/ AMARILLO("\u001B[33m"), 
	/** Color MAGENTA **/ MAGENTA("\u001B[35m"), 
	/** Color CYAN **/ CYAN("\u001B[36m"), 
	/** Color BLANCO **/ BLANCO("\u001B[37m"); 

	// Atributos
	private String codigo;

	// Metodos

	/**
     * M&eacute;todo constructor que recibe como par&aacute;metro un String con el codigo del color.
     * @param codigo - Codigo del color.
    */
	private Color (String codigo) {
		// El constructor va sin public, private ni protected porque es enum
		this.codigo = codigo;
	}

	/**
     * M&eacute;todo toString()
     * <br>M&eacute;todo que devuelve un color en formato de cadena.
     * @return String - Color en formato de cadena.
    */
	public String toString() {
		return (this.codigo);
	}

}