# Flutter Character App

Aplicación Flutter para explorar y visualizar información de personajes de series animadas. La aplicación incluye funcionalidades de búsqueda, filtrado, paginación infinita y widgets nativos para Android e iOS.

## Características Principales

- Listado de personajes con paginación infinita
- Búsqueda y filtrado por género y especie
- Detalles de personajes con estadísticas y episodios
- Información de series (shows)
- Widget nativo para pantalla de inicio (Android e iOS)
- Caché de imágenes para widgets
- Fuente personalizada (SulphurPoint)

## Estructura del Proyecto

```
lib/
├── main.dart                          # Punto de entrada de la aplicación
└── src/
    ├── components/                    # Componentes reutilizables
    │   ├── building_animation.dart
    │   ├── circle_icon_button.dart
    │   ├── loading_component.dart
    │   └── popup_menu.dart
    ├── models/                        # Modelos de datos
    │   ├── character_model.dart
    │   ├── character_stat_model.dart
    │   ├── episode_model.dart
    │   └── show_model.dart
    ├── routes/                        # Configuración de rutas
    │   ├── app_routes.dart
    │   ├── route_names.dart
    │   └── index.dart
    ├── screen/                        # Pantallas de la aplicación
    │   ├── CharacterDetail/
    │   │   ├── character_detail_controller.dart
    │   │   ├── character_detail_screen.dart
    │   │   └── components/
    │   ├── Home/
    │   │   ├── home_controller.dart
    │   │   ├── home_screen.dart
    │   │   └── components/
    │   └── ShowDetail/
    │       ├── show_detail_cntroller.dart
    │       └── show_detail_screen.dart
    ├── services/                      # Servicios de API
    │   ├── character_service.dart
    │   ├── home_service.dart
    │   └── show_service.dart
    ├── theme/                         # Configuración de tema
    │   ├── app_colors.dart
    │   ├── app_fonts.dart
    │   └── app_theme.dart
    └── utils/                         # Utilidades
        ├── character_stat_mock.dart
        ├── constants.dart
        ├── dio_client.dart
        └── functions.dart
```

## Gestión de Estado

El proyecto utiliza **MobX** como gestor de estado reactivo. Los controladores están ubicados en cada pantalla y utilizan las siguientes anotaciones:

- `@observable`: Para variables que cambian y deben ser observadas
- `@computed`: Para valores calculados que dependen de observables
- `@action`: Para métodos que modifican el estado

### Ejemplo de Controlador

```dart
abstract class HomeControllerBase with Store {
  @observable
  List<Character> characters = [];
  
  @observable
  String searchQuery = '';
  
  @computed
  List<String> get availableGenders {
    // Lógica de cálculo
  }
  
  @action
  void setSearchQuery(String value) {
    searchQuery = value;
    filteredCharacters = _applyFilters();
  }
}
```

**Importante**: Después de modificar un controlador MobX, es necesario regenerar los archivos `.g.dart` ejecutando:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## DioClient

El proyecto implementa un cliente HTTP personalizado basado en **Dio** que permite manejar múltiples instancias con diferentes URLs base. Esto es útil cuando la aplicación consume múltiples APIs.

### Características

- Patrón Singleton con soporte para múltiples instancias
- Timeouts configurables (20s conexión, 60s recepción)
- Headers automáticos para JSON
- Métodos `httpGet` y `httpPost`

### Uso

```dart
// Instancia por defecto (API Futurama)
final response = await DioClient.instance.httpGet('/characters');

// Instancia personalizada (OMDB API)
final dioClient = DioClient.getInstance(apiUrl);
final response = await dioClient.httpGet('', queryParameters: {'t': seriesName});
```

## Dependencias Principales

- **dio**: Cliente HTTP
- **mobx** / **flutter_mobx**: Gestión de estado reactivo
- **home_widget**: Widgets nativos para Android e iOS
- **intl**: Internacionalización y formateo de fechas
- **lottie**: Animaciones

## Compilación del Proyecto

### Requisitos Previos

- Flutter SDK 3.10.0 o superior
- Dart SDK incluido con Flutter
- Android Studio / Xcode (según plataforma)
- Para Android: Android SDK configurado
- Para iOS: Xcode y CocoaPods instalados

### Pasos para Compilar

1. **Clonar e instalar dependencias**

```bash
git clone <repository-url>
cd flutter_character_app
flutter pub get
```

2. **Regenerar archivos MobX (si es necesario)**

```bash
dart run build_runner build --delete-conflicting-outputs
```

3. **Compilar para Android**

```bash
# APK de debug
flutter build apk

# APK de release
flutter build apk --release

# App Bundle para Play Store
flutter build appbundle --release
```

4. **Compilar para iOS**

```bash
# Instalar pods (primera vez)
cd ios
pod install
cd ..

# Build para iOS
flutter build ios

# Build para release
flutter build ios --release
```

5. **Ejecutar en dispositivo/emulador**

```bash
# Android
flutter run

# iOS
flutter run

# Especificar dispositivo
flutter devices
flutter run -d <device-id>
```

### Notas de Compilación

- **Android**: El proyecto incluye configuración para permitir tráfico HTTP (necesario para algunas APIs). Ver `android/app/src/main/AndroidManifest.xml`
- **iOS**: Requiere configuración de certificados de desarrollo en Xcode
- **Widgets**: Los widgets nativos requieren configuración adicional. Ver documentación de `home_widget` para detalles específicos de cada plataforma

## Configuración de APIs

El proyecto consume dos APIs principales:

1. **Futurama API**: Para datos de personajes
2. **OMDB API**: Para información de series

Las URLs y claves de API están configuradas en `lib/src/utils/constants.dart`. Asegúrate de configurar las credenciales necesarias antes de compilar.

## Licencia

Este proyecto es de uso educativo.

## Firebase App
https://appdistribution.firebase.dev/i/3a9a7a13a2750270