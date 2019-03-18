import processing.video.*;
import cvimage.*;
import org.opencv.core.*;
import org.opencv.imgproc.Imgproc;
import peasy.*;

Capture faceCam;
import java.text.DecimalFormat;

CVImage img, pimg, auximg;
long previousMean = 0, spinSpeed = 0;
float speed = 0;
CelestialBody celestialBody;
PeasyCam cam;
DecimalFormat decimalFormat;

void setup() {
  size(1280, 480, P3D);
  //Cámara
  faceCam = new Capture(this, width/2, height);
  faceCam.start();
  cam = new PeasyCam(this, 500);
  cam.setActive(false);
  //OpenCV
  //Carga biblioteca core de OpenCV
  System.loadLibrary(Core.NATIVE_LIBRARY_NAME);
  img = new CVImage(faceCam.width, faceCam.height);
  pimg = new CVImage(faceCam.width, faceCam.height);
  auximg=new CVImage(faceCam.width, faceCam.height);
  celestialBody = new CelestialBody(50, 0, 0);
  celestialBody.spawnMoon();
  decimalFormat = new DecimalFormat("#.##");
}

void draw() {  
  if (faceCam.available()) {
    lights();
    background(0);
    faceCam.read();

    //Obtiene la imagen de la cámara
    img.copy(faceCam, 0, 0, faceCam.width, faceCam.height, 0, 0, img.width, img.height);
    img.copyTo();

    //Imagen de grises
    Mat gris = img.getGrey();
    Mat pgris = pimg.getGrey();

    //Calcula diferencias en tre el fotograma actual y el previo
    Core.absdiff(gris, pgris, gris);

    long mean = 0;
  
    for(int i = 0; i < height; i++) {
      for(int j = 0; j < width/2; j++) {
        mean +=  pgris.get(i, j)[0] - gris.get(i, j)[0];   
      }
    }
    
    mean = mean / gris.total();
    speed = radians(abs((previousMean - mean)));
    previousMean = mean;
    
    pushStyle();
    fill(255, 0, 0);
    textSize(25);
    text("Current speed: " + decimalFormat.format(0.05 + speed), -100, 140);
    fill(255, 255, 255);
    textSize(20);
    text("Increase the movement in front of the camera to move faster the satellite", -width/4, 160);
    popStyle();
    
    //Copia de Mat a CVImage
    cpMat2CVImage(gris, auximg);
    //translate(width/2, height/2);
    
    celestialBody.show(1);
    celestialBody.orbit(speed, 1);

    //Copia actual en previa para próximo fotograma
    pimg.copy(img, 0, 0, img.width, img.height, 
      0, 0, img.width, img.height);
    pimg.copyTo();

    gris.release();
  }
}

//Copia unsigned byte Mat a color CVImage
void  cpMat2CVImage(Mat in_mat, CVImage out_img)
{    
  byte[] data8 = new byte[faceCam.width*faceCam.height];

  out_img.loadPixels();
  in_mat.get(0, 0, data8);

  // Cada columna
  for (int x = 0; x < faceCam.width; x++) {
    // Cada fila
    for (int y = 0; y < faceCam.height; y++) {
      // Posición en el vector 1D
      int loc = x + y * faceCam.width;
      //Conversión del valor a unsigned basado en 
      //https://stackoverflow.com/questions/4266756/can-we-make-unsigned-byte-in-java
      int val = data8[loc] & 0xFF;
      //Copia a CVImage
      out_img.pixels[loc] = color(val);
    }
  }
  out_img.updatePixels();
}
