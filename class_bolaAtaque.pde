int totalBolas = 250;
ArrayList<BolaAtaque> bolasAtaque = new ArrayList<BolaAtaque>();
int bolasSalidas = 0;

void reiniciarVariables() {
  if (vidaRed > vidaRedMax/2) {
    totalBolas = 250;
  } else if (vidaRed <= vidaRedMax/2) {
    totalBolas = 400;
  }
  bolasAtaque.clear();
  bolasSalidas = 0;
}

void reiniciarAtaqueBolas() {
  totalBolas = 250;
}

void manejarBolasAtaque() {
  for (int i = bolasAtaque.size() - 1; i >= 0; i--) {
    BolaAtaque bolaAtaque = bolasAtaque.get(i);
    bolaAtaque.mover();
    bolaAtaque.mostrar();

    if (almaPlayer.colisionConBola(bolaAtaque.x, bolaAtaque.y)) {
      vida -= 4;
      golpe.play();
      golpe.rewind();
      bolasAtaque.remove(i);
      bolasSalidas++;
    }

    if (bolaAtaque.fueraDePantalla()) {
      bolasAtaque.remove(i);
      bolasSalidas++;

      if (bolasSalidas >= totalBolas && turnoAtaque != 9) {
        boton = ultimoBoton;
        turnoJugador = true;
        menuPelea = true;
      }
    }
  }

  if (bolasAtaque.size() < totalBolas && bolasSalidas < totalBolas) {
    bolasAtaque.add(new BolaAtaque());
  }
}

class BolaAtaque {
  float x, y;
  float radio;
  float velocidad;
  float direccion;
  float velocidadRadio;

  float alternador = random(5);

  BolaAtaque() {
    radio = 0;
    direccion = random(TWO_PI);
    velocidad = random(0.0005, 0.02);
    velocidadRadio = 2;
  }

  void mover() {
    direccion += velocidad;
    if (turnoCombate%2 != 0 && vidaRed > vidaRedMax/2) {
      x = 177 + cos(direccion) * radio;
    } else if (vidaRed <= vidaRedMax/2 && alternador > 2) {
      x = 177 + cos(direccion) * radio;
    } else if (vidaRed <= vidaRedMax/2 && alternador < 2) {
      x = 630 + cos(direccion) * radio;
    } else {
      x = 630 + cos(direccion) * radio;
    }
    y = 166 + sin(direccion) * radio;
    radio += velocidadRadio;
  }

  void mostrar() {
    fill(255, 0, 0);
    noStroke();
    circle(x, y, 10);
  }

  boolean fueraDePantalla() {
    return x < 0 || x > width || y < 0 || y > height;
  }

  float calcularArea() {
    return PI * radio * radio;
  }
}
