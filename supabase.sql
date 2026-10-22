-- Reestructuración PETROSAR · tabla de temas
-- Pegar en Supabase → SQL Editor → Run

create table if not exists reestr_temas (
  id text primary key,
  data jsonb not null,
  updated_at timestamptz not null default now()
);

alter table reestr_temas enable row level security;

-- Cualquiera con el link puede LEER. Para escribir, la app usa /api/save con la clave de edición.
drop policy if exists "lectura publica" on reestr_temas;
create policy "lectura publica" on reestr_temas for select using (true);

-- Carga inicial (no pisa datos si ya existen)
insert into reestr_temas (id, data) values
  ('t01', '{"actualizado": "2026-10-19T18:30:00.000Z", "avance": "Salen 10,5 en Etapa 1 y 3 en Etapa 2 (13,5)", "directo": false, "estado": "pendiente", "hoy": 28.5, "links": [], "nombre": "PTC y PRF", "notas": "Cambio de diagrama de 4x4 a 6x3 en PTC CD, PTC VH y PRF. Etapa 1: las tres plantas a 6x3 con 2 operadores por turno; salen 4 personas por planta (12). Etapa 2: PRF a 1 operador por turno, después de la automatización de bateas y la coordinación de recursos; salen 3 más. Total: 15.", "orden": 1, "propA": 15, "tipo": "analisis"}'::jsonb),
  ('t02', '{"estado": "pendiente", "links": [], "nombre": "Operación PIU", "orden": 2, "tipo": "definir", "directo": false}'::jsonb),
  ('t03', '{"estado": "pendiente", "links": [], "nombre": "OMF", "orden": 3, "tipo": "definir", "directo": false}'::jsonb),
  ('t04', '{"actualizado": "2026-10-19T15:45:00.000Z", "directo": false, "estado": "pendiente", "links": [], "nombre": "Cuadrilla de Reparación de Válvulas", "notas": "Propuesta de la Gerencia Operativa: una cuadrilla que repara en el pozo las válvulas esclusa API 6A con fuga o engranadas (2″ a 3 1/8″, hasta 10.000 psi), cambiando solo empaquetadura (polipack) y crapodinas, sin retirar la válvula. El contrasiento (cierre metal-metal) hace el trabajo seguro aun en pozos que desplazan. También permite reparar retenciones del puente de producción.", "orden": 4, "slides": ["slides/t04-1.jpg", "slides/t04-2.jpg", "slides/t04-3.jpg", "slides/t04-4.jpg", "slides/t04-5.jpg", "slides/t04-6.jpg"], "tipo": "presentacion"}'::jsonb),
  ('t05', '{"actualizado": "2026-10-20T15:20:00.000Z", "avance": "6x3 + Rep. Líneas · 47 personas", "directo": false, "estado": "propuesta", "links": [], "nombre": "Cuadrilla mixta - soldadores", "orden": 5, "tipo": "analisis"}'::jsonb),
  ('t06', '{"actualizado": "2026-10-19T15:30:00.000Z", "directo": false, "estado": "pendiente", "links": [], "nombre": "Cuadrilla Integral de Reparación de Líneas", "notas": "Propuesta de la Gerencia Operativa: una cuadrilla integral con camión 6x4 equipado (motosoldadora, cisterna 3000 l, mini retroexcavadora, detector de interferencias, medición de espesores, kit PRFV) que hace la reparación de líneas punta a punta, en lugar de coordinar hasta cuatro contratistas. Alcance: líneas de conducción/inyección de pozos, manifold, satélites y ductos de calderas, hasta 4\", acero o PRFV. Hoy las cuadrillas mixtas y soldadores pierden 4% del tiempo esperando recursos y 0,4% por suspensiones.", "orden": 6, "slides": ["slides/t06-1.jpg", "slides/t06-2.jpg", "slides/t06-3.jpg", "slides/t06-4.jpg", "slides/t06-5.jpg"], "tipo": "presentacion"}'::jsonb),
  ('t07', '{"estado": "pendiente", "links": [], "nombre": "Supervisión / SSA", "orden": 7, "tipo": "definir", "directo": false}'::jsonb),
  ('t08', '{"estado": "pendiente", "links": [], "nombre": "Transporte", "orden": 8, "tipo": "definir", "directo": false}'::jsonb),
  ('t09', '{"estado": "pendiente", "links": [], "nombre": "VTV", "orden": 9, "tipo": "definir", "directo": false}'::jsonb),
  ('t10', '{"actualizado": "2026-10-19T14:50:00.000Z", "avance": "Fichas en carga", "directo": false, "estado": "evaluacion", "hoy": 39, "links": [], "nombre": "Mantenimiento automotor", "notas": "Evaluación por puesto con el Jefe de Taller iniciada el 19/10/2026. Quién queda en cada puesto sale del puntaje de las fichas.", "orden": 10, "propA": 34, "propB": 32, "tipo": "analisis"}'::jsonb)
on conflict (id) do nothing;
