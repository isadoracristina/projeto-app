# Despensa
### Aplicativo de gerenciamento de alimentos.

### Equipe:

André Godoy -- backend dev  
Isadora Cristina -- full stack e PO  
Júlia Fonseca -- administradora do Banco de Dados  
Luiz Guilherme Leroy Vieira -- frontend dev  

### Escopo:

O sistema tem como objetivo auxiliar no uso dos alimentos que o usuário tem disponíveis em sua residência, de forma a diminuir o desperdício e incentivar um consumo mais consciente.

Dessa forma, a principal feature do sistema é permitir que o usuário possa filtrar, entre as receitas disponíveis, aquelas que tenham os ingredientes que ele quer. Além disso, uma outra forma de filtrar as receitas vai ser de acordo com tags que fazem referências a características do prato. 

Uma outra feature importante é a de cadastro de receitas, afinal o usuário poderá pesquisar apenas receitas que ele mesmo registrou no aplicativo.   

### Tecnologias utilizadas:

Framework: Flutter  
Linguagem: Dart  
Banco de Dados: SQLite (ou sqflite, seguindo o exemplo implementado pelo Flutter).

### Sprint 1

#### MVP:
É um sistema que o usuário cadastra as suas receitas e posteriormente pode pesquisá-las de acordo com os ingredientes que possui em casa. Essa busca pode ser feita com o auxílio de alguém (Mágico de Oz) ou pode ser feita uma espécie de indexação simples que o próprio usuário consiga pesquisar.

#### Backlog do Produto:  
O que vai ser implementado:  

- Cadastrar usuário  
- Fazer login  
- Cadastrar receita  
- Pesquisar receita com auxílio de filtros e tags  
____________________________

Outras funcionalidades:  

- Implementação de uma Despensa do usuário  
- Implementação de lista de compras  
- Coordenação entre receitas, Despensa e lista de compras  
- Compartilhamento de receitas entre usuários  
- Receitas coletivas  

#### Tarefas técnicas:  

- Preparar o repositório [todos]  
- Preparar ambiente de trabalho Flutter [todos]  
- Preparar o framework de Integração Contínua [André]  
- Inicialização do Banco de Dados [Júlia]  

Histórias de Usuários:  

História: Como usuário, quero me cadastrar na plataforma  
Tarefas:
- Criar formulário de cadastro [André]  
- Incluir usuário no banco de dados [Júlia]  
- Verificar consistência dos dados [André]  
- Criar interface para o cadastro [Luiz]  

História: Como usuário, preciso fazer login
Tarefas:
- Validar usuário e senha [André]
- Criar a interface de interação [Luiz]

História: Como usuário quero cadastrar uma nova receita  
Tarefas:  
- Criar a interface para visualização de menus e receitas [Luiz]  
- Criar interface da página com a receita [Isadora]  
- Processar dados recebidos pelo usuário [André]  
- Incluir receita no banco de dados [Júlia]  
- Separar, para cada receita, datas, ingredientes, tags e tempo de preparo [Isadora]  
- Permitir a edição dos itens cadastrados [André]  
  
História: Como usuário, quero verificar todas as minhas receitas   
Tarefas:    
- Criar a interface que mostra a lista de receitas [Luiz]  
- Implementar diferentes tipos de ordenação das receitas [Isadora]  

História: Como usuário, quero pesquisar minhas receitas de acordo com algum ingrediente, com uma tag específica ou tempo de preparo  
Tarefas:  
- Criar filtro das receitas de acordo com os atributos [Isadora]  
- Coordenar atributos pesquisados com o banco de dados [Júlia]  
- Criar a interface de pesquisa com filtros [Isadora]  

#### Mockup
[Figma](https://www.figma.com/file/HDPIFBw5r1DBj6gyUNw6mN/Despensa?node-id=565%3A22170)  
Para interagir, clique no botão "Play", acima e à direita.
