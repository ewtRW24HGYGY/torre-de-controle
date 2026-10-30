# Torre de Controle

Plataforma da equipe para gerir projetos: quadro kanban, prioridades, dependências entre tarefas e visão geral do andamento.

## Como funciona

- **Projetos** com código curto (ex: `APP`). As tarefas ganham chaves como `APP-1`.
- **Quadro** com Backlog, A fazer, Em andamento, Revisão e Concluído. Arraste os cartões entre as colunas.
- **Prioridade**: Urgente, Alta, Média e Baixa. Cada coluna fica ordenada por prioridade e prazo.
- **Dependências**: uma tarefa só entra em andamento quando as tarefas de que ela depende estiverem concluídas. A plataforma não deixa criar dependências em círculo.
- **Visão geral**: progresso por projeto, as próximas tarefas livres e quem está esperando por quem.

É um site estático (HTML + JavaScript) publicado no GitHub Pages. Os dados ficam no [Supabase](https://supabase.com), que é gratuito.

## Configurar o banco (uma vez só)

1. Crie uma conta em [supabase.com](https://supabase.com) e depois um projeto novo.
2. No projeto, abra **SQL Editor → New query**, cole o conteúdo de [`supabase-setup.sql`](supabase-setup.sql) e clique em **Run**.
3. Abra **Project Settings → API** e copie a **Project URL** e a chave pública (**anon** ou **publishable**).
4. Cole os dois valores em [`config.js`](config.js) e faça commit.

Em um ou dois minutos, o GitHub Pages publica a versão nova.

## Segurança

As políticas do `supabase-setup.sql` deixam **qualquer pessoa com o link do site** ler e editar os dados. Para uso interno de uma equipe pequena isso costuma bastar, mas não coloque informação sensível. Para restringir o acesso, o próximo passo é adicionar login com o Supabase Auth.
