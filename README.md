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


### Sprint 2 - Arquitetura

[Link Com Imagens](https://docs.google.com/document/d/e/2PACX-1vTCOhkre6hB3UxyQsAPiNMFKLU76b92liHyofrFvRfFdi15llzJYPcfkRGxLucKMascattOweQ-rpYG/pub)  

#### Domain Driven Design

Procuramos utilizar termos ubíquos para nomear nossas entidades. Por se tratar de um sistema que utiliza conceitos do dia-dia, essa tarefa foi bastante simples.
A figura abaixo mostra nossas Entidades e Objetos de Valor.

Inicialmente temos a entidade Usuário. Cada Usuário tem os objetos de valor Nome, Sobrenome, Email e Senha. O Usuário também possui como atributo uma lista de Receita, que é outra entidade.
Receita possui como objetos de valor: Nome, Tempo, Preparo, Classificação e Imagem. Além disso, também possui uma lista de TAG (que é uma entidade com Nome) e uma lista de Ingrediente (que é uma entidade com Nome e Medida).

As classes de serviço são utilizadas para adicionar e remover Receitas dos Usuários, filtrá-las em sua exibição e registrar Usuário e fazer o login. Ou seja, são aquelas implementadas no backEnd que executam a lógica principal do programa. Na figura abaixo temos um exemplo da função que Filtra as receitas.

O Usuário com seus objetos de valor e a Receita, formam um agregado, afinal, toda receita está associada a um Usuário. Entretanto, Receita pode funcionar como um agregado por si só, com seus objetos de valor e listas de TAG e Ingrediente em futuras atualizações do aplicativo (por exemplo, uma receita pode ser compartilhada em um ambiente para qualquer Usuário).

Usamos o BD SQLite e associamos a cada Entidade um ID (Receita possui o ID do Usuário e TAG e Ingrediente possuem o ID da Receita). O Repositório são as funções que ligam os Serviços fornecidos para as Entidades ao BD, logo, temos arquivos de repositório para cada Entidade, como mostrado no repositório do Usuário na figura abaixo.

### Arquitetura Hexagonal

Na arquitetura hexagonal, assim como em DDD, tentamos separar o máximo possível o Domínio do Sistema de suas tecnologias. As principais tecnologias (camada externa do modelo hexagonal) utilizadas no desenvolvimento do nosso sistema foram Flutter, FastAPI e SQLite. Enquanto isso, a camada interna com adaptadores, portas e classes de domínio, utilizou a linguagem Python3.

A adoção desse tipo de arquitetura é vantajosa para o sistema que está sendo implementado. A separação bem delineada entre domínio e tecnologias faz com que os códigos implementados (tanto backEnd, frontEnd e Banco de Dados) tenham maior independência. A alteração do código de alguma dessas partes, dificilmente vai levar à “quebra” do sistema por completo. Além disso, essa arquitetura deixou nosso sistema mais simples de ser entendido e mais fácil de ter o código do backEnd testado.

Sobre as tecnologias, o Flutter é a API do FrontEnd, que utiliza a linguagem Dart e é especializada na construção de aplicativos mobile. A FastAPI. O SQLite é utilizado como Banco de Dados e o SQLAlchemy é uma biblioteca em Python que facilita a manutenção dos dados em SQLite.

As funções com Adaptadores são a implementação das interfaces, ou seja, ela implementa a comunicação entre portas e tecnologias. Um exemplo é a implementação do repositório do Usuário. A porta de saída para a comunicaćão do usuário com o Banco de Dados faz a requisićão para esse adaptador e ele, por sua vez, comunica com o BD, como mostrado no código abaixo.

Como Portas de Entrada temos a conexão, intermediada pelos adaptadores entre os requisitos solicitados pelas tecnologias (FrontEnd e FastAPI). Fazemos isso por meio de APIs implementadas no BackEnd. Na figura abaixo, podemos ver o começo da função main.py que faz a chamada para estabelecer a conexão com a FastAPI.

As Classes do Domínio estabelecem as principais aplicações do sistema juntamente com a definição das Entidades (de acordo com DDD). A figura abaixo mostra a definição do Usuário no backEnd.

Finalmente, as Portas de Saída fazem a comunicação com os adaptadores do Banco de Dados. Logo, aqui temos os já mencionados arquivos de repositório. Cada Entidade, ou nesse caso, Objetos da Classe do Domínio, possui uma porta relativa.

