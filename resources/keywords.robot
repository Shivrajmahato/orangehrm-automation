*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary
Library    Collections

*** Keywords ***
Open OrangeHRM
    Open Browser    ${BASE_URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Page Contains Element    name=username

Login To OrangeHRM
    Input Text    name=username    ${USERNAME}
    Input Text    name=password    ${PASSWORD}
    Click Button    xpath=//button[@type="submit"]
    Wait Until Page Contains Element    xpath=//h6[text()="Dashboard"]

Navigate To Add Employee
    Click Element    xpath=//span[text()="PIM"]
    Wait Until Element Is Visible    xpath=//a[text()='Add Employee']    timeout=10s
    Click Element    xpath=//a[text()='Add Employee']
    

Add Employee
    [Arguments]    ${first_name}    ${last_name}
    Input Text    name=firstName    ${first_name}
    Input Text    name=lastName     ${last_name}
    Click Button    xpath=//*[@id="app"]/div[1]/div[2]/div[2]/div/div/form/div[2]/button[2]
    Capture Page Screenshot

Validate Employee In List
    Click Element    xpath=//a[text()="Employee List"]
    Input Text    xpath=//input[@placeholder="Type for hints..."]    ${first_name}
    Press Keys    xpath=//input[@placeholder="Type for hints..."]    ENTER
    Wait Until Page Contains    ${first_name}
