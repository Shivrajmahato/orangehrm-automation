*** Settings ***
Variables    ../resources/variables.robot
Library    RequestsLibrary
Library    Collections

*** Test Cases ***
Create User via API
    [Documentation]    Create a user using reqres mock API
    Create Session    reqres    ${API_URL}
    ${data}=    Create Dictionary    name=Shivaraj    job=QA Automation
    ${response}=    Post Request    reqres    /api/users    json=${data}
    Status Should Be    ${response}    201

Validate User Exists And Schema
    [Documentation]    Validate user exists at /api/users/2 and schema looks fine
    Create Session    reqres    ${API_URL}
    ${response}=    Get Request    reqres    /api/users/2
    Status Should Be    ${response}    200
    ${body}=    To JSON    ${response.content}
    Should Be Equal As Strings    ${body['data']['id']}    2