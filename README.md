# IoT-arduino-weather-station-BLE

Esse aplicativo conecta um Arduino que lê dados de sensores * (temperatura e umidade, neste caso) a um aplicativo PHP que armazena as informações em um Banco de Dados e os exibe com uma biblioteca Javascript específica para Visualização de Dados.

O código para o Arduino aqui incluso inicia uma conexão WPAN, e o shellscript é quem coleta os dados através do BLE e alimenta o banco de dados (pode por exemplo agendá-lo na crontab para rodar de 5 em 5 minutos), dessa forma alguns arquivos desnecessários do branch original foram removidos e outros foram alterados no submódulo www, que é um fork do github original https://github.com/alexpais/iot-arduino-weather-station , além de outros dados úteis de minha autoria e neste projeto adicionados.

Dúvidas? Email: contato a t dbenicio.com .


## Começando

Essas instruções farão com que você tenha uma cópia do projeto em execução na sua máquina local para fins de desenvolvimento e teste.



### Pré-requisitos

- Arduino com BLE
- Servidor Web Apache + PHP5
- Servidor de banco de dados MySQL

O aplicativo da Web pode ser executado em uma rede local, com a ajuda da pilha de aplicativos XAMP (no linux) ou do WAMP (no Windows), mas o servidor precisa ser configurado para aceitar IPs locais. 



### 1. Programa Arduino

*  Tutorial do projeto original; https://www.hackster.io/botletics/esp32-ble-android-arduino-ide-awesome-81c67d
*  Placa ESP32 Dev Module

Carregar na IDE as configurações da placa Espessiff ESP32 WROOM32 e bibliotecas do .zip aqui disponibilizados, então realizar o upload para o Arduino.

Ao se conectar o microcontrolador começa a informar os dados em hexadecimal no formato "temperatura,humidade", tornando-se legível após conversão para ASCII - processo realizado pelo shellscript sensor.sh, responsável também por alimentar o banco de dados . Atentar que o Mac Address BLE do Arduino precisa ser ajustado no script.

---

### 2. Preparação da base de dados

Primeiro, crie um banco de dados com o nome que quiser e, em seguida, execute o seguinte script sql:

`` `sql
CREATE TABLE tempLog (
timeStamp TIMESTAMP NOT NULL PRIMARY KEY,
temperatura int (11) NOT NULL,
umidade int (11) NOT NULL
);
`` `
Em seguida, crie um usuário SQL com senha e atributo previleges para o banco de dados recém-criado.

Você precisará substituir as credenciais no arquivo *** includes / connect.php *** com as novas.
`` `php
função Connection () {

$ server = "server";
$ user = "user";
$ pass = "pass";
$ db = "XXX";

...
}
`` `

### 3. Aplicativo da Web PHP

Em seguida, copie os arquivos do aplicativo php (diretório www ) para um local do servidor, levando em consideração o seguinte:

- Coloque o código PHP dentro da raiz do servidor, e será acessível através de:
- ** www.seuwebsite.dominio **


- Ou, você pode criar um subdomínio e colocar o PHP dentro da pasta de código do subdomínio, e será acessível através de:
- ** www.yoursubdomain.yourwebsite.domain **


- Ou, você pode criar uma pasta e colocar o código PHP dentro dela, e será acessível através de:
- ** www.seuwebsite.domínio / nome da pasta **




### Visualização de dados com D3.js

Esta integração de biblioteca javascript irá renderizar as informações como na imagem a seguir.

! [D3_data_viz_double_axis] (https://cloud.githubusercontent.com/assets/4175297/18608876/ee4fdffe-7cec-11e6-9d6e-60c883305128.png)

Eventualmente pode ser necessário executar o comando abaixo no Banco para ajuste de permissionamentos ao uso de Group By :
mysql> SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));



### Atualizações Necessárias para este aplicativo (COMO AJUDAR????)

- Ajuste do permissionamento Group By ao conectar com o banco, como no exemplo abaixo:
$Pdo->exec("SET sql_mode=(SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', ''));");

- Correção do led indicador de conexão no Arduino.



### Atualizações Realizadas para este aplicativo

1.0 - Versão inicial

