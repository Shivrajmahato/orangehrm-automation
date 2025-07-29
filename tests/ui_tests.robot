*** Settings ***
Resource    ../resources/keywords.robot
Resource    ../resources/variables.robot
Test Setup    Open OrangeHRM
Test Teardown    Close Browser

*** Test Cases ***
Add And Validate New Employee
    Login To OrangeHRM
    Navigate To Add Employee
    Add Employee    John    Doe
    Validate Employee In List
