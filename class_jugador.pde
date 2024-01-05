class Jugador {
  float x, y, vel;
  float diametroColision = 15;

  Jugador() {
    this.x = almaX;
    this.y = almaY;
    this.vel = 7;   
  }

  void dibuja() {   
    // Dibujar el área de colisión
    //fill(255);
    //noStroke();
    //ellipse(this.x + 10, this.y + 10, diametroColision, diametroColision); 

    // Dibujar la imagen del jugador
    image(alma, this.x, this.y);
    //print(this.x, this.y); la usaba para calcular todo lo relacionado con el cuadro de combate
  }

  boolean colisionConBola(float bolaX, float bolaY) {
    // Calcular la distancia entre el centro del jugador y el centro de la bola
    float distancia = dist(this.x + 10, this.y + 10, bolaX, bolaY);

    // Verificar si la distancia es menor que el radio del área de colisión
    return distancia < diametroColision / 2;
  }

  boolean colisionConRectangulo(float rectanguloX, float rectanguloY, float anchoRectangulo, float altoRectangulo) {
    // Verificar si el jugador colisiona con el rectángulo
    // La colision necesita un ajuste de +10 en las coordenadas para ser mas o menos correcta
    return this.x + 10 < rectanguloX + anchoRectangulo &&
           this.x + 10 + diametroColision > rectanguloX &&
           this.y + 10 < rectanguloY + altoRectangulo &&
           this.y + 10 + diametroColision > rectanguloY;
  }
}
