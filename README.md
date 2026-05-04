# EstudioIA-Formulario

Aplicación iOS desarrollada en SwiftUI que permite a los usuarios enviar formularios con validación, persistencia en Supabase y confirmación de envío.

- Formulario: Campos incluidos -> Título, Descripción, Categoría, Prioridad (1–5) y Email

- Validaciones: Título -> 5–60 caracteres
                Descripción -> 20–500 caracteres
                Email -> formato válido (@ y .)
                Prioridad -> obligatoria (1–5)

- Control de envío: Botón deshabilitado si hay errores
                    Estado "Enviando..." durante la petición
                    Prevención de doble envío

- Persistencia: Base de datos: Supabase
                Tabla: formularios

- Manejo de errores: Alert con mensaje claro
                     Opción de reintentar
                     Manejo de fallos de red/permisos

Problema conocido:
Actualmente, la aplicación no consigue conectarse correctamente a Supabase -> Error: A TLS error caused the secure connection to fail
El error ocurre al intentar realizar la inserción en la base de datos. Indica un fallo en la conexión segura (HTTPS/TLS) entre la app y el servidor de Supabase.

Estado actual:
El formulario funciona correctamente a nivel de UI y validación, pero la persistencia en Supabase no está operativa debido a este error de conexión TLS.
