# 📋 Guía Completa de Configuración Firebase

## Paso 1: Habilitar Firestore Database

1. En la consola de Firebase, ve a **"Firestore Database"**
2. Haz clic en **"Create database"**
3. Selecciona:
   - **Ubicación**: tu región (ej. `us-central1` o tu país)
   - **Modo**: **"Start in test mode"** (para desarrollo; cambia a producción después)
4. Haz clic en **"Create"**

### Reglas de Seguridad (Test Mode - Temporal)
```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if request.time < timestamp.date(2025, 12, 31);
    }
  }
}
```

**Importante:** Esto expira el 31/12/2025. Para producción, cambia las reglas a:
```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /peliculas/{document=**} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && request.auth.uid == request.resource.data.createdBy;
    }
    match /usuarios/{document=**} {
      allow read, write: if request.auth != null && request.auth.uid == resource.id;
    }
  }
}
```

---

## Paso 2: Crear Colección "peliculas"

1. En Firestore, haz clic en **"Start collection"**
2. Nombre de colección: **`peliculas`**
3. Haz clic en **"Next"**
4. Haz clic en **"Auto ID"** para generar ID automático
5. Añade este documento de ejemplo:

```json
{
  "titulo": "Inception",
  "anio": 2010,
  "director": "Christopher Nolan",
  "genero": "Ciencia Ficción",
  "sinopsis": "Un ladrón que roba secretos corporativos a través de tecnología de sueños compartidos.",
  "imagenUrl": "https://via.placeholder.com/300x450?text=Inception",
  "creadoEn": [timestamp actual]
}
```

6. Haz clic en **"Save"**

---

## Paso 3: Crear Colección "usuarios" (Opcional)

1. Haz clic nuevamente en **"Start collection"**
2. Nombre: **`usuarios`**
3. Añade un documento de ejemplo:

```json
{
  "nombre": "Paola",
  "email": "paola@example.com",
  "fecha": [timestamp actual]
}
```

---

## Paso 4: Habilitar Storage (para subir imágenes)

1. Ve a **"Storage"** en la consola de Firebase
2. Si dice "Para usar Storage, actualiza el plan de facturación":
   - Haz clic en **"Actualizar"** (plan Blaze - pago por uso, pero tienes cuota gratis)
   - O usa URLs directas de imágenes (como en el ejemplo anterior) sin subir imágenes

3. Una vez habilitado Storage, haz clic en **"Start"**
4. Acepta las reglas por defecto (Test Mode)
5. Haz clic en **"Done"**

### Reglas de Storage (Test Mode)
```
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /{allPaths=**} {
      allow read, write: if request.time < timestamp.date(2025, 12, 31);
    }
  }
}
```

---

## Paso 5: Habilitar Authentication (Email/Password)

1. Ve a **"Authentication"** en el menú izquierdo
2. Haz clic en **"Get started"**
3. Haz clic en **"Email/Password"**
4. Activa **"Email/Password"**
5. Haz clic en **"Save"**

---

## Paso 6: Verificar `firebase_options.dart`

Tu archivo `lib/firebase_options.dart` ya debe contener la configuración de tu proyecto. Verifica que tenga:

```dart
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return android;
    }
    // ... más plataformas
  }
  
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'YOUR_API_KEY',
    appId: 'YOUR_APP_ID',
    messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
    projectId: 'paola-app-firebase',
    // ...
  );
}
```

Si no tiene valores, ejecuta:
```powershell
flutterfire configure
```

---

## Paso 7: Prueba la Aplicación

### Compilar y ejecutar:
```powershell
cd C:\Users\paola\mi_app_firebase
flutter pub get
flutter run
```

### Flujo de prueba:
1. **Pantalla de Inicio** → Haz clic en "Registrarse"
2. **Registro** → Ingresa un nombre (guarda en Firestore → colección `usuarios`)
3. **Login** → Vuelve a la pantalla inicial y haz clic en "Ingresar"
4. **Catálogo** → Debe listar las películas de Firestore (la que creaste en Paso 2)
5. **Detalle** → Toca una película para ver todos sus detalles
6. **Administración** → Haz clic en el icono de admin en AppBar:
   - Agrega una nueva película (se guarda en Firestore)
   - Elimina una película
7. **Vuelve al Catálogo** → Verifica que los cambios se reflejan en tiempo real

---

## Troubleshooting

### ❌ Error: "Permission denied"
- Verifica que tus reglas de Firestore estén en **Test Mode**
- O actualiza las reglas de producción con permisos correctos

### ❌ Error: "Storage not enabled"
- Ve a Storage en la consola y haz clic en "Actualizar" para cambiar a plan Blaze

### ❌ Las películas no aparecen en el catálogo
- Verifica que creaste la colección **`peliculas`** exactamente con ese nombre
- Verifica que los documentos tienen los campos: `titulo`, `anio`, `director`, `genero`, `sinopsis`, `imagenUrl`, `creadoEn`

### ❌ Las imágenes no se cargan
- Si usas URLs directas (no Storage), asegúrate de que la URL es válida y accesible
- Si usas Storage, verifica que has habilitado Storage y cambiado el plan a Blaze

---

## URLs de Prueba (Imágenes Placeholder)

Si no tienes URLs de imágenes, usa estas en tu colección `peliculas`:

```
https://via.placeholder.com/300x450?text=Inception
https://via.placeholder.com/300x450?text=The+Dark+Knight
https://via.placeholder.com/300x450?text=Interstellar
https://via.placeholder.com/300x450?text=Titanic
https://via.placeholder.com/300x450?text=Avatar
```

---

## Resumen de Configuración

| Componente | Estado | Notas |
|-----------|--------|-------|
| Firestore | ✅ Habilitado | Colecciones: `peliculas`, `usuarios` |
| Storage | ✅ Habilitado (opcional) | Plan Blaze requerido |
| Authentication | ✅ Habilitado | Email/Password |
| Reglas | ✅ Test Mode | Cambiar a producción después |
| `firebase_options.dart` | ✅ Configurado | Ejecuta `flutterfire configure` si falta |

---

¡Listo! Tu aplicación debería estar totalmente funcional ahora. 🚀
