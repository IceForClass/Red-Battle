// Cargar la imagen del game over
PImage gameOverScreen;

void gameOver() {
  if (finCombate == true) {
    loop();
    teclaGameOver();
    noCursor();
    gameOverScreen = loadImage("imagenes/GameOver.jpg");
    background(0);
    image(gameOverScreen, 100, -30);
    //println(mouseX, mouseY);
    text("Presiona 'X' para reintentar", 200, 400);
    text("Presiona 'C' para volver al menú", 200, 450);
  }
}


void teclaGameOver() {
  if (finCombate == true) {
    // Reinicia el juego al presionar la tecla "X"
    if (key == 'X' || key == 'x') {
      reiniciarVariables();
      reiniciarAtaqueRectangulo();
      recuperacion = 0;
      GameOver.stop();
      vida = maxVida;
      vidaRed = vidaRedMax;
      turnoJugador = true;
      menuPelea = true;
      turnoAtaque = 0;
      finCombate = false;
      combate = true;
      victoria = false;
      musicaBatalla();
      turnoAtaque = 0;
      reinicioVariableRectangulo();
      reiniciarAtaqueBolas();
      combate();
    }
    if (key == 'C' || key == 'c') {
      GameOver.stop();
      recuperacion = 0;
      vida = maxVida;
      turnoJugador = true;
      vidaRed = vidaRedMax;
      menuPelea = true;
      turnoAtaque = 0;
      reinicioVariableRectangulo();
      reiniciarAtaqueBolas();
      finCombate = false;
      victoria = false;
      menu = true;
      turnoAtaque = 0;
      musicaMenu.loop();
      loop();
    }
  }
}
