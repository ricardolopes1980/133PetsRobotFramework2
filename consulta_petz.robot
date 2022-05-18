*** Settings ***
Documentation    Consultas no site da Petz

Library  SeleniumLibrary
Library  OperatingSystem
Library  String

Test Teardown   close browser

*** Variables ***
${browser}      Chrome
${url}          https://www.petz.com.br

*** Test Cases ***
#Consulta produto
#    [Tags]    rapido
#    Dado que como cliente acessei o site
#    Quando inseri o texto "Ração" no campo de busca
#    E cliquei no botao da lupa
#    Entao foi exibido o grid e a frase do resultado esperado

Compra produto
    [Tags]    rapido
    Dado que como cliente acessei o site
    E concordo com a Politica de Privacidade
    Quando inseri o texto "Pote" no campo de busca
    E aperto a tecla Enter
    Entao foi exibido o grid e a frase do resultado esperado
    Quando seleciono o produto "Porta Ração Petz Rosa 1kg"
    Então exibe a pagina do produto com o preco de "R$ 59,99"
    Quando mudo a quantidade do produto para "2"
    E clico no botao Adicionar no Carrinho
    Então exibe a pagina do carrinho com o total de "R$ 119,98"


*** Keywords ***
# driver do navegador instalado nas váriaveis de ambiente do sistema

Dado que como cliente acessei o site
    open browser    ${url}    ${browser}

E concordo com a Politica de Privacidade
    click button    id = aceiteLgpd

Quando inseri o texto "${palavra_chave}" no campo de busca
    Set Test variable                   ${palavra_chave}
    input text      name = q            ${palavra_chave}

#E cliquei no botao da lupa
#    click button    class = button-search

E aperto a tecla Enter
    press keys      name = q        ENTER

Entao foi exibido o grid e a frase do resultado esperado
    wait until element is enabled     css = h1.h2Categoria.nomeCategoria
    ${palavra_chave_upper}      convert to upper case                  ${palavra_chave}
    element should contain      css = h1.h2Categoria.nomeCategoria     ${palavra_chave_upper}

Quando seleciono o produto "${produto}"
    set test variable                 ${produto}
    wait until element is enabled     xpath = //a[@data-nomeproduto="${produto}"]    30000ms
    click element                     xpath = //a[@data-nomeproduto="${produto}"]

Então exibe a pagina do produto com o preco de "${preco}"
    wait until element is visible     xpath = //h1
    element should contain            xpath = //h1                  ${produto}
    element should contain            class = current-price-left    ${preco}

Quando mudo a quantidade do produto para "2"
     click button                     xpath = //button[@onclick="changeQuantity('plus')"]

E clico no botao Adicionar no Carrinho
    click button                      id = adicionarAoCarrinho

Então exibe a pagina do carrinho com o total de "${preco_total}"
#    wait until element is visible     xpath = //div[@id="cart-item-147547"]     30000ms
#    element should contain            xpath = //div[@id="cart-item-147547"]     ${produto}
#    wait until element is visible     css = div.cart-item-detail.flex.col.cont-center.align-itstart     30000ms
#    element should contain            css = div.cart-item-detail.flex.col.cont-center.align-itstart     ${produto}
    wait until element is visible     class = tx-blue.money
    element should contain            class = tx-blue.money