# Taller Práctico Flutter: "GeoTrack Pro" - Aplicación de Monitoreo Físico y Rutas

## 1. Introducción

En el desarrollo móvil moderno, conectar el software con el hardware del dispositivo, garantizar la fluidez mediante optimización de recursos y automatizar la entrega son competencias críticas. En este taller construirás **GeoTrack Pro**, una aplicación que registra rutas de actividad física utilizando el GPS, gestiona el estado de manera eficiente, navega de forma avanzada entre pantallas, se evalúa con pruebas automatizadas y se perfila para un rendimiento óptimo antes de ser desplegada mediante CI/CD.

## 2. Objetivo General (SMART)

Desarrollar, optimizar y automatizar el despliegue de la aplicación móvil **GeoTrack Pro** en Flutter utilizando buenas prácticas de arquitectura, manejo de estado y testing, logrando una cobertura de pruebas del 70%, un rendimiento de renderizado estable a 60 FPS y un pipeline de entrega continua funcional en un entorno de integración simulado o real al finalizar el taller.

## 3. Objetivos Específicos

* Implementar un flujo de navegación robusto y tipado que soporte el paso de argumentos complejos y rutas protegidas.
* Separar la lógica de negocio de la interfaz mediante un patrón de diseño de estado reactivo y predecible.
* Consumir servicios de ubicación en tiempo real (GPS) gestionando correctamente el ciclo de vida y los permisos del sistema operativo.
* Garantizar la estabilidad de la app mediante una suite de pruebas unitarias, de integración y de interfaz de usuario.
* Diagnosticar y mitigar cuellos de botella de rendimiento utilizando las herramientas de perfilamiento oficiales de Flutter.
* Automatizar la compilación, análisis estático y preparación de artefactos mediante un pipeline de CI/CD.

## 4. Arquitectura y Flujo de la App

La aplicación sigue una arquitectura limpia estructurada por capas (Feature-first o Layer-first recomendada).

```text
[ Capa de UI: Widgets / Screens ] <---> [ Capa de Estado: BLoC / Riverpod ]
                                                    |
                                                    v
                                    [ Capa de Dominio / Repositorios ]
                                                    |
                                                    v
                                    [ Capa de Datos: GPS Hardware / API ]

```

### Flujo Principal de Navegación:

```text
(Splash Screen) 
       |
       v
(Auth / Login) ---> (Home: Lista de Rutas) ---> (Detalle de Ruta)
                           |
                           v
                  (Tracking Activo: GPS)

```

---

## 5. Roadmap de Pasos

1. **Paso 1:** Configurar navegación avanzada con rutas declarativas y tipadas.
2. **Paso 2:** Implementar la arquitectura del estado global de la aplicación.
3. **Paso 3:** Integrar el hardware de geolocalización (GPS) en tiempo real.
4. **Paso 4:** Desarrollar la suite de pruebas funcionales y de UI automatizadas.
5. **Paso 5:** Perfilar y optimizar el rendimiento (Uso de memoria y FPS).
6. **Paso 6:** Automatizar el ciclo de vida con un pipeline de CI/CD.

---

## 6. Pasos Detallados

### Paso 1: Configurar navegación avanzada con rutas declarativas y tipadas

* **Objetivo del paso:** Implementar un sistema de enrutamiento robusto que permita transiciones declarativas, paso de parámetros seguro y manejo de rutas no encontradas.
* **Conexión con la app:** Define la estructura base de pantallas sobre la cual operará toda la aplicación (*Auth*, *Home*, *Tracking*, *Detail*).
* **Progresión del tema (básico → intermedio):**
* *Básico:* Configurar rutas nombradas tradicionales con `Navigator 1.0`.
* *Intermedio:* Migrar a un enrutamiento declarativo basado en `Router (Navigator 2.0)` para soportar URL dinámicas y restauración de estado.


* **Decisiones de diseño a tomar:**
* *Opción A:* `go_router` (Paquete oficial de Flutter).
* *Opción B:* `auto_route` (Basado en generación de código).
* *Recomendada:* **Opción A (go_router)** por su integración nativa, soporte directo del equipo de Flutter y sintaxis declarativa limpia sin depender estrictamente de generadores de código para flujos estándar.


* **Guía de implementación:**
* Crea un archivo `app_router.dart`. Define la configuración de rutas usando `GoRouter`.
* Implemente una ruta dinámica para el detalle de la ruta que reciba un ID: `/route/:id`.


* **Pseudocódigo / Fragmento mínimo:**

```dart
// app_router.dart - Configuración base
final goRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/details/:id',
      builder: (context, state) => DetailsScreen(id: state.pathParameters['id']!),
    ),
  ],
);

```

* **Consultas sugeridas (docs oficiales/keywords):**
* Búscalo como: "Navigation and routing" en la doc de flutter.dev o "go_router package" en pub.dev.


* **Preguntas catalizadoras:**
* ¿Qué ventajas ofrece el enrutamiento declarativo sobre el imperativo cuando se manejan enlaces profundos (*Deep Linking*)?


* **Checkpoint:** Al presionar un botón simulado en la pantalla de *Home*, la app debe navegar a *Details* mostrando el ID correcto en el texto de la pantalla.
* **Retos:**
* *Reto 1 (Fácil):* Añadir una pantalla de error personalizada (404) que se active automáticamente cuando se intente acceder a una ruta inexistente. **Criterio:** Si digitas una ruta inválida en el código, debe mostrar el widget de error.
* *Reto 2 (Medio):* Implementar un *Guard* de redirección que verifique si el usuario está autenticado; si no, redirigir siempre a `/login`. **Criterio:** Cambiar una variable booleana `isAuthenticated = false` y verificar que bloquee el acceso a `/home`.


* **Errores comunes & pistas:**
* *Síntoma:* Al pasar parámetros, la app lanza un error de tipo `null` en tiempo de ejecución.
* *Pista:* Revisa si estás extrayendo el parámetro desde `pathParameters` o `queryParameters` y si el nombre coincide exactamente con el definido en el `path`.


* **Extensión opcional:** Añadir animaciones de transición personalizadas (p. ej., un deslizamiento lateral) exclusivas para la pantalla de *Details*.

---

### Paso 2: Implementar la arquitectura del estado global de la aplicación

* **Objetivo del paso:** Centralizar la lógica de negocio y la gestión de la información de las rutas utilizando un patrón arquitectónico reactivo.
* **Conexión con la app:** El estado manejará la lista de rutas grabadas y controlará si el GPS está activado o pausado, comunicando la capa de datos con la interfaz de usuario.
* **Progresión del tema (básico → intermedio):**
* *Básico:* Uso de `setState` local para manejar variables de control.
* *Intermedio:* Implementación de un gestor de estado global e inmutable con separación clara de eventos/acciones y estados.


* **Decisiones de diseño a tomar:**
* *Opción A:* `flutter_bloc` (Patrón BLoC basado en flujos/Streams).
* *Opción B:* `flutter_riverpod` (Enfoque reactivo moderno basado en proveedores).
* *Recomendada:* **Opción A (BLoC)** debido a su predictibilidad estricta, ideal para flujos de datos continuos como flujos de coordenadas de hardware.


* **Guía de implementación:**
* Crea los archivos para el estado de la actividad física (`tracking_event.dart`, `tracking_state.dart`, `tracking_bloc.dart`).
* Define los estados: `TrackingInitial`, `TrackingInProgress`, `TrackingPaused`, `TrackingSuccess`.


* **Pseudocódigo / Fragmento mínimo:**

```dart
// tracking_bloc.dart - Estructura lógica de eventos
class TrackingBloc extends Bloc<TrackingEvent, TrackingState> {
  TrackingBloc() : super(TrackingInitial()) {
    on<StartTracking>((event, emit) => emit(TrackingInProgress()));
    on<PauseTracking>((event, emit) => emit(TrackingPaused()));
    on<StopTracking>((event, emit) => emit(TrackingSuccess(routes: [])));
  }
}

```

* **Consultas sugeridas (docs oficiales/keywords):**
* Búscalo como: "Core Concepts" en bloclibrary.dev.


* **Preguntas catalizadoras:**
* ¿Por qué es una buena práctica que los estados expuestos a la UI sean inmutables?


* **Checkpoint:** Al presionar los botones de "Iniciar", "Pausar" y "Detener" en la interfaz, se debe reflejar textualmente el estado actual modificado en la pantalla sin perder consistencia.
* **Retos:**
* *Reto 1 (Fácil):* Agregar un contador de tiempo transcurrido (cronómetro) al estado `TrackingInProgress`. **Criterio:** El contador debe incrementarse de forma simulada.
* *Reto 2 (Medio):* Implementar un mecanismo para persistir el estado actual en memoria local (mock) de modo que si la app se pausa en segundo plano, mantenga el estado del recorrido. **Criterio:** Al emitir un nuevo estado, este debe registrarse en un log histórico.


* **Errores comunes & pistas:**
* *Síntoma:* La interfaz no se actualiza a pesar de que el evento es lanzado y procesado por el bloque de lógica.
* *Pista:* Asegúrate de que estás emitiendo una **nueva instancia** del estado. Si usas el operador `==` o librerías como `equatable`, verifica que agregues las propiedades modificadas al método `props`.


* **Extensión opcional:** Integrar `bloc_delegate` o `BlocObserver` para imprimir en consola los cambios de estado detallados globalmente.

---

### Paso 3: Integrar el hardware de geolocalización (GPS) en tiempo real

* **Objetivo del paso:** Capturar coordenadas del dispositivo utilizando los sensores de hardware e inyectarlas dentro del flujo de estado diseñado en el Paso 2.
* **Conexión con la app:** Transforma los botones de la interfaz en disparadores reales que interactúan con el sensor de ubicación para dibujar coordenadas en la ruta activa.
* **Progresión del tema (básico → intermedio):**
* *Básico:* Solicitar una única posición actual mediante GPS (*Current Position*).
* *Intermedio:* Escuchar un canal continuo (*Stream*) de geolocalización en segundo plano controlando precisión y ciclo de vida de la app.


* **Decisiones de diseño a tomar:**
* *Opción A:* `geolocator` (Fácil configuración, estándar de la industria).
* *Opción B:* `location` (Excelente soporte para tareas en segundo plano avanzado).
* *Recomendada:* **Opción A (geolocator)** por su robustez, excelente documentación y manejo nativo de flujos de configuración de permisos en Android e iOS.


* **Guía de implementación:**
* Configura los permisos nativos en `AndroidManifest.xml` y `Info.plist` (Ubicación fina y en segundo plano).
* Crea un servicio `LocationService` que exponga un método `getPositionStream()`.
* Conecta el flujo del Stream de geolocalización con el gestor de estado (BLoC/Riverpod) para acumular una lista de puntos `(Latitude, Longitude)`.


* **Pseudocódigo / Fragmento mínimo:**

```dart
// location_service.dart - Flujo de hardware
class LocationService {
  Stream<Position> getPositionStream() {
    return Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5, // Metros mínimos de cambio
      ),
    );
  }
}

```

* **Consultas sugeridas (docs oficiales/keywords):**
* Búscalo como: "Geolocator plugin" en pub.dev y "Platform-specific code" en flutter.dev.


* **Preguntas catalizadoras:**
* ¿Cómo afecta el parámetro `distanceFilter` u la precisión elegida en el consumo de batería del usuario?


* **Checkpoint:** Al presionar "Iniciar", la consola o un widget de lista debe empezar a desplegar una secuencia de coordenadas cambiantes a medida que el dispositivo (o emulador) simula movimiento.
* **Retos:**
* *Reto 1 (Fácil):* Implementar una validación previa que verifique si el servicio de GPS general está encendido en el teléfono móvil. **Criterio:** Si está apagado, mostrar una alerta modal indicando al usuario que debe encenderlo.
* *Reto 2 (Medio):* Controlar el estado de los permisos de forma dinámica. Si el usuario deniega el permiso permanentemente, mostrar un botón directo que abra la configuración del sistema operativo. **Criterio:** Usar los métodos nativos del paquete de localización para abrir la App Settings.


* **Errores comunes & pistas:**
* *Síntoma:* La aplicación se detiene o lanza una excepción de tipo `PermissionDeniedException` inmediatamente al iniciar la pantalla de tracking.
* *Pista:* Verifica que hayas añadido los permisos de `ACCESS_FINE_LOCATION` en los manifiestos nativos correspondientes y que estés ejecutando la solicitud en tiempo de ejecución (`requestPermission()`).


* **Extensión opcional:** Calcular la distancia total recorrida acumulada en kilómetros utilizando la fórmula de Haversine provista por el paquete de geolocalización.

---

### Paso 4: Desarrollar la suite de pruebas funcionales y de UI automatizadas

* **Objetivo del paso:** Validar el comportamiento lógico del estado y la experiencia de usuario en la interfaz mediante pruebas de código automatizadas.
* **Conexión con la app:** Garantiza que los flujos de navegación, las emisiones del BLoC y los componentes visuales de GeoTrack Pro mantengan su integridad ante futuros cambios.
* **Progresión del tema (básico → intermedio):**
* *Básico:* Pruebas unitarias básicas de funciones puras.
* *Intermedio:* Pruebas de integración de estados virtuales (`bloc_test`) y pruebas de interacción de interfaz de usuario simulando gestos del usuario (`Widget Tests`).


* **Decisiones de diseño a tomar:**
* *Opción A:* `flutter_test` nativo combinado con `bloc_test`.
* *Opción B:* Frameworks externos como `Patrol` (Pruebas de integración nativas avanzadas).
* *Recomendada:* **Opción A** por ser el estándar por defecto del SDK, de rápida ejecución en entornos locales y de integración continua sin dependencias pesadas.


* **Guía de implementación:**
* Crea un archivo `tracking_bloc_test.dart` dentro del directorio `test/`.
* Utiliza mocks para aislar el `LocationService` (usando `mocktail` o `mockito`).
* Crea un archivo `home_widget_test.dart` para asegurar que el botón de iniciar tracking cambie de aspecto de forma interactiva.


* **Pseudocódigo / Fragmento mínimo:**

```dart
// tracking_bloc_test.dart - Ejemplo estructural de pruebas de estado
blocTest<TrackingBloc, TrackingState>(
  'Emite [TrackingInProgress] cuando se añade StartTracking',
  build: () => TrackingBloc(),
  act: (bloc) => bloc.add(StartTracking()),
  expect: () => [isA<TrackingInProgress>()],
);

```

* **Consultas sugeridas (docs oficiales/keywords):**
* Búscalo como: "Testing Flutter apps" y "An introduction to widget testing" en flutter.dev.


* **Preguntas catalizadoras:**
* ¿Por qué es fundamental realizar el simulacro (*Mock*) de servicios externos o de hardware como el GPS durante la ejecución de las pruebas unitarias?


* **Checkpoint:** Ejecutar el comando `flutter test` en la terminal y comprobar que todos los casos diseñados pasen exitosamente con indicador verde.
* **Retos:**
* *Reto 1 (Fácil):* Escribir una prueba de widget que verifique que el texto de bienvenida en el Login Screen exista correctamente. **Criterio:** Usar `find.text()` y `expect(..., findsOneWidget)`.
* *Reto 2 (Medio):* Probar el flujo completo de un Widget: presionar el botón de inicio de tracking mediante un gesto de tap virtual y verificar que la UI cambie de inmediato al estado de pausa de forma reactiva. **Criterio:** Utilizar `tester.tap()`, luego `tester.pump()` y constatar el cambio de iconos.


* **Errores comunes & pistas:**
* *Síntoma:* La prueba de widget falla porque no encuentra un componente que requiere dependencias heredadas de temas o gestores de estado globales.
* *Pista:* Asegúrate de envolver (*Wrap*) el widget bajo prueba dentro de un `MaterialApp` y proveer las instancias de tus bloques/proveedores usando un `BlocProvider` o equivalente en el método de inicialización de la prueba.


* **Extensión opcional:** Generar y exportar un reporte de cobertura de código (*Code Coverage*) en formato HTML mediante herramientas locales de consola.

---

### Paso 5: Perfilar y optimizar el rendimiento (Uso de memoria y FPS)

* **Objetivo del paso:** Diagnosticar la aplicación en busca de fugas de memoria (*Memory Leaks*) y optimizar el repintado de widgets para asegurar transiciones fluidas.
* **Conexión con la app:** Dado que grabamos coordenadas de GPS en tiempo real de forma masiva, este paso asegura que la retención de datos en la UI no sature el hardware del smartphone.
* **Progresión del tema (básico → intermedio):**
* *Básico:* Observar logs básicos de consola y advertencias de renderizado.
* *Intermedio:* Uso avanzado de **Flutter DevTools** en modo Perfil (*Profile Mode*) para aislar problemas de reconstrucciones innecesarias de widgets y picos de memoria.


* **Decisiones de diseño a tomar:**
* *Opción A:* Optimización mediante selectores finos (`BlocSelector` o `context.select`).
* *Opción B:* Reestructuración arquitectónica masiva de colecciones de datos.
* *Recomendada:* **Opción A** por ser una práctica de optimización quirúrgica que disminuye el árbol de renderizado afectado por cambios atómicos en el estado.


* **Guía de implementación:**
* Compila la app usando el comando `flutter run --profile`.
* Abre **Flutter DevTools** desde el navegador y navega a las pestañas **Performance** y **Memory**.
* Utiliza constructores constantes (`const`) y rompe widgets complejos en widgets pequeños independientes para reducir los ámbitos de dibujo de la pantalla.


* **Pseudocódigo / Fragmento mínimo:**

```dart
// UI optimizada usando selectores atómicos
class TotalDistanceWidget extends StatelessWidget {
  const TotalDistanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Escucha únicamente la propiedad 'distance', ignorando otros cambios del estado
    final distance = context.select((TrackingBloc b) => b.state.totalDistance);
    return Text('Distancia: $distance km');
  }
}

```

* **Consultas sugeridas (docs oficiales/keywords):**
* Búscalo como: "Run Flutter in profile mode" y "Using the Performance view" en flutter.dev.


* **Preguntas catalizadoras:**
* ¿Por qué las optimizaciones de rendimiento y uso de memoria NUNCA deben medirse ni evaluarse utilizando el modo de ejecución Debug?


* **Checkpoint:** Al interactuar intensamente con la aplicación en modo Profile, el monitor de DevTools no debe presentar advertencias de cuadros caídos (*Jank / Red Bars*) y la línea de memoria debe mantenerse estable sin pendientes infinitas.
* **Retos:**
* *Reto 1 (Fácil):* Encontrar e identificar mediante el código estático al menos 3 widgets huérfanos que puedan convertirse en constructores `const` para optimizar su caché en tiempo de renderizado. **Criterio:** Ausencia de advertencias del linter de Flutter en esos widgets.
* *Reto 2 (Medio):* Simular un proceso de fuga de datos (añadir suscripciones a Streams en un State sin cerrarlas) y demostrar con capturas de pantalla de la gráfica de DevTools Memory cómo se produce la acumulación residual antes y después de aplicar el método `dispose()`. **Criterio:** El consumo de memoria debe estabilizarse tras invocar la limpieza.


* **Errores comunes & pistas:**
* *Síntoma:* La aplicación corre sumamente lenta y las métricas de DevTools marcan un rendimiento catastrófico.
* *Pista:* Asegúrate de no estar corriendo las pruebas en modo *Debug*. El modo depuración incluye verificaciones de aserciones muy costosas que no reflejan el rendimiento final de producción.


* **Extensión opcional:** Configurar reglas personalizadas estrictas de análisis estático en el archivo `analysis_options.yaml` para forzar las advertencias de optimización en tiempo de diseño.

---

### Paso 6: Automatizar el ciclo de vida con un pipeline de CI/CD

* **Objetivo del paso:** Crear un flujo de trabajo automatizado que verifique el código, ejecute las pruebas desarrolladas y compile la aplicación de manera automática ante cambios en el repositorio.
* **Conexión con la app:** Es el cierre definitivo del ciclo de desarrollo de **GeoTrack Pro**, garantizando que el código integrado sea siempre estable y distribuible.
* **Progresión del tema (básico → intermedio):**
* *Básico:* Compilar la APK de forma manual en la computadora local del desarrollador.
* *Intermedio:* Creación de un pipeline automatizado multinivel en la nube que ejecuta análisis estático, suite completa de pruebas distribuidas y empaquetado de artefactos finales.


* **Decisiones de diseño a tomar:**
* *Opción A:* `GitHub Actions` (Ecosistema nativo del repositorio, gran marketplace de tareas).
* *Opción B:* `Codemagic` (Especializado exclusivamente en flujos móviles CI/CD).
* *Recomendada:* **Opción A (GitHub Actions)** debido a su acceso gratuito integrado, versatilidad para definir flujos mediante YAML estándar y facilidad para integrarse con cualquier repositorio git.


* **Guía de implementación:**
* Crea el archivo de configuración en la ruta `.github/workflows/main.yml`.
* Configura el entorno instalando Java, el SDK de Flutter y administrando el caché de paquetes para acelerar las ejecuciones futuras.
* Define las etapas secuenciales obligatorias: Linter/Análisis -> Test -> Build (APK / App Bundle).


* **Pseudocódigo / Fragmento mínimo:**

```yaml
# .github/workflows/main.yml - Fragmento de pipeline CI/CD
name: Flutter CI/CD
on: [push, pull_request]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-java@v3
        with: { distribution: 'zulu', java-version: '17' }
      - uses: subosito/flutter-action@v2
        with: { flutter-version: '3.x', channel: 'stable' }
      - run: flutter pub get
      - run: flutter analyze
      - run: flutter test
      - run: flutter build apk --release

```

* **Consultas sugeridas (docs oficiales/keywords):**
* Búscalo como: "Continuous integration" en la documentación oficial de flutter.dev.


* **Preguntas catalizadoras:**
* ¿Cómo beneficia a la agilidad de un equipo de desarrollo la ejecución automática del set de pruebas antes de fusionar un Pull Request a la rama principal?


* **Checkpoint:** Al realizar un `git push` a tu rama de trabajo, la sección de "Actions" de GitHub debe iniciar el flujo y culminar todas las etapas con un indicador verde exitoso, dejando disponible el archivo APK para descarga.
* **Retos:**
* *Reto 1 (Fácil):* Configurar el pipeline para que falle de forma estricta si el comando `flutter analyze` encuentra un solo detalle de advertencia en el código. **Criterio:** El paso de análisis debe retornar código de error si el linter no está limpio.
* *Reto 2 (Medio):* Configurar variables de entorno y secretos seguros (*GitHub Secrets*) para inyectar una clave API simulada o firma digital durante la compilación en la nube sin exponerla en el código público. **Criterio:** El workflow debe leer variables usando `${{ secrets.TU_VARIABLE }}`.


* **Errores comunes & pistas:**
* *Síntoma:* El paso de compilación en el servidor Linux falla indicando que no se encuentra el comando de Flutter o que hay problemas con la versión de Java SDK.
* *Pista:* Asegúrate de colocar en orden cronológico correcto las acciones de configuración (`subosito/flutter-action` y `actions/setup-java`) antes de ejecutar cualquier comando nativo de terminal.


* **Extensión opcional:** Integrar un paso automatizado que envíe una notificación directa a un canal de Slack o Discord informando el estado final del build con el enlace del artefacto compilado.

---

## 7. Integración Final & Demo

### Pasos de Ensamblaje Final:

1. Asegúrate de enlazar la inicialización de tu enrutador (`app_router.dart`) en el método constructor principal de tu `MaterialApp.router`.
2. Envuelve el alcance de tu enrutador con el componente inyector de estado global (`BlocProvider`), garantizando que la información del GPS persista correctamente sin importar los cambios topológicos de pantallas.
3. Cerciórate de limpiar todas las directivas de warnings del compilador antes de enviar el push definitivo al servidor de integración automatizada.

### Checklist Final de Verificación:

* [ ] La aplicación se inicia directamente en la pantalla de Login y respeta las restricciones de navegación si no se cuenta con credenciales válidas.
* [ ] La adquisición de coordenadas de geolocalización por GPS funciona fluidamente al presionar el botón de inicio de recorrido.
* [ ] Las pruebas de software automatizadas registran una ejecución exitosa en su totalidad en el entorno local.
* [ ] Las vistas de rendimiento de DevTools no demuestran anomalías drásticas de consumo de RAM ni picos de sobre-dibujo de widgets.
* [ ] El pipeline remoto de CI/CD se activa de forma automática ante actualizaciones y genera la APK final sin intervenciones manuales.

### Guion Corto para Demo de Cierre:

1. **Inicio Seguro:** Muestra la pantalla inicial, intenta forzar el acceso a la ruta de tracking mediante url o navegación simulada para comprobar que el sistema te devuelve al Login.
2. **Monitoreo en Vivo:** Inicia sesión, pulsa en la opción de grabación y activa la simulación de movimiento GPS. Demuestra que las coordenadas se despliegan en pantalla en tiempo real de forma reactiva.
3. **Optimización Verificada:** Abre brevemente la interfaz de DevTools demostrando la estabilidad de FPS de la sesión interactiva.
4. **Prueba Automática:** Ejecuta el comando de pruebas en la consola del auditor técnico para validar la barra verde de éxito.
5. **Cierre en la Nube:** Entra a la interfaz web del pipeline de CI/CD para validar el historial limpio de compilación remota de la última entrega de software.

---

## 8. Rúbrica de Evaluación (Escala 0–5)

Para alcanzar una calificación perfecta de **5/5**, el proyecto final entregado debe cumplir rigurosamente con los siguientes criterios de excelencia por dimensión técnica:

| Criterio | Descripción para Nivel Excelente (5/5) |
| --- | --- |
| **Funcionalidad** | La navegación por rutas restringidas responde de forma perfecta, el flujo del GPS se adapta correctamente a las peticiones del sistema operativo y los datos persisten sin pérdidas durante toda la sesión móvil. |
| **Calidad Técnica** | Clara separación de responsabilidades arquitectónicas (Clean Architecture / Layered). El estado está completamente aislado de la UI mediante BLoC. Sin código espagueti ni importaciones cruzadas prohibidas. |
| **UX / UI** | Las transiciones de pantalla son fluidas (estables a 60 FPS). La aplicación maneja de manera proactiva los estados de carga, denegación de permisos de hardware y errores mediante interfaces claras para el usuario. |
| **Pruebas / Perfilamiento** | Cobertura de pruebas unitarias y de widgets verificada superior al 70%. Ausencia comprobada de fugas de memoria remanentes y optimización con el uso de widgets inmutables. |
| **CI / CD** | Pipeline YAML completamente funcional que automatiza el análisis, las pruebas y compila de forma limpia emitiendo un artefacto APK listo para distribución ante un cambio de código. |

---

## 9. Material de Apoyo

### Enlaces Oficiales:

* [Flutter Navigation & Routing - Oficial](https://docs.flutter.dev/ui/navigation)
* [Bloc State Management Documentation](https://bloclibrary.dev/)
* [Geolocator Plugin - Pub.dev Reference](https://pub.dev/packages/geolocator)
* [Flutter DevTools Performance Diagnostics](https://www.google.com/search?q=https://docs.flutter.dev/development/tools/devtools/performance)
* [Building Flutter Apps with GitHub Actions](https://www.google.com/search?q=https://docs.github.dev/en/actions)

### Glosario Breve:

* **Declarative Routing:** Filosofía de diseño de interfaces donde las rutas actuales reflejan de forma directa el estado interno computable de la aplicación en lugar de una lista secuencial de comandos históricos empujados de manera manual.
* **Streams:** Flujos o canales asíncronos de datos continuos capaces de emitir múltiples eventos de información ordenada a lo largo del tiempo (fundamentales para la lectura de sensores de hardware continuos).
* **Jank:** Retraso visual perceptible experimentado por el usuario final cuando la tasa de refresco gráfico de la aplicación cae abruptamente debido a sobrecarga de cómputo síncrono en el hilo principal de renderizado de la UI.
* **CI/CD:** Práctica de ingeniería de software orientada a la Integración Continua y Entrega Continua encargada de unificar, validar y empaquetar de forma desatendida las bases de código de un equipo de trabajo.