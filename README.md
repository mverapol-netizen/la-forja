# La Forja

Revista digital independiente de pensamiento crítico, opinión, ensayo, educación popular y creación cultural.

Sitio oficial: **https://revistalaforja.cl** (en configuración). Contacto editorial: **revistalaforja@gmail.com**.

## Código y edición

Esta es la fuente original de La Forja en Astro, migrada desde la carpeta `la-forja-src/` del repositorio anterior. Se conservan el diseño, las páginas, el formulario, el panel administrativo y los mecanismos de notificaciones. La información editorial recibida permanece en el proyecto de Supabase ya existente.

Las publicaciones se gestionan en `src/content/` y se crean a partir de `templates/`. Comenzar con `draft: true`, realizar revisión y cambiar a `draft: false` cuando se apruebe. Acceder al panel privado en `/admin/`.

## Publicación del sitio

GitHub Actions compila el código de `main` con `npm install && npm run build`, ejecuta `node scripts/audit-public.mjs` y despliega la carpeta `dist/` por GitHub Pages. Para activarlo, entrar a **Settings → Pages → Build and deployment → Source: GitHub Actions**. En **Custom domain**, ingresar `revistalaforja.cl`. Activar **Enforce HTTPS** una vez emitido el certificado.

La versión anterior en `https://mverapol-netizen.github.io/la-forja/` queda intacta por ahora como respaldo. No configurar el dominio nuevo en el repositorio personal `mverapol-netizen.github.io`.

## DNS: revistalaforja.cl

El dominio .cl requiere que NIC Chile delegue sus servidores DNS. Si se utiliza Cloudflare gratuito, configurar en NIC los dos nombres de servidor que Cloudflare proporcione y crear los siguientes registros en Cloudflare (modo **DNS only** durante la puesta en marcha):

- `A @ 185.199.108.153`
- `A @ 185.199.109.153`
- `A @ 185.199.110.153`
- `A @ 185.199.111.153`
- `CNAME www mverapol-netizen.github.io`

Opcionalmente se pueden agregar los registros AAAA oficiales de GitHub Pages. En GitHub se recomienda verificar la propiedad del dominio con un TXT antes de conectar los DNS públicos. No utilizar un CNAME que incluya `/la-forja/`.

## Desarrollo local

```bash
npm install
npm run dev
npm run build
node scripts/audit-public.mjs
```

No guardar en GitHub contraseñas ni tokens privados. Los secretos para notificaciones pertenecen a Supabase Vault / Apps Script, como describe `automation/README.md`.

## Identidad gráfica · logo miniatura

El monograma **LF** (cuadrado rojo editorial, letras color papel, textura de anillos concéntricos) es el distintivo reducido oficial de la revista. Se conserva como dibujo vectorial SVG en:

- `public/branding/lf-mini.svg`: archivo maestro editable de la versión miniatura.
- `public/favicon.svg`: copia destinada a la pestaña del navegador.

El layout `src/layouts/BaseLayout.astro` inserta automáticamente el favicon en todas las páginas y añade una versión de caché asociada al despliegue para que los navegadores lo renueven después de publicar cambios.


## Estadísticas editoriales

El sitio registra lecturas anónimas de ensayos y columnas en Supabase. No almacena direcciones IP, nombres, identificadores de lectores ni agentes de usuario; únicamente un registro con el artículo y la fecha en Chile. El navegador contabiliza un máximo de una lectura por artículo, pestaña y día; se respetan Do Not Track y Global Privacy Control cuando el navegador lo informa. Son cifras orientativas, no personas únicas ni métricas a prueba de tráfico automatizado.

Desde el panel existente **/admin/** se accede a **/admin/estadisticas/**. Tras iniciar sesión con una cuenta editorial autorizada se pueden filtrar los datos por mes y formato, consultar el ranking, ver la evolución diaria y exportar CSV. Los resúmenes están protegidos por autenticación y reglas de seguridad de filas (RLS); no son públicos. La selección de destacados sigue siendo una decisión editorial y se controla con el atributo de artículo \`featured\` en GitHub. El esquema está documentado en \`automation/analytics-readership.sql\`.

La recopilación comenzó al desplegar el contador en octubre de 2026; no hay datos históricos anteriores.
