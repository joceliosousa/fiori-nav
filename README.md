Como Navegar de um APP para o outro com RAP-Fiori Elements

Parece simples, e é para ser simples. Porém, alguns erros classicos afetam na navegação de um app para outro utilizando annotations dentro de uma CDS (RAP-FIORI ELEMENTS).

Por isso, trago aqui algumas dicas e problemas enfrentados, sobre este assunto.

A Navegação Baseada em Intenção é uma técnica do Fiori Launchpad por meio da qual o usuário pode iniciar outros aplicativos dependendo dos parâmetros de tempo de execução. Essa técnica é possível definindo alvos de navegação do aplicativo usando intenções abstratas, que, em tempo de execução, são resolvidas em URLs reais pelo serviço de resolução de alvos do Fiori Launchpad. Essa técnica de navegação contém uma ação, ou seja, relacionada a um objeto semântico. A combinação de objeto semântico e ação de objeto semântico é uma intenção. A anotação @Consumption.semanticObject é usada para navegação baseada em intenção, e o cliente decide como reagir quando essa navegação é acionada.

Antes de iniciar, deixo claro que o primeiro passo é procurar o respectivo APP que você precisará navegar desde o seu APP em https://fioriappslibrary.hana.ondemand.com/sap/fix/externalViewer/

Tipos de Navegação.

Concordando com o link oficial da SAP: https://help.sap.com/docs/abap-cloud/abap-rap/navigation, temos três tipos:
Todas elas utilizam a annotation Consumption como base.

#FOR_INTENT_BASED_NAVIGATION
Usado para navegação baseada em uma ação relacionada a um objeto semântico.

Com este você consegue entre APPs selecionando uma linha e clicando em um botão, ou, ao clicar no item (ex: produto) ele irá abrir um menu com opções de navegação:

Ex: Selecionar e clicar em um botão:
![image](https://github.com/user-attachments/assets/85de21b4-28ce-4966-9a40-a24a6d35204c)

Abrir um menu de opções:
![image](https://github.com/user-attachments/assets/2944b569-54e6-41db-b94d-15a7f66ab0af)

Obs: não é o foco desta postagem.

#WITH_URL
Used for navigation from an application to an external web site.

![image](https://github.com/user-attachments/assets/63d29e07-ce4d-45b2-846f-a2d232e37d18)

Você pode criar um campo dinâmico (Virtual element) e tornar a url personalizda de acordo com a linha do item:
      @UI.lineItem: [{ position: 40 , type: #WITH_URL , url: 'AirlineURL'} ]
      @UI.identification: [{ position: 40 , type: #WITH_URL , url: 'AirlineURL'}]
      @Semantics.url: { mimeType: 'url' }
      url      as AirlineURL,

![image](https://github.com/user-attachments/assets/c0b08d4c-3462-4a42-bab0-dc9034ef26e9)


