# Simulacion y analisis de senales con la Transformada de Fourier

Actividad formativa 2. Proyecto elaborado en MATLAB.

## Objetivo
Representar un pulso rectangular, un escalon y una senoidal en el tiempo y analizar su magnitud y fase mediante la FFT. Comprobar linealidad, desplazamiento temporal circular y escalamiento de frecuencia.

## Requisitos
MATLAB con funciones base `fft`, `fftshift`, `circshift`, `subplot` y `exportgraphics` (version reciente). No requiere toolboxes adicionales.

## Ejecucion
1. Abrir MATLAB o MATLAB Online.
2. Abrir la carpeta del proyecto.
3. Ejecutar `analisis_fourier.m` con **Run**.
4. Revisar las figuras y los errores numericos en Command Window.

## Resultados
El script genera `senales_espectros.png`, `propiedades_fourier.png` y `linealidad.png`.

## Parametros
Frecuencia de muestreo de 1000 Hz, 2000 muestras, duracion de 2 s y resolucion espectral de 0.5 Hz. La FFT se divide entre N para comparar amplitudes.

## Interpretacion
- La senoidal de 10 Hz tiene picos en +10 y -10 Hz.
- El pulso rectangular presenta un espectro extendido con lobulos.
- El escalon finito contiene un componente en 0 Hz y energia distribuida en otras frecuencias.
- La linealidad se comprueba mediante error numerico cercano a cero.
- Un desplazamiento circular modifica la fase, no la magnitud de la DFT.
- Al pasar de 10 a 20 Hz, los picos se trasladan a +/-20 Hz. Esta demostracion usa una senoidal, no constituye una prueba general de la propiedad continua de escalamiento.

## Consideraciones
El escalon se observa en una ventana temporal finita; su FFT no es la transformada continua ideal del escalon infinito. El desplazamiento es circular porque se utiliza la DFT. La fase se oculta donde la magnitud es despreciable.
