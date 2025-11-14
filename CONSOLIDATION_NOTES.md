# Consolidación de Pantallas - Notas de Migración

## Archivos Mantenidos (Pantallas en Español - ACTIVOS)
Estos archivos se usan actualmente en la aplicación:

- `lib/main.dart` — Punto de entrada principal
- `lib/pantalla_inicio.dart` — Pantalla de bienvenida (registro/login)
- `lib/registro_usuario.dart` — Registro de usuario
- `lib/login_usuario.dart` — Inicio de sesión
- `lib/pantalla_catalogo.dart` — Catálogo de películas (lista)
- `lib/pantalla_detalle.dart` — Descripción detallada de película
- `lib/pantalla_admin.dart` — Administración (alta/baja de películas)

## Archivos Antiguos/Duplicados (OBSOLETOS - Pueden Eliminarse)
Estos archivos ya no se usan. Fueron reemplazados por las versiones en español:

- `lib/admin_peliculas.dart` — Reemplazado por `pantalla_admin.dart`
- `lib/catalogo_peliculas.dart` — Reemplazado por `pantalla_catalogo.dart`
- `lib/descripcion_pelicula.dart` — Reemplazado por `pantalla_detalle.dart`

## Pantallas en Inglés en Subdirectorio (OBSOLETAS - Pueden Eliminarse)
Estos archivos en `lib/screens/` están obsoletos. La versión consolidada usa pantallas en español:

- `lib/screens/auth_screen.dart` — Reemplazado por `pantalla_inicio.dart` + `login_usuario.dart`
- `lib/screens/admin_screen.dart` — Reemplazado por `pantalla_admin.dart`
- `lib/screens/catalog_screen.dart` — Reemplazado por `pantalla_catalogo.dart`
- `lib/screens/detail_screen.dart` — Reemplazado por `pantalla_detalle.dart`

## Servicios y Modelos (ACTIVOS)
- `lib/services/auth_service.dart` — Servicio de autenticación Firebase
- `lib/services/firestore_service.dart` — Servicio de Firestore
- `lib/models/movie.dart` — Modelo de película

## Decisión de Consolidación
Se eligió mantener las pantallas en **español** (`pantalla_*`) como estándar del proyecto por:
1. Consistencia con la mayoría del código existente
2. Interfaz de usuario en español (idioma del proyecto)
3. Simplificación de la navegación y rutas

## Notas
- Todos los lints han sido corregidos (flutter analyze sin issues)
- La aplicación compila sin errores
- Usa Firebase 4.2.1 y Cloud Firestore 6.1.0 (versiones actualizadas)
