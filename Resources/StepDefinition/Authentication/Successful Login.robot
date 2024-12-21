*** Settings ***
Documentation   This file contains the step definition for the login keyword
Library         ../../Lib/browserOptions.py
Variables       ../../POM/POM_Pages.yaml
Variables       ../../POM/POM_Variables.yaml


*** Keywords ***
Open Browser Page
    [Documentation]  This keyword contains the step definition in opening a browser page
    [Arguments]  ${url}=${googleURL}  ${downloadPath}=/Downloads
    Log To Console  Open the Browser
    Log  ${downloadPath}
    ${options}=  get options  ${downloadPath}
    Open Browser  ${url}  ${Browser}  alias=${windowAlias01}  options=${options}
    Maximize Browser Window
