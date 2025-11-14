# 🎬 Mi App Firebase - Catálogo de Películas

Una aplicación Flutter completa para gestionar un catálogo de películas con integración a Firebase Firestore y Storage.

## ✨ Características

- ✅ **Pantalla de Inicio:** Bienvenida con opciones de registro e inicio de sesión
- ✅ **Pantalla de Catálogo:** Visualización de películas con título e imagen
- ✅ **Pantalla de Detalle:** Información completa de cada película (título, año, director, género, sinopsis)
- ✅ **Pantalla de Administración:** Agregar y eliminar películas del catálogo
- ✅ **Base de Datos:** Integración con Firebase Firestore
- ✅ **Almacenamiento:** Subida de imágenes a Firebase Storage
- ✅ **Autenticación:** Sistema de registro y login básico

## 🏗️ Estructura del Proyecto

```
lib/
├── main.dart                    # Punto de entrada
├── pantalla_inicio.dart         # Pantalla de bienvenida
├── registro_usuario.dart        # Registro de usuario
├── login_usuario.dart           # Inicio de sesión
├── pantalla_catalogo.dart       # Lista de películas
├── pantalla_detalle.dart        # Detalle de película
├── pantalla_admin.dart          # Administración (alta/baja)
├── firebase_options.dart        # Configuración de Firebase
├── models/movie.dart            # Modelo de película
└── services/                    # Servicios Firebase
```

## 📋 Requisitos Previos

- Flutter 3.24.0 o superior
- Dart 3.5.0 o superior
- Proyecto Firebase configurado
- Firestore Database habilitada

## 🚀 Instalación y Ejecución

### 1. Obtener dependencias
```powershell
flutter pub get
```

### 2. Configurar Firebase Firestore
Lee la guía en `FIREBASE_SETUP_GUIDE.md` para:
- Habilitar Firestore Database
- Crear colección "peliculas"
- Habilitar Storage (opcional)
- Habilitar Authentication (Email/Password)
- Configurar reglas de seguridad

### 3. Ejecutar la app
```powershell
flutter run
```

### 4. Verificar que no hay errores
```powershell
flutter analyze
# Resultado esperado: No issues found!
```

## 📱 Flujo de la Aplicación

1. **PantallaInicio** → Bienvenida con opciones "Registrarse" o "Ingresar"
2. **RegistroUsuario** → Ingresa nombre, guarda en Firestore
3. **LoginUsuario** → Ingresa nombre, accede al catálogo
4. **PantallaCatalogo** → Lista de películas de Firestore (actualización en tiempo real)
   - Cada película muestra: imagen + título + género
   - Toca para ver detalles
   - Icono de admin (arriba) para ir a administración
5. **PantallaDetalle** → Detalles completos (título, año, director, género, sinopsis, imagen)
6. **PantallaAdmin** → Administración:
   - Agrega película (aparece en Firestore y se refleja en catálogo)
   - Elimina película (se elimina de Firestore inmediatamente)

## ✅ Estado del Proyecto

- ✅ Sin errores de compilación
- ✅ `flutter analyze` = OK (sin issues)
- ✅ Estructura limpia y consolidada
- ✅ Listo para entregar

## 📚 Documentación Adicional

- `FIRESTORE_SETUP.md` - Configuración detallada de Firestore
- `CONSOLIDATION_NOTES.md` - Notas de consolidación

**Versión:** 1.0.0 | **Estado:** ✅ Listo para Entregar
