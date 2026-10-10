-- La Forja | Estadísticas editoriales anónimas
-- Esquema equivalente a la migración aplicada en Supabase el 2026-10-10.
-- La base no conserva IP, user agent, cookies ni identificadores de personas.
create table if not exists public.editorial_article_views (
  id bigint generated always as identity primary key,
  article_slug text not null check (article_slug ~ '^[a-z0-9][a-z0-9-]{4,139}$'),
  kind text not null check (kind in ('ensayo','columna')),
  viewed_on date not null default ((now() at time zone 'America/Santiago')::date)
);
create index if not exists editorial_article_views_day_slug_idx
  on public.editorial_article_views (viewed_on,kind,article_slug);
alter table public.editorial_article_views enable row level security;
revoke all on table public.editorial_article_views from public,anon,authenticated;
grant insert (article_slug,kind) on table public.editorial_article_views to anon;
grant select on table public.editorial_article_views to authenticated;
grant all on table public.editorial_article_views to service_role;
drop policy if exists "la_forja_public_records_article_view" on public.editorial_article_views;
create policy "la_forja_public_records_article_view"
  on public.editorial_article_views for insert to anon
  with check (article_slug ~ '^[a-z0-9][a-z0-9-]{4,139}$' and kind in ('ensayo','columna'));
drop policy if exists "la_forja_editorial_reads_article_views" on public.editorial_article_views;
create policy "la_forja_editorial_reads_article_views"
  on public.editorial_article_views for select to authenticated
  using (lower(coalesce((select auth.jwt()->>'email'),'')) in
    ('mvera.pol@gmail.com','revistalaforja@gmail.com'));
create or replace view public.editorial_monthly_readership with (security_invoker=true) as
  select to_char(viewed_on,'YYYY-MM') month,article_slug,kind,
         count(*)::bigint views,count(distinct viewed_on)::integer days_with_views
  from public.editorial_article_views group by 1,2,3;
create or replace view public.editorial_daily_readership with (security_invoker=true) as
  select viewed_on,article_slug,kind,count(*)::bigint views
  from public.editorial_article_views group by 1,2,3;
revoke all on public.editorial_monthly_readership from public,anon,authenticated;
revoke all on public.editorial_daily_readership from public,anon,authenticated;
grant select on public.editorial_monthly_readership to authenticated,service_role;
grant select on public.editorial_daily_readership to authenticated,service_role;
comment on table public.editorial_article_views is
  'Lecturas anónimas por publicación y día, sin IP, cookies, user agent ni identificadores de visitantes.';
