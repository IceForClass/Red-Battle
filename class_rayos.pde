// Función para llamar a los rayos
void llamarRayos() {
  // Mueve y muestra cada rayo
  for (int i = 0; i < numRayos; i++) {
    rayos[i].caer();
    rayos[i].salePantalla();
    rayos[i].mostrar();
  }
}

//Todo lo relacionado la clase Rayo
class Rayo {
  float x, y;      
  float velocidadY; 
  float velocidadX; 
  float longitud;   
  float grosor;     
  color colorRayo; 

  Rayo() {
    x = random(width);         
    y = random(-600, -100);     
    velocidadY = 30;           
    velocidadX = random(-5, 5); 
    longitud = 50;              
    grosor = 2;                 
    colorRayo = color(random(255), random(255), random(255));  
  }

  // Función para que el rayo caiga
  void caer() {
    y += velocidadY;  
    x += velocidadX;  
    salePantalla();   
  }


  void salePantalla() {
    // Ver si el rayo sale de la pantalla 
    if (y > height) {
      y = random(-600, -100);  
      x = random(width);       
    }
  }

  void mostrar() {
    stroke(colorRayo);            
    strokeWeight(grosor);         
    line(x, y, x, y + longitud);  
  }
}
