#  Readme


Memory game

- Las cartas tienen que tener una animación que permita voltearlas. (Que sean pares)
- Tenemos que tener una pantalla para seleccionar modo de juego, cantidad de cards y tiempo de muestra de criterio
- Modo de Juego:
    - Secuencial:
        - Un único jugador debe encontrar las cards en el orden especificado hasta encontrarlas todas o agotar sus vidas.
        - Al cometer un error se muestran por una cantidad de segundos (1.5s) y se voltean todas.
        -TODO: Si el usuario gana la partida, se muestra un modal con la puntuacion y un feedback con los segundos que faltan para comenzar la siguiente partida.
        - TODO: Al ganar generar una nueva partida (es automatico porque va a estar explicado antes que una vez que gana puede volver a jugar para sumar victorias) y persistir el número de victorias seguidas en la memoria local del dispositivo (encriptada).
        -TODO: Crear una ecuacion para calcular los puntos. Agregar la puntuacion correspondiente segun la cantidad de tiempo de previsualizacion (menos tiempo, mas puntos), cantidad de cards (mas cards, mas puntos) y cantidad de vidas al momento de ganar la partida (mas vidas, mas puntos).
        -TODO: Si el jugador pierde, se muestra un modal con los puntos y un boton para volver al menu de memory game. 
        -TODO: Agregar opcion de elegir cantidad de vidas (2,3,4)
    - Clasico 1 jugador:
        - TODO: Se deben encontrar de a pares hasta encontrarlas todas o hasta agotarse la cantidad de vidas (depende de la cantidad de cartas seleccionadas) ya que tiene una cantidad limitada (a elección).
        - TODO: Las parejas encontradas no se reinician al cometer un error, en este caso se vuelven a esconder las ultimas 2 cartas que representan el error cometido y se descuenta una vida.
        - TODO: Mostrar las cartas al iniciar la partida por la cantidad de segundos seleccionada por el usuario.
    - Clasico 2 jugadores: 
        - TODO: Se deben encontrar de a pares hasta encontrarlas todas, en caso de error el turno pasa al próximo jugador.
        - TODO: Las parejas encontradas no se reinician al cometer un error, en este caso se vuelven a esconder las ultimas 2 cartas que representan el error cometido.
        - TODO: El tiempo está limitado para cada turno (mostrarlo en la UI).
        - TODO: El jugador a iniciar la partida se selecciona al azar.

Para el martes 22/03/22
Terminar la lógica faltante del modo secuencial.
Que todos podamos jugar.
Dejar lindo el modal
Terminar calculo de puntos 
Persistir el puntaje

Desarrollar en el orden de los items de este readme.
