*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary
Library    Collections

*** Keywords ***
Open OrangeHRM
    Open Browser    ${BASE_URL}    ${BROWSER}  options=add_argument("--headless");add_argument("--no-sandbox");add_argument("--disable-gpu");add_argument("--window-size=1920,1080");add_argument("--disable-dev-shm-usage")
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
    Sleep     5s
    

Add Employee
    [Arguments]    ${FIRST_NAME}    ${LAST_NAME}
    Wait Until Element Is Visible    xpath=//input[@name='firstName']    timeout=20s
    Input Text    xpath=//input[@name='firstName']    ${FIRST_NAME}
    Input Text    xpath=//input[@name='lastName']    ${LAST_NAME}
    Wait Until Page Does Not Contain Element    xpath=//div[contains(@class,'oxd-form-loader')]    timeout=30s
    Sleep     5s
    Click Button  xpath=//button[@type='submit']

    Capture Page Screenshot
    Sleep     5s

Validate Employee In List
    [Arguments]    ${FIRST_NAME}    ${LAST_NAME}
    Click Element    xpath=//a[text()="Employee List"]

    Wait Until Element Is Visible    xpath=//input[@placeholder="Type for hints..."]    timeout=20s

    ${FULL_NAME}=    Set Variable    ${FIRST_NAME} ${LAST_NAME}
    Input Text    xpath=//input[@placeholder="Type for hints..."]    ${FULL_NAME}

    Sleep    5s
    #  Click the green Search button instead of pressing ENTER
    Click Button    xpath=//*[@id="app"]/div[1]/div[2]/div[2]/div/div[1]/div[2]/form/div[2]/button[2]
    Sleep    5s
    
    Wait Until Element Is Visible    xpath=//div[@role="rowgroup"]    timeout=20s
    Capture Page Screenshot
   
