# 🔧 Configuración de Firebase Firestore - Guía Paso a Paso

## Paso 1: Acceder a Firebase Console
1. Ve a [https://console.firebase.google.com](https://console.firebase.google.com)
2. Selecciona tu proyecto
3. En el menú izquierdo, ve a **Build** → **Firestore Database**

## Paso 2: Crear Colección "peliculas"
1. Haz clic en **"Create collection"** (o **"Start collection"** si es la primera)
2. Nombre de colección: `peliculas`
3. Haz clic en **"Next"**

## Paso 3: Agregar Documento Ejemplo
1. Se abrirá un formulario para crear el primer documento
2. **Document ID**: Dejar vacío (Firestore genera uno automáticamente) o escribir un ID custom
3. Agregar campos haciendo clic en **"Add field"**

### Estructura de Documento (Campos Requeridos)

| Campo | Tipo | Valor Ejemplo |
|-------|------|---------------|
| `titulo` | String | "El Señor de los Anillos" |
| `anio` | Number | 2001 |
| `director` | String | "Peter Jackson" |
| `genero` | String | "Fantasía, Aventura" |
| `sinopsis` | String | "En la Tierra Media, un hobbit debe destruir el Anillo Único..." |
| `imagenUrl` | String | "https://example.com/imagen.jpg" |
| `creadoEn` | Timestamp | (Click en reloj, fecha actual) |

### Ejemplo de Documento Completo (JSON)
```json
{
  "titulo": "El Señor de los Anillos: La Comunidad del Anillo",
  "anio": 2001,
  "director": "Peter Jackson",
  "genero": "Fantasía, Aventura",
  "sinopsis": "En la Tierra Media, el hobbit Frodo Bolsón hereda un anillo mágico de su tío Bilbo. Gandalf, un mago, revela que el anillo es el Anillo Único, un arma de poder inimaginable que debe ser destruida.",
  "imagenUrl": "https://m.media-amazon.com/images/M/MV5BN2EyZjM3NzUtNWY2MC00NzZiLTg1ZDAtYTRlcDViZjAwMDU1XkEyXkFqcGdeQXVyNDUzOTQ5MjY@._V1_SX300.jpg",
  "creadoEn": "2024-11-14T10:30:00Z"
}
```

## Paso 4: Agregar más Películas (Opcional)
Repite el Paso 3 para agregar más películas. Ejemplos:

### Película 2
```json
{
  "titulo": "Avatar",
  "anio": 2009,
  "director": "James Cameron",
  "genero": "Ciencia Ficción, Aventura",
  "sinopsis": "Un paralítico mental es trasladado a un cuerpo avatar donde puede vivir una vida nueva en un mundo alienígena.",
  "imagenUrl": "https://m.media-amazon.com/images/M/MV5BMjMxNjg2NDQtYTQ0NC00YjU4LWFlNzAtODczNzI1ZDMzMDkwXkEyXkFqcGdeQXVyNjc1NjU0NTg@._V1_SX300.jpg",
  "creadoEn": "2024-11-14T10:31:00Z"
}
```

### Película 3
```json
{
  "titulo": "Titanic",
  "anio": 1997,
  "director": "James Cameron",
  "genero": "Drama, Romance",
  "sinopsis": "84 años después del hundimiento del Titanic, una joven dibujante rememora el viaje que compartió con el corazón de Jack Dawson.",
  "imagenUrl": "https://m.media-amazon.com/images/M/MV5BMDdmZGU3NDQtY2VlZC00MDAxLWI4ZjgtYTk3YzMyNDk3NzQzXkEyXkFqcGdeQXVyNTA4NzY1MzY@._V1_SX300.jpg",
  "creadoEn": "2024-11-14T10:32:00Z"
}
```

## Paso 5: Configurar Reglas de Seguridad (Importante para Pruebas)
1. En Firestore, ve a la pestaña **"Rules"**
2. Reemplaza el contenido con estas reglas (solo para desarrollo/pruebas):

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Permitir lectura/escritura sin autenticación (SOLO PARA DESARROLLO)
    match /{document=**} {
      allow read, write: if true;
    }
  }
}
```

⚠️ **NOTA:** Estas reglas son inseguras. Para producción, debes ajustarlas para que solo usuarios autenticados puedan escribir/leer.

## Paso 6: Configurar Firebase Storage (Para Subir Imágenes)
1. Ve a **Build** → **Storage**
2. Haz clic en **"Get Started"**
3. Crea un bucket (default)
4. En la pestaña **"Rules"**, reemplaza con:

```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    // Permitir lectura/escritura sin autenticación (SOLO PARA DESARROLLO)
    match /{allPaths=**} {
      allow read, write: if true;
    }
  }
}
```

## Paso 7: Verificar en la App
1. Ejecuta tu app en emulador/dispositivo:
```powershell
flutter run
```
2. Abre la app → Ve a **Administración**
3. Agrega una película manualmente
4. Verifica en Firestore Console que aparece la película

## ✅ Checklist de Configuración
- [ ] Proyecto Firebase creado
- [ ] Firestore habilitada
- [ ] Colección "peliculas" creada
- [ ] Al menos 1 documento de ejemplo agregado
- [ ] Reglas de Firestore configuradas
- [ ] Storage habilitado y configurado
- [ ] `firebase_options.dart` tiene la configuración correcta
- [ ] App compilada sin errores (`flutter analyze` = OK)

## 🐛 Troubleshooting

### Error: "PERMISSION_DENIED"
**Causa:** Reglas de Firestore restrictivas  
**Solución:** Ve a Rules → reemplaza con el código de desarrollo del Paso 5

### Error: "Collection not found"
**Causa:** Colección "peliculas" no existe  
**Solución:** Crea la colección siguiendo el Paso 2

### Las imágenes no cargan
**Causa:** URL de imagen inválida o Storage no configurado  
**Solución:** Usa URLs de imágenes públicas (HTTPS) o sube a Firebase Storage

### La app no se conecta a Firebase
**Causa:** `firebase_options.dart` no tiene la configuración correcta  
**Solución:** Re-genera el archivo ejecutando `flutterfire configure`

## 📝 Campos de la Colección "peliculas"

La app espera estos campos en cada documento:

```dart
{
  "titulo": String,        // Título de la película
  "anio": int/number,      // Año de estreno (número)
  "director": String,      // Nombre del director
  "genero": String,        // Género(s) separados por comas
  "sinopsis": String,      // Descripción de la película
  "imagenUrl": String,     // URL de la imagen (HTTPS)
  "creadoEn": Timestamp    // Fecha de creación (auto-generada)
}
```

## ✅ Una vez completado:
Tu app está lista para:
- ✅ Ver catálogo de películas desde Firestore
- ✅ Ver detalles de cada película
- ✅ Agregar nuevas películas (admin)
- ✅ Eliminar películas (admin)
- ✅ Subir imágenes a Firebase Storage
