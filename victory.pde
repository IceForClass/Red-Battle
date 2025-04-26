// Cargar la imagen de la pantalla de victoria
boolean victoria = false;

// Animar a red
int totalFramesVictory = 11;  // Número total de cuadros en la animación
int currentFrameVictory = 0;  // Cuadro actual
PImage[] imagenesVictory = new PImage[totalFramesVictory];

void victoria() {
  if (victoria == true) {
    teclaVictoria();
    noCursor();
    background(0);
    animarRedVictory();
    //println(mouseX, mouseY);
    text("Victoria, ¡Venciste a Red!", 250, 50);
    text("Presiona 'X' para jugar de nuevo", 200, 400);
    text("Presiona 'C' para volver al menú", 200, 450);
  }
}


void teclaVictoria() {
  if (finCombate == true) {
    if (key == 'X' || key == 'x') {
      victory.pause();
      recuperacion = 0;
      vida = maxVida;
      reinicioVariableRectangulo();
      reiniciarAtaqueBolas();
      finCombate = false;
      victoria = false;
      vidaRed = vidaRedMax;
      turnoJugador = true;
      turnoAtaque = 0;
      turnoCombate = 0;
      musicaBatalla();
      combate();
    }
    if (key == 'C' || key == 'c') {
      victory.pause();
      recuperacion = 0;
      vida = maxVida;
      reinicioVariableRectangulo();
      reiniciarAtaqueBolas();
      finCombate = false;
      victoria = false;
      menu = true;
      vidaRed = vidaRedMax;
      turnoJugador = true;
      turnoAtaque = 0;
      turnoCombate = 0;
      musicaMenu.loop();
      loop();
    }
  }
}


void animarRedVictory() {
  PImage redAnimation = imagenesVictory[currentFrameVictory];

  // Dibujar la imagen en pantalla
  image(redAnimation, 320, 65);

  // Incrementar el frame actual para la próxima iteración
  currentFrameVictory++;

  // Si has alcanzado el último frame, reinicia la animación
  if (currentFrameVictory >= totalFramesVictory) {
    currentFrameVictory = 0;
  }
}
