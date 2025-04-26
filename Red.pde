Jugador almaPlayer;

boolean moveUp, moveDown, moveRight, moveLeft;

// Imagen del fondo
PImage Background;
PImage redTitle;
PImage centinela;

// Cargar fuente custom
PFont miFuente;

// Música del menú
import processing.sound.*;


// Saber que el menú es igual a verdadero
boolean menu = true;
boolean combate = false;

// Variables para controlar el raton
int mousex, mousey;

// Variables del boton start
int startX = 113; // Donde empieza en el eje X
int startY = 396; // Donde empieza en el eje Y


// Variables del boton exkt
int exitX = startX + 450; // Donde empieza en el eje X
int exitY = startY; // Donde empieza en el eje Y

// Variables comunes a los dos botones
int sizeX = 150; // Que tan anchos son
int sizeY = 60; // Que tan altos son

// Música
SoundFile musicaMenu;
SoundFile GameOver;
SoundFile victory;
SoundFile Sonidoboton;
SoundFile golpe;

// Número de rayos
int numRayos = 25;
Rayo[] rayos;

void setup() {
    //La carga del setup es super pesada, pero es que necesito llamar a demasiadas cosas
    size(800, 557);
    //Lo limité a 30fps para que las animaciones no se viesen aceleradas
    frameRate(30);
    almaPlayer = new Jugador();
    moveUp = moveDown = moveRight = moveLeft = false;
    
    rayos = new Rayo[numRayos];  // Inicializa el arreglo de rayos
    
    //Inicializa cada rayo
    for (int i = 0; i < numRayos; i++) {
        rayos[i] = new Rayo();
}
    
    //Cargamos la imagen de Red
    Background = loadImage("imagenes/RedBg.jpg");
    background(0);
    redTitle = loadImage("imagenes/Red.png");
    //Propiedades del texto
    textAlign(CENTER, CENTER);
    textSize(20);
    
    //Inicializar la música
  musicaMenu = new SoundFile(this, "musica/MenuTheme.mp3");
  GameOver = new SoundFile(this, "musica/GameOver.mp3");
  victory = new SoundFile(this, "musica/victory.mp3");
  Sonidoboton = new SoundFile(this, "musica/boton.mp3");
  golpe = new SoundFile(this, "musica/golpe.mp3");
    musicaMenu.loop();
    
    //Usar la fuente custom
    miFuente = createFont("fuentes/determination.ttf", 32);
    textFont(miFuente);
    
    
    //Llamar a todos los botones
    fight = loadImage("imagenes/Fight1.png");
    fight2 = loadImage("imagenes/Fight2.png");
    act = loadImage("imagenes/Act1.png");
    act2 = loadImage("imagenes/Act2.png");
    item = loadImage("imagenes/Item1.png");
    item2 = loadImage("imagenes/Item2.png");
    mercy = loadImage("imagenes/Mercy1.png");
    mercy2 = loadImage("imagenes/Mercy2.png");
    //Cargar aun mas imagenes
    alma = loadImage("imagenes/alma.png");
    centinela = loadImage("imagenes/Centinela.png");
    
    //Correcciones para las animaciones
    float scaleFactor = 0.70;
    
    //Cargar todas las imágenes de las animaciones en el array
    for (int i = 0; i < totalFrames; i++) {
        //imagenes[i] = loadImage("imagenes/RedAnimation/RedAnimation_" +i+ ".jpg");
        redImagen[i] = loadImage("imagenes/RedAnimation/RedAnimation_" + i + "-removebg-preview.png");
        redImagen[i].resize(int(255 * scaleFactor), int(358 * scaleFactor));
}
    
    for (int i = 0; i < totalFramesHard; i++) {
        //imagenes[i] = loadImage("imagenes/RedAnimation/RedAnimation_" +i+ ".jpg");
        redHard[i] = loadImage("imagenes/RedHard/Red_hard_" + i + "-removebg-preview.png");
        redHard[i].resize(int(255 * scaleFactor), int(358 * scaleFactor));
}
    
    for (int i = 0; i < totalFramesVictory; i++) {
        //imagenes[i] = loadImage("imagenes/RedAnimation/RedAnimation_" +i+ ".jpg");
        imagenesVictory[i] = loadImage("imagenes/DerrotaRed/DerrotaRed_" + i + ".jpg");
        imagenesVictory[i].resize(int(255 * scaleFactor), int(358 * scaleFactor));
}
    
    ataqueRectangulo = new ArrayList<Rectangulo>();
    
    //Inicializa algunos rectángulos al principio
    for (int i = 0; i < min(maxRectangulosEnPantalla, maxRectangulosGenerados); i++) {
        boolean izquierda = random(2) < 1;
        ataqueRectangulo.add(new Rectangulo(izquierda));
        totalRectangulosGenerados++;
}
    //Eliminamos el cursor
    noCursor();
}

void draw() {
    if(menu == true) {
        /*
        Esta función inicializa la lluvia de ceniza
        Conesta función también se dibuja el fondo por algunos cambios
        */
        lluvia();
        // Para tener controladas las coordenadas del raton
        mousex = mouseX;
        mousey = mouseY;
        //println(mouseX, mouseY); esto basicamente lo usaba para poder colocar las cosas donde van
        // "Titulo" del juego
        image(redTitle, 340, 20);
        
        // Controlar el menu
        // Botón de jugar
        if (menu &&  mousex >= startX && mousex <= startX + sizeX && mousey >= startY && mousey <= startY + sizeY) {
            fill(255, 255, 255);
            rect(startX, startY, sizeX, sizeY);
            fill(0);
            text("Jugar", startX + sizeX / 2, startY + sizeY / 2);
           // Comprobamos que queremos jugar
           if (mousePressed && mouseButton == LEFT) {
                musicaMenu.pause();
                musicaBatalla();
                combate = true;
               menu = false;
                boton = 1;
                combate();
        }
        } else {
            fill(255, 0, 0);
            rect(startX, startY, sizeX, sizeY);
            fill(255); // Restaura el color del texto
            text("Jugar", startX + sizeX / 2, startY + sizeY / 2);
        }
        // Botón de salir
        if (mousex >= exitX && mousex <= exitX + sizeX && mousey >= exitY && mousey <= exitY + sizeY) {
            fill(255, 255, 255);
            rect(exitX, exitY, sizeX, sizeY);
            fill(0); // Color del texto
            text("Salir", exitX + sizeX / 2, exitY + sizeY / 2);
           if (mousePressed && mouseButton == LEFT) {
                exit();
        }
        } else {
            fill(255, 0, 0);
            rect(exitX, exitY, sizeX, sizeY);
            fill(255); // Restaura el color del texto
            text("Salir", exitX + sizeX / 2, exitY + sizeY / 2);
        }
        // Sustituir el ratón por la foto del alma, así se ve mejor
        image(alma, mouseX, mouseY);
} else {
        combate();
}
}
