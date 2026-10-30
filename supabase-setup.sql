-- Torre de Controle: cole este script no Supabase (SQL Editor → New query → Run).
-- Cria a tabela que guarda projetos e tarefas, libera o acesso pela chave pública
-- e liga as atualizações em tempo real.

create table if not exists public.items (
  id         text primary key,
  kind       text not null check (kind in ('project', 'task')),
  data       jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.items enable row level security;

-- Atenção: estas políticas deixam qualquer pessoa com o link do site ler e editar.
-- Para restringir à equipe, o próximo passo é adicionar login (Supabase Auth).
drop policy if exists "equipe le"     on public.items;
drop policy if exists "equipe insere" on public.items;
drop policy if exists "equipe edita"  on public.items;
drop policy if exists "equipe apaga"  on public.items;

create policy "equipe le"     on public.items for select to anon, authenticated using (true);
create policy "equipe insere" on public.items for insert to anon, authenticated with check (true);
create policy "equipe edita"  on public.items for update to anon, authenticated using (true) with check (true);
create policy "equipe apaga"  on public.items for delete to anon, authenticated using (true);

-- Tempo real: todos veem as mudanças dos outros na hora.
do $$
begin
  if not exists (
    select 1 from pg_publication_tables
    where pubname = 'supabase_realtime' and schemaname = 'public' and tablename = 'items'
  ) then
    alter publication supabase_realtime add table public.items;
  end if;
end $$;
