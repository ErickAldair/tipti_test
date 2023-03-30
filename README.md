# Star Wars Characters

Una aplicación Flutter para mostrar personajes de Star Wars con información básica, como nombre, películas en las que aparecen y género. Los personajes se pueden filtrar por género y se muestra un logo giratorio en la parte superior de la pantalla que reacciona a los movimientos giratorios del dispositivo.

## Dependencias

Las siguientes dependencias se encuentran en el archivo `pubspec.yaml`:

### http

Versión: `^0.13.3`
URL: https://pub.dev/packages/http

Descripción:
Este paquete proporciona una API de cliente HTTP fácil de usar. Se utiliza en este proyecto para realizar llamadas a la API de Star Wars (https://swapi.dev/) y obtener información sobre los personajes.

### provider

Versión: `^6.0.1`
URL: https://pub.dev/packages/provider

Descripción:
Un administrador de estado popular para aplicaciones Flutter. En este proyecto, se utiliza Provider para manejar el estado de la aplicación, como cargar y filtrar personajes.

### flutter_spinkit

Versión: `^5.1.0`
URL: https://pub.dev/packages/flutter_spinkit

Descripción:
Una colección de indicadores de carga en forma de spinner para Flutter. En este proyecto, se utiliza para mostrar un indicador de carga mientras se cargan más personajes de la API de Star Wars.

## Instalación

Para instalar y ejecutar la aplicación en un dispositivo o emulador, sigue estos pasos:

1. Clona este repositorio en tu computadora.
2. Asegúrate de tener instalado Flutter y Dart en tu sistema. Si no los tienes, sigue las instrucciones de instalación en la página oficial de Flutter: https://flutter.dev/docs/get-started/install
3. Ejecuta `flutter pub get` para instalar todas las dependencias del proyecto.
4. Ejecuta `flutter run` para compilar y ejecutar la aplicación en un dispositivo o emulador conectado.

## Licencia

Este proyecto está licenciado bajo los términos de la licencia MIT.