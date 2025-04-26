// Esta sección sinceramente la hizo ChatGpt, fuí incapaz de hacer que la bola colisionase con el rectángulo.

ArrayList<Rectangulo> ataqueRectangulo;
int totalRectangulosGenerados = 0;
int maxRectangulosEnPantalla = 10;
int maxRectangulosGenerados = 50;

void reinicioVariableRectangulo() {
  totalRectangulosGenerados = 0;
  maxRectangulosEnPantalla = 10;
  maxRectangulosGenerados = 50;
}

void reiniciarAtaqueRectangulo() {
  ataqueRectangulo.clear();
  totalRectangulosGenerados = 0;

  if (vidaRed <= vidaRedMax/2 && vidaRed > vidaRedMax/4) {
    maxRectangulosEnPantalla = 15;
    maxRectangulosGenerados = 100;
  } else if (vidaRed <= vidaRedMax/4) {
    maxRectangulosEnPantalla = 20;
    maxRectangulosGenerados = 200;
  }

  for (int i = 0; i < min(maxRectangulosEnPantalla, maxRectangulosGenerados); i++) {
    boolean izquierda = random(2) < 1;
    ataqueRectangulo.add(new Rectangulo(izquierda));
    totalRectangulosGenerados++;
  }
}

void AtaqueRectangulos() {
  for (int i = 0; i < ataqueRectangulo.size(); i++) {
    Rectangulo r = ataqueRectangulo.get(i);
    r.mover();
    r.dibujar();

    if (almaPlayer.colisionConRectangulo(r.x, r.y, r.anchoAtaqueCuadrado, r.altoAtaqueCuadrado)) {
      vida -= 4;
      golpe.play();
      ataqueRectangulo.remove(i);
      totalRectangulosGenerados--;
    }
  }

  for (int i = ataqueRectangulo.size() - 1; i >= 0; i--) {
    Rectangulo r = ataqueRectangulo.get(i);
    if (estaFueraDeRangoY(r.y) || r.x > width || r.x + r.anchoAtaqueCuadrado < 0) {
      ataqueRectangulo.remove(i);
    }
  }

  if (totalRectangulosGenerados >= maxRectangulosGenerados) {
    reiniciarAtaqueRectangulo();
    boton = ultimoBoton;
    turnoJugador = true;
    menuPelea = true;
  } else {
    if (ataqueRectangulo.size() < maxRectangulosEnPantalla) {
      boolean izquierda = random(2) < 1;
      ataqueRectangulo.add(new Rectangulo(izquierda));
      totalRectangulosGenerados++;
    }
  }
}

class Rectangulo {
  float x, y, anchoAtaqueCuadrado, altoAtaqueCuadrado, velocidadX, velocidadY;
  float velocidadMinimaX = 6;
  float velocidadMaximaX = 14;

  Rectangulo(boolean izquierda) {
    if (izquierda) {
      x = -10;
    } else {
      x = width;
    }
    y = generarCoordenadaY();
    anchoAtaqueCuadrado = 15;
    altoAtaqueCuadrado = 4;

    if (izquierda) {
      velocidadX = random(velocidadMinimaX, velocidadMaximaX);
    } else {
      velocidadX = random(-velocidadMaximaX, -velocidadMinimaX);
    }
    velocidadY = 0;
  }

  void mover() {
    x += velocidadX;
    y += velocidadY;
  }

  void dibujar() {
    fill(255, 0, 0);
    noStroke();
    rect(x, y, anchoAtaqueCuadrado, altoAtaqueCuadrado);
  }

  float generarCoordenadaY() {
    float coordenadaY;
    do {
      coordenadaY = random(height);
    } while (estaFueraDeRangoY(coordenadaY));
    return coordenadaY;
  }

  float calcularArea() {
    return anchoAtaqueCuadrado * altoAtaqueCuadrado;
  }
}

boolean estaFueraDeRangoY(float coordenadaY) {
  return coordenadaY < 230 || coordenadaY > 430;
}
