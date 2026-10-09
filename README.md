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
