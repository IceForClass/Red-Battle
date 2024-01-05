// Aqui tenemos toda la logica de la pantalla del combate, es demasiado largo e ineficiente la verdad

// Todas las propiedades de los botones
// Llamarlos
PImage fight;
PImage fight2;
PImage act;
PImage act2;
PImage item;
PImage item2;
PImage mercy;
PImage mercy2;
PImage alma;

// Animar a red
int totalFrames = 44;  // Número total de imágenes en la animación
int currentFrame = 0;
PImage[] redImagen = new PImage[totalFrames];

int totalFramesHard = 25;
int currentFrameHard = 0;
PImage[] redHard = new PImage[totalFramesHard];

// Posición
int fightX = 83;
int botonY = 490;

// Posición del alma en batalla
int almaX = 390;
int almaY = 360;
int almaXOriginal = 390;
int almaYOriginal = 360;
float centinelaY = 75;
float speed = 0.3;

// Comportamiento
int boton = 1;
int tiempoEspera = 200;
int recuperacion = 0;
int objetoCurativo = 20;

// Turnos
int turnoAtaque;
int turnoCombate;

// Controlar el combate
boolean turnoJugador = true;
boolean finCombate = false;
boolean menuPelea = true;

// La vida en el combate
int vida = 60;
int maxVida = 60; // Para no sobrepasar este límite de vida

// Vida de red
int vidaRed = 180;
int vidaRedMax = 180;

void combate() {
  if (combate == true && finCombate == false) {
    // Vuelve a aparecer el cursor normal
    cursor();
    background(0);

    botones();

    // println(mouseX, mouseY); lo usaba para colocar las cosas
    /*
     text("Combate", width/2, height/2);
     Fue lo primero que puse, le tengo cariño
     */
  } else if (finCombate == true ) {
    if (vida <= 0) {
      musicaBatalla.pause();
      GameOver.play();
      gameOver();
    } else {
      musicaBatalla.pause();
      victory.play();
      victoria();
    }
  }
}


void musicaBatalla() {
  // Inicializar la música de la batalla
  minim = new Minim(this);
  musicaBatalla = minim.loadFile("musica/RedThemeBatlle.mp3");
  musicaBatalla.loop();
}

void botones() {
  if (finCombate == false) {
    // Mueve y muestra cada rayo
    for (int i = 0; i < numRayos; i++) {
      rayos[i].caer();
      rayos[i].mostrar();
    }

    // Nv 11 = 60hp siguiendo la logica del juego en el que me baso
    fill(255);
    text("Nv 11", 100, 460);

    // Palabras de la vida
    fill(255);
    text("Life", 280, 460);
    text(vida+"/"+maxVida, 540, 460);

    // Barra para la vida
    if (vida >= maxVida/2) {
      fill(0, 255, 0);
    } else if (vida >= maxVida/3) {
      fill(255, 255, 0);
    } else {
      fill(255, 0, 0);
    }
    noStroke();
    rect(350, 450, vida*3, 20);

    // Dibujar a Red y sus centinelas
    animarRed();
    image(centinela, 70, centinelaY);
    image(centinela, 530, centinelaY);

    // Mueve a los centinelas hacia arriba o hacia abajo para simular una minima animacion
    centinelaY = centinelaY + speed;
    // Cambia la dirección de los centinelas
    if (centinelaY <= 75 || centinelaY >= 90) {
      speed *= -1;
    }

    // Barra de la vida de Red
    fill(255, 0, 0);
    text("Red", 10, 20);
    fill(255, 0, 0);
    stroke(255);
    rect(10, 40, vidaRed, 15);
  }

  if (turnoJugador) {
    moverMenu();
    // Dibujar botones
    // Boton de pelea
    if (boton != 1) {
      image(fight, fightX, botonY);
    } else {
      image(fight2, fightX, botonY);
      image(alma, fightX+5, botonY+8);
    }
    // Boton de actuar
    if (boton != 2) {
      image(act, fightX+170, botonY);
    } else {
      image(act2, fightX+170, botonY);
      image(alma, fightX+175, botonY+8);
    }
    // Boton de objetos
    if (boton != 3) {
      image(item, fightX+340, botonY);
    } else {
      image(item2, fightX+340, botonY);
      image(alma, fightX+345, botonY+8);
    }
    // Boton de piedad
    if (boton != 4) {
      image(mercy, fightX+510, botonY);
    } else {
      image(mercy2, fightX+510, botonY);
      image(alma, fightX+515, botonY+8);
    }
    // Rectángulo del menú
    fill(0);
    strokeWeight(3);
    stroke(255);
    rect(50, 335, 680, 100);
    // Llamar a las frases para el combate
    frases();
  } else {
    // Rectángulo del combate
    fill(0);
    strokeWeight(3);
    stroke(255);
    rect(290, 230, 220, 200);
    // Mantener todo para el turno del rival, pero todo en su estado original ya que el boton no deberia estar seleccionado
    image(fight, fightX, botonY);
    image(act, fightX+170, botonY);
    image(item, fightX+340, botonY);
    image(mercy, fightX+510, botonY);
    // Llamamos a la función para poder movernos en batalla
    movimientoBatalla();
    boton = 0;
  }
  // Control de vida del jugador
  if (vida > 60) {
    vida = 60;
  }
  if (vida <= 0) {
    vida = 0;
    musicaBatalla.pause();
    finCombate = true;
  }
  // Controlar la vida de Red
  if (vidaRed <= 0) {
    musicaBatalla.pause();
    finCombate = true;
    victoria = true;
  }
}

// Tiempo de espera para que el menú no vuele
int tiempoEsperaGlobal = 200;
int ultimoTiempo;
// Esto se usará para todos los botones diferentes al de atacar
boolean ejecutarBotonesEspeciales = false;
int tiempoInicioEspera = -1;
int tiempoTranscurrido;
int ultimoBoton;

// Lógica para movernos por el menú
void moverMenu() {
  if (turnoJugador && menuPelea) {
    tiempoTranscurrido = millis() - ultimoTiempo;
    if (tiempoTranscurrido > tiempoEsperaGlobal) {
      if (keyPressed) {
        if (keyCode == LEFT) {
          boton--;
          if (boton < 1) {
            boton = 4;
          }
        } else if (keyCode == RIGHT) {
          boton++;
          if (boton > 4) {
            boton = 1;
          }
        }
        ultimoTiempo = millis();
        if (key == 'F' || key == 'f') {
          vida -= 40;
        }
        // Sonido cada vez que te mueves de un botón para otro en el menú
        if (keyCode == LEFT || keyCode == RIGHT) { // Si no ponemos esto sonará con cualquier tecla
          // Si no se reinicia solo suena una vez
          Sonidoboton.rewind();
          Sonidoboton.play();
        }
        if (boton == 1 && key == 'z' || boton == 1 && key == 'Z') {
          ultimoBoton = boton;
          turnoAtaque++;
          turnoCombate++;
          vidaRed = vidaRed - 18;
          reiniciarVariables();
          turnoJugador = false;
          if (vidaRed <= 0) {
            vidaRed = 0;
          }
        }
        if (boton == 2 && key == 'z' || boton == 2 && key == 'Z') {
          turnoCombate = turnoAtaque;
          turnoAtaque = 10;
          menuPelea = false;
          tiempoInicioEspera = millis(); // Inicia el temporizador
          ejecutarBotonesEspeciales = true;
        }
        if (boton == 3 && key == 'z' || boton == 3 && key == 'Z') {
          if (recuperacion == 0) {
            vida = vida + objetoCurativo;
            turnoCombate = turnoAtaque;
            turnoAtaque = 13;
            recuperacion++;
          } else if (recuperacion == 1) {
            vida = vida + objetoCurativo;
            turnoCombate = turnoAtaque;
            turnoAtaque = 14;
            recuperacion++;
          } else if (recuperacion == 2) {
            vida = vida + objetoCurativo;
            turnoCombate = turnoAtaque;
            turnoAtaque = 15;
            recuperacion++;
          } else {
            turnoCombate = turnoAtaque;
            turnoAtaque = 11;
          }
          menuPelea = false;
          tiempoInicioEspera = millis(); // Inicia el temporizador
          ejecutarBotonesEspeciales = true;
        }
        if (boton == 4 && key == 'z' || boton == 4 && key == 'Z') {
          turnoCombate = turnoAtaque;
          turnoAtaque = 12;
          menuPelea = false;
          tiempoInicioEspera = millis(); // Inicia el temporizador
          ejecutarBotonesEspeciales = true;
        }
      }
    }
  }
  // Botones especiales, es decir, todos los que no sean de atacar
  if (ejecutarBotonesEspeciales && millis() - tiempoInicioEspera > tiempoEspera+500) {
    botonesEspeciales();
    ejecutarBotonesEspeciales = false;
  }
}

void animarRed() {
  if (vidaRed > vidaRedMax/2) {
    PImage redAnimation = redImagen[currentFrame];

    // Dibujar la imagen en pantalla
    image(redAnimation, 310, 40);

    // Incrementar el frame actual para la próxima iteración
    currentFrame++;

    // Si has alcanzado el último frame, reinicia la animación
    if (currentFrame >= totalFrames) {
      currentFrame = 0;
    }
  } else {
    PImage redAnimationHard = redHard[currentFrameHard];

    // Dibujar la imagen en pantalla
    image(redAnimationHard, 310, 40);

    // Incrementar el frame actual para la próxima iteración
    currentFrameHard++;

    // Si has alcanzado el último frame, reinicia la animación
    if (currentFrameHard >= totalFramesHard) {
      currentFrameHard = 0;
    }
  }
}

void movimientoBatalla() {
  if (!turnoJugador) {
    // Llamar en funcion del turno que sea
    if (turnoAtaque == 1 || turnoAtaque == 3 || turnoAtaque == 5 || turnoAtaque == 7) {
      manejarBolasAtaque();
    } else if (turnoAtaque == 9) {
      AtaqueRectangulos();
      manejarBolasAtaque();
    } else {
      AtaqueRectangulos();
    }
    if (!turnoJugador) {
      almaPlayer.dibuja();
      // Colision de arriba
      if (almaPlayer.y >= 235) {
        if ( moveUp )  almaPlayer.y = almaPlayer.y - almaPlayer.vel;
      }
      // Colisión de la derecha
      if (almaPlayer.x <= 485) {
        if (moveRight) almaPlayer.x = almaPlayer.x + almaPlayer.vel;
      }
      // Colisión de abajo
      if (almaPlayer.y <= 405) {
        if ( moveDown )  almaPlayer.y = almaPlayer.y + almaPlayer.vel;
      }
      // Colisión de la izquierda
      if (almaPlayer.x >= 295) {
        if (moveLeft) almaPlayer.x = almaPlayer.x - almaPlayer.vel;
      }
    }
  }
}
void keyPressed() {
  if (!turnoJugador) {
    if (keyCode == UP || keyCode == 'W' ||  keyCode == 'w') moveUp = true;
    if (keyCode == RIGHT || keyCode == 'D' ||  keyCode == 'd') moveRight = true;
    if (keyCode == DOWN || keyCode == 'S' ||  keyCode == 's') moveDown = true;
    if (keyCode == LEFT || keyCode == 'A' ||  keyCode == 'a') moveLeft = true;
  }
}
void keyReleased() {
  if (!turnoJugador) {
    if (keyCode == UP || keyCode == 'W' ||  keyCode == 'w') moveUp = false;
    if (keyCode == RIGHT || keyCode == 'D' ||  keyCode == 'd') moveRight = false;
    if (keyCode == DOWN || keyCode == 'S' ||  keyCode == 's') moveDown = false;
    if (keyCode == LEFT || keyCode == 'A' ||  keyCode == 'a') moveLeft = false;
  } else {
    moveUp = false;
    moveRight = false;
    moveDown = false;
    moveLeft = false;
  }
}

void botonesEspeciales() {
  reiniciarVariables();
  ultimoBoton = boton;
  turnoAtaque = turnoCombate;
  turnoJugador = false;
}
