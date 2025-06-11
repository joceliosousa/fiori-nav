# Como Navegar de um APP para o outro com RAP-Fiori Elements

Parece simples, e é para ser simples. Porém, alguns erros classicos afetam na navegação de um app para outro utilizando annotations dentro de uma CDS (RAP-FIORI ELEMENTS).

Por isso, trago aqui algumas dicas e problemas enfrentados, sobre este assunto.

A Navegação Baseada em Intenção é uma técnica do Fiori Launchpad por meio da qual o usuário pode iniciar outros aplicativos dependendo dos parâmetros de tempo de execução. Essa técnica é possível definindo alvos de navegação do aplicativo usando intenções abstratas, que, em tempo de execução, são resolvidas em URLs reais pelo serviço de resolução de alvos do Fiori Launchpad. Essa técnica de navegação contém uma ação, ou seja, relacionada a um objeto semântico. A combinação de objeto semântico e ação de objeto semântico é uma intenção. A anotação @Consumption.semanticObject é usada para navegação baseada em intenção, e o cliente decide como reagir quando essa navegação é acionada.

Antes de iniciar, deixo claro que o primeiro passo é procurar o respectivo APP que você precisará navegar desde o seu APP em [https://fioriappslibrary.hana.ondemand.com/sap/fix/externalViewer/]

## Tipos de Navegação.

Concordando com o link oficial da SAP: https://help.sap.com/docs/abap-cloud/abap-rap/navigation, temos três tipos:
Elas são identificadas pela propriedade type nas annotations lineItem e identification.

## #FOR_INTENT_BASED_NAVIGATION
Usado para navegação baseada em uma ação relacionada a um objeto semântico.

Com este você consegue entre APPs selecionando uma linha e clicando em um botão, ou, ao clicar no item (ex: ordem de venda) ele irá abrir um menu com opções de navegação.

Ex: Selecionar e clicar em um botão:
![image](https://github.com/user-attachments/assets/85de21b4-28ce-4966-9a40-a24a6d35204c)

Abrir um menu de opções:
![image](https://github.com/user-attachments/assets/2944b569-54e6-41db-b94d-15a7f66ab0af)

Obs: não é o foco desta postagem.

## #WITH_URL
Usado para navegação de um aplicativo para um site externo.

![image](https://github.com/user-attachments/assets/63d29e07-ce4d-45b2-846f-a2d232e37d18)

Você pode criar um campo dinâmico (Virtual element) e tornar a url personalizda de acordo com a linha do item:

      @UI.lineItem: [{ position: 40 , type: #WITH_URL , url: 'AirlineURL'} ]
      @UI.identification: [{ position: 40 , type: #WITH_URL , url: 'AirlineURL'}]
      @Semantics.url: { mimeType: 'url' }
      url      as AirlineURL,

![image](https://github.com/user-attachments/assets/c0b08d4c-3462-4a42-bab0-dc9034ef26e9)

## #WITH_NAVIGATION_PATH
Usado para navegação dentro de um aplicativo.

Este é o foco desta postagem. Representa uma ótima forma de navegar entre APPs dentro do Launchpad.

Dentro de um APP, quando utilizada as annotations, é gerada dentro de um específico campo em uma linha um link com outro APP, onde são passados os campos que fazem o link através da URL.

Antes de iniciar, procure o APP que precisa fazer o link a partir do seu. No meu cenário vou procurar APPs para Pedidos de Compras, Material, e outros que é uma transação específica local Brasil, MIGO_GO.

A pesquisa pelo APP standard: PURCHASE, localizamos este app abaixo.
![image](https://github.com/user-attachments/assets/b0f95bbb-019a-479e-9123-deb8a2875e07)

Escolha a versão do ABAP plataform. No nosso caso 2023 PFS02.
![image](https://github.com/user-attachments/assets/dad991bf-a922-48d8-9f8f-a1b654145615)

em IMPLEMENTATION INFORMATION.
Procure as opções de Target Mapping
![image](https://github.com/user-attachments/assets/74a6e7fd-daa4-49c0-87f0-36fc54463cfd)

Procure pelo catálogo:

![image](https://github.com/user-attachments/assets/6fcd322b-9ef8-4b2b-b071-f77aff3eb43a)

No seu LPD config verifique se existe realmente o Target Mapping e o Tile. Digo isto pois quando formos verificar a MIGO_GO, veremos que falta o tile.

![image](https://github.com/user-attachments/assets/b09e7ee9-1417-417d-8d03-1d742f8d8fe3)

![image](https://github.com/user-attachments/assets/87d0fb03-7b6d-4209-9bfa-e477db62cd8d)

```
  @UI.lineItem: [
  { position : 90, importance: #HIGH,
    semanticObject: 'PurchaseOrder' ,
    semanticObjectAction: 'manage',
    type: #WITH_INTENT_BASED_NAVIGATION }
  ]
```

![image](https://github.com/user-attachments/assets/99740103-0b68-4dd2-bcd9-7735cd820425)

![image](https://github.com/user-attachments/assets/85efcd2e-9b1f-417d-ad9e-7b12a701acae)

> [!IMPORTANT]
Cenário: Temos que chamar uma transação específica localização Brasil, ainda não tem APP, apenas Transação.
Para configurar uma transação como a MIGO_GO, deveremos procurar no Fiori APP Library por **MIGO_GO**.
Ao achar Display Material Document / Goods Movement (MIGO_GO) escolhemos a versão do ABAP plataform, iremos em IMPLEMENTATION INFORMATION e depois em Configuration.

![image](https://github.com/user-attachments/assets/ee43cce0-655c-4fe7-83c5-505c56f40fb1)

Encontraremos os seguintes Target Mappings e Catálogos.
![image](https://github.com/user-attachments/assets/e7348b5f-1897-469d-9e98-c815cd22461b)

Pesquisando no meu ambiente, no catálogo: SAP_TC_FIN_CFIN_BE_APPS

![image](https://github.com/user-attachments/assets/dad95cd1-e073-4688-9a1a-8f712cb0bcbe)

Porém, não existe Tile para ele.
Teremos que colocar em um Catálogo customizado. 

Selecione o Target Mapping CFinMaterialMovement e clique em 'Create Reference', neste ponto aponte o catalogo Z, no meu caso Z_MENU e tecle enter.
![image](https://github.com/user-attachments/assets/7d74d274-390b-4b5c-b2b8-328fd8468e16)

O Target Mapping agora está refenciado no catálogo Z.
![image](https://github.com/user-attachments/assets/48d69bf2-4d8d-44fb-bd01-e8395e499b50)

Agora é só criar o Tile.
![image](https://github.com/user-attachments/assets/ed503492-3e50-4f8e-b574-771e3bec281b)

> [!NOTE]
Observe no Target Mapping que existe um DE-PARA dos parametros de entrada, sim, aqueles parametros que usávamos no **CALL TRANSACTION**.
![image](https://github.com/user-attachments/assets/da071b59-4f05-45f7-823c-cc727bee24a2)

Para este cenário eu preciso de dois parametros (campos na projection): MaterialDocument e MaterialDocumentYear.
Assim, temos que apresentar os campos acima com suas respectivas annotations.

```
  @UI.lineItem: [ { position: 110,
                    importance: #HIGH,
                    type: #WITH_INTENT_BASED_NAVIGATION,
                    semanticObject: 'CFinMaterialMovement',
                    semanticObjectAction: 'display'} ]
  @EndUserText.label: 'Recebimento'
  MaterialDocument;
  //Mblnr;

  @UI.lineItem: [ { position: 111, importance: #HIGH } ]
  @EndUserText.label: 'Ano Receb.'
  MaterialDocumentYear;
```

  Assim, quando acessar a **MIGO_GO**, ele já vai entrar no registro escolhido.
  ![image](https://github.com/user-attachments/assets/df10c682-841b-4a00-a090-b88307d76900)

  ![image](https://github.com/user-attachments/assets/1c5b49b8-6010-40a1-af28-67be0150cdc9)

  Se o campo na CDS for diferente, dê um alias para eles para que obedeçam exatamente os parametros de entrada que deverão ser passados via URL para que a navegação vá diretamente para o registro especifico.
  ![image](https://github.com/user-attachments/assets/da9fa82a-d715-45d8-8737-50fdfc524f8e)

> [!IMPORTANT]
Tenha o código completo com todos objetos deste cenário na pasta src, neste repositório.

  Um abraço e até a próxima.








