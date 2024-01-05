// Cantidad máxima de ceniza que cae en el menú
int maxCenizas = 50;

ceniza[] LluviaCeniza = new ceniza[maxCenizas];

void lluvia() {
  if (menu == true) {
    // Si esto se elimina, la lluvia dejará rastro
    background(Background);

    // Controla la cantidad de cenizas en pantalla
    int nuevasCenizas = min(maxCenizas - contarCenizas(), 1);

    // Controla la lluvia de ceniza en el menú
    for (int i = 0; i < nuevasCenizas; i++) {
      agregarCeniza();
    }

    // Muestra y actualiza las partículas de ceniza
    for (int i = 0; i < LluviaCeniza.length; i++) {
      // Cuando la posición del aray es distinta de null añadimos una nueva ceniza
      if (LluviaCeniza[i] != null) {
        LluviaCeniza[i].caida();
        LluviaCeniza[i].display();
        // Si la ceniza está fuera de la pantalla, la eliminamos
       if (LluviaCeniza[i].fueraDePantalla()) {
          LluviaCeniza[i] = null;
        }
      }
    }
  }
}

// Necesitamos contar la ceniza para no pasarnos en el array
int contarCenizas() {
  int contador = 0;
  for (int i = 0; i < LluviaCeniza.length; i++) {
    if (LluviaCeniza[i] != null) {
      contador++;
    }
  }
  return contador;
}

// Función para agregar una nueva ceniza al array
void agregarCeniza() {
  for (int i = 0; i < LluviaCeniza.length; i++) {
    if (LluviaCeniza[i] == null) {
      LluviaCeniza[i] = new ceniza();
    }
  }
}

// Clase para representar partículas de ceniza
class ceniza {
  float x, y;
  float speed;

  // Propiedades del movimiento y donde spawnea de la ceniza
  ceniza() {
    x = random(width);
    y = 0;
    speed = random(2, 10);
  }

  // Caida de la ceniza
  void caida() {
    y = y + speed;
  }

  void display() {
    fill(200);
    noStroke();
    ellipse(x, y, 5, 5);
  }

  boolean fueraDePantalla() {
    return y > height;
  }
}
