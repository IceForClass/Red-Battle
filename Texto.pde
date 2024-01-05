// Array para almacenar objetos Frase
Frase[] arrayFrases;

void frases() {
  // Inicializa el array con objetos Frase
  arrayFrases = new Frase[16]; // Puedes ajustar el tamaño según sea necesario

  // Llena el array con instancias de Frase
  // Cada vez que se ataca se suma 1 a turnoAtaque por lo que 0 no tendrá ataque asignado
  arrayFrases[0] = new Frase("*Red se interpone en tu camino.");  
  arrayFrases[1] = new Frase("*Red te juzga con la mirada."); // Ataque de uno de los centinelas
  arrayFrases[2] = new Frase("*Un escalofrío recorre tu espalda"); // Ataque de Red
  arrayFrases[3] = new Frase("*Red parece darles una instrucción a los \nCentinelas"); //Ataque de los Centinelas
  arrayFrases[4] = new Frase("*Parece que los Centinelas traman algo");  // Ataque de Red
  arrayFrases[5] = new Frase("*Red empieza a tomárselo enserio"); // Ataque doble de los centinelas
  arrayFrases[6] = new Frase("*Escuchas un suspiro provenir de Red"); // Ataque de Red ampliado
  arrayFrases[7] = new Frase("*Red ríe nerviosamente"); // Ataque doble de los centinelas
  arrayFrases[8] = new Frase("*Red prepara su ataque especial"); // Ataque especial de Red compuesto por el de Centinelas y el mismo
  arrayFrases[9] = new Frase("*Acaba con esto =)"); // Se acaba el combate


  // Reservados para las descripciones de los ataques
  arrayFrases[10] = new Frase("*RED--ATK:8 DEF:4 \n*Simplemente otro guardia real");
  arrayFrases[11] = new Frase("*Debiste traer más comida");
  arrayFrases[12] = new Frase("*Red niega con la cabeza");

  arrayFrases[13] = new Frase("*Comes los fideos instantáneos \n*Recuperas 20Hp");
  arrayFrases[14] = new Frase("*Ese último trozo de tarta estaba rico \n*Recuperas 20Hp");
  arrayFrases[15] = new Frase("*No sabes que es, pero lo comes igual \n*Recuperas 20Hp");


  arrayFrases[turnoAtaque].mostrar(80, 365);
}

// Clase para representar una frase
class Frase {
  String contenido; // Contenido de la frase

  Frase(String contenido) {
    this.contenido = contenido;
  }

  // Método para mostrar la frase en una posición específica
  void mostrar(int x, int y) {
    fill(255);
    textAlign(LEFT, CENTER);
    text(contenido, x, y);
  }
}
