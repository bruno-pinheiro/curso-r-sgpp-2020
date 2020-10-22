# Curso de análise de dados governamentais com o R

Bem vindes!

Este é o repositório do Curso de análise de dados governamentais com o R da
Semanana de Gestão de Políticas Públicas da USP.

Para usar e brincar o material, experimentar o conteúdo e aprofundar os
aprendizados você precisará baixar este repositório e realizar algumas
configurações.

Siga os passos abaixo para realizar essas tarefas. Nesse processo pode ser
que você tenha que instalar alguns programas na sua máquina, que são
dependências para o funcionamento dos pacotes que usaremos no decorrer do
curso. Isto dependerá da configuração da atual da sua máquina e do seu
sistema operacional (Windows, Linux, Mac OS...) e não faz parte do escopo do
curso. Caso durante a configuração ocorra alguma falha, leia com calma a
mensagem de erro, copie-a e busque no Google. Você provavelmente encontrará
a solução de alguém que já passou pelo mesmo problema.

__Obs:__ Este roteiro assume que você já tem o R o RStudio instalado em seu
computador. Se não, siga os passos no tutorial do pessoal da Curso R indicado
abaixo antes de prosseguir:

* [Como instalar o R e o RStudio](http://material.curso-r.com/instalacao/)

## Passo 1: Baixar o repositório

A primeira coisa é baixar o repositório. Após isso você terá toda a estrutura
e arquivos desse projeto disponível para usar na sua máquina.

Para isso:

- Clique no botão Code e então baixe o zip file do projeto

Ou então, se você é usuário Github e tem experiência com Git, pode usar algum
cliente ou ir direto na linha de comando e digitar:

```
git clone https://github.com/bruno-pinheiro/curso-r-sgpp-2020.git
```

Se você usou as opções cliente ou linha de comando, pode ir diretamente para o
passo 3, mas se baixou o arquivo .zip, siga o passo 2.

## 2. Descompacte os arquivos

Após baixar o arquivo, ele estará compactado em formato .zip e será preciso
descompact-alo.

Para isso:

- Mova o arquivo .zip baixado para uma pasta apropriada no seu computador

- Use algum programa de descompactação e faça o unzip do arquivo que você acabou de baixar.


## 3. Abra o projeto

- Abra a pasta descompactada, que se chamará `curso-r-sgpp-2020`

- Clique no arquivo `curso-r-sgpp-2020.Rproj`

Após isso, o projeto será aberto no RStudio.

## 4. Configurações

Após abrir o projeto você precisa primeiro ter certeza de quem tem os pacotes necessários para o curso.

Os scripts de configuração estão presentes no diretório `/setup` do projeto.

a) Instalar os pacontes

Copie o código abaixo, cole ele no console do RStudio e aperte Enter.

```R
source("setup/install.R")
```
Esse script instalará os pacotes necessários. Lembrando que pode ser necessária alguma
configuração adicional no sistema operacional (fora do nosso escopo).

b) Baixe os dados

Novamente copie o código abaixo, cole ele no console do RStudio e aperte Enter.

```R
source("setup/get_data.R")
```

Esse script executará o scripts .R presentes na pasta `/dados` do projeto.

## 5. Aproveite, explore e brinque com os materiais

Após isso você já pode ir para os diretórios das atividades `/dia1` ... `/dia4`, onde
estão os materiais que usamos em cada dia do curso.

Especialmente, tente reproduzir, modificar e explorar os cases.

## 6. Faça os desafios

O diretório `/desafios` contem notebooks com algumas sugestões de atividades para te
ajudar nos estudos e experimentação do R

Bons estudos!

_Made with <3 on RStudio_