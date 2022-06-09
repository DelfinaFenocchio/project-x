#  Readme


Memory game

- Las cartas tienen que tener una animación que permita voltearlas. (Que sean pares)
- Tenemos que tener una pantalla para seleccionar modo de juego, cantidad de cards y tiempo de muestra de criterio

- Modo de Juego:
    - Secuencial:
        - Un único jugador debe encontrar las cards en el orden especificado hasta encontrarlas todas o agotar sus vidas.
        - Al cometer un error se muestran por una cantidad de segundos (1.5s) y se voltean todas.
        - Si el usuario gana la partida, se muestra un modal con la puntuacion y un feedback con los segundos que faltan para comenzar la siguiente partida.
        - Al ganar generar una nueva partida (es automatico porque va a estar explicado antes que una vez que gana puede volver a jugar para sumar victorias) 
        - Crear una ecuacion para calcular los puntos. Agregar la puntuacion correspondiente segun la cantidad de tiempo de previsualizacion (menos tiempo, mas puntos), cantidad de cards (mas cards, mas puntos) y cantidad de vidas al momento de ganar la partida (mas vidas, mas puntos).
        - Si el jugador pierde, se muestra un modal con los puntos y un boton para volver al menu de memory game.
        -Agregar opcion de elegir cantidad de vidas (2,4,6)
        -Persistir el high Score en la memoria local del dispositivo SOLO al cerrar la app o salir del juego .
    - Clasico 1 jugador:
        - Se deben encontrar de a pares hasta encontrarlas todas o hasta agotarse la cantidad de vidas (depende de la cantidad de cartas seleccionadas) ya que tiene una cantidad limitada (a elección).
        - Las parejas encontradas no se reinician al cometer un error, en este caso se vuelven a esconder las ultimas 2 cartas que representan el error cometido y se descuenta una vida.
        - Mostrar las cartas al iniciar la partida por la cantidad de segundos seleccionada por el usuario.
    - Clasico 2 jugadores: 
        - Agregar la lógica para el cambio de turnos.
        - Mantener el estado de cuantas parejas ha encontrado cada jugador.
        - Agregar un indicador visual para conocer a quien le toca jugar.
        - Agregar la UI con el ganador.
        - Sacar la lógica de las vidas.
        - Se deben encontrar de a pares hasta encontrarlas todas, en caso de error el turno pasa al próximo jugador.
        - Las parejas encontradas no se reinician al cometer un error, en este caso se vuelven a esconder las ultimas 2 cartas que representan el error cometido.
        - Ocultar la opcion de cantidad de vidas del menú.
        - El jugador a iniciar la partida se selecciona al azar.
        - investigar como cancelar las task al hacer back.
        - El tiempo está limitado para cada turno (mostrarlo en la UI).
            - Cada turno dura X segundos, sin importar si el jugador descubre pares durante ese tiempo.
            - El turno termina cuando el jugador erra, o pasa la cantidad de tiempo.
            - Al terminar el turno, la card que esté volteada sin su par, se esconde de nuevo.
        - TODO: Mejorar la indicación visual del cambio de turno
            - Agregar input para los nombres de cada jugadores, con default "Jugador Uno" o "Jugador Dos"
            - Agregar animación/es o colores
        - TODO: Indicar cuál jugador levantó cada par mediante el color
        - TODO: Mejorar la UI del modal (puntuacion de ambos)

- TODOS temas tecnicos pendientes:
    - protocolos
    - mocks para test unitarios
    - subíndices
    - lazy / computed properties
    - Configurar un modulo nativo para poder integrarlo a un proyecto de react native 

-TODOS para algún día:
- (Modo secuencial) Corregir indicador de orden de cards cuando hay muchas cards, se amontona y se ve feo
- Investigar cómo hacer un grid para no tener hardcodeadas las columnas según el modo de juego
- Ver de no repetir los ids para el modo classic
- Agregar feedback visual, auditivo y kinestesico durante eventos importantes.

- TODO FINAL: Agregar TODAS las mejoras visuales, con probable ayuda de Fran, que haya alguna explicacion de los modos de juego.

Para el martes 14/06/22
- investigar como hacer mocks para el test asíncrono

Desarrollar en el orden de los items de este readme.
