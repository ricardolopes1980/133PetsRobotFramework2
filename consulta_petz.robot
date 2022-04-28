*** Settings ***
Documentation    Consultas no site da Petz

Library  SeleniumLibrary
Library  OperatingSystem

Test Teardown   close browser

*** Variables ***
${browser}      Chrome
${url}          https://www.petz.com.br

*** Test Cases ***
Consulta produto
    [Tags]    rapido
    Dado que como cliente acessei o site
    Quando inseri o texto "Ração" no campo de busca
    E cliquei no botao da lupa
    Entao foi exibido o grid e a frase do resultado esperado


*** Keywords ***
# driver do navegador instalado nas váriaveis de ambiente do sistema

Dado que como cliente acessei o site
    open browser    ${url}    ${browser}

Quando inseri o texto "${palavra_chave}" no campo de busca
    Set Test variable                   ${palavra_chave}
    input text      name = q            ${palavra_chave}

E cliquei no botao da lupa
    click button    class = button-search

Entao foi exibido o grid e a frase do resultado esperado
    element should contain      css = h1.h2Categoria nomeCategoria     RESULTADOS PARA "${palavra_chave}"

