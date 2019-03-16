# Interacción gráfica con cámara
Víctor Ceballos Espinosa

## Introducción

Esta práctica consiste en hacer uso de bibliotecas de vídeo para interaccionar con una interfaz gráfica mediante dicha cámara. Es importante mencionar que Processing no incluye estas bibliotecas de vídeo, por lo que lo ha sido necesario añadirlas a través del menú de Herramientas. Para ser más específicos, he usado tres librerías en esta práctica:

  - Video: Para poder usar la cámara frontal del portátil y capturar imágenes
  - OpenCV: Para el tratamiento de las imágenes
  - PeasyCam: Para implementar fácilmente una cámara que se pueda mover con el ratón.

## Objetivo

Tras ver los ejemplos propuestos en la galería, decidí implementar una especia de sistema solar reducido en el que sólo existe un planeta y un satélite. Este satélite órbita alrededor del planeta a una velocidad constante. Sin embargo, dependiendo de la cantidad de movimiento que haya en frente de la pantalla, el satélite orbitará a más o menos velocidad. A más movimiento, más velocidad y a menos movimiento, menos velocidad.

## Implementación

Para implementar el objetivo descrito en el anterior apartado, he decidido hacer uso del ejemplo p6_camdiff. En este ejemplo, inicialmente se disponen dos imágenes, a la izquierda la imagen actual en frente de la cámara en color, a la derecha, la diferencia en blanco y negro entre dos imágenes consecutivas.

He decidido hacer uso de esta diferencia de imágenes para poder saber la cantidad de movimiento en frente de la cámara.

Para implementar esto, se hacen principalmente dos cosas. En primer lugar, se calcula la media de los componentes RGB de cada pixel de la imagen diferencia (al ser en blanco y negro la imagen, las tres componentes son iguales).
Con esta media y la media de la anterior imagen, se calcula la velocidad de orbitación del satélite. Al ser pequeña la diferencia entre las dos medias consecutivas, dicho valor se multiplica por tres y se pasa a radianes para poder controlar el ángulo en el que se sitúa el satélite. Por último, se actualiza el valor de la media anterior.

## Referencias
[Enunciado de la práctica](https://cv-aep.ulpgc.es/cv/ulpgctp19/pluginfile.php/182523/mod_resource/content/13/CIU_Pr_cticas.pdf)

[Repositorio de GitHub](https://github.com/victcebesp/OrbitSpeedInteractor)

[Repositorio de Github de p6_camdiff](https://github.com/otsedom/CIU/tree/master/P6/p6_camdiff)
