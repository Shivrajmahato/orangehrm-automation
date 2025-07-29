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
    Wait Until Page Contains Element    xpath=//h6[text()="Dashboard"]    timeout=20s

Navigate To Add Employee
    Click Element    xpath=//span[text()="PIM"]
    Wait Until Element Is Visible    xpath=//a[text()='Add Employee']    timeout=20s
    Click Element    xpath=//a[text()='Add Employee']
    

Add Employee
    [Arguments]    ${FIRST_NAME}    ${LAST_NAME}
    Wait Until Element Is Visible    xpath=//input[@name='firstName']    timeout=20s
    Input Text    xpath=//input[@name='firstName']    ${FIRST_NAME}
    Input Text    xpath=//input[@name='lastName']    ${LAST_NAME}
    Wait Until Page Does Not Contain Element    xpath=//div[contains(@class,'oxd-form-loader')]    timeout=30s
    Click Button  xpath=//button[@type='submit']

    Capture Page Screenshot

Validate Employee In List
    [Arguments]    ${FIRST_NAME}    ${LAST_NAME}
    Click Element    xpath=//a[text()="Employee List"]
    Wait Until Element Is Visible    xpath=//input[@placeholder="Type for hints..."]    timeout=20s
    Input Text    xpath=//input[@placeholder="Type for hints..."]    ${FIRST_NAME}
    Press Keys    xpath=//input[@placeholder="Type for hints..."]    ENTER

    #  NEW: Wait for table result to appear
    Wait Until Element Is Visible    xpath=//div[@role="table"]//div[contains(text(), "${FIRST_NAME}")]    timeout=20s

    #  Optional: Verify name is on screen
    Page Should Contain    ${FIRST_NAME}
