*** Settings ***
Library     RequestsLibrary
Library     JSONLibrary
Resource    ../resources/variables.robot

*** Test Cases ***
Get Auth Token
    Create Session    hrm    ${API_URL}
    ${response}=    POST    hrm/token    data={"username": "${USERNAME}", "password": "${PASSWORD}"}    headers={"Content-Type": "application/json"}
    ${TOKEN}=    Set Variable    ${response.json()['access_token']}
    Log    Token is: ${TOKEN}

Create User via API
    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}    Content-Type=application/json
    ${data}=    Create Dictionary    firstName=Jane    lastName=Doe    email=jane.doe@example.com
    ${response}=    POST    hrm/users    json=${data}    headers=${headers}
    Should Be Equal As Strings    ${response.status_code}    201

Validate User Exists And Schema
    ${response}=    GET    hrm/users    headers=${headers}
    ${json}=    To JSON    ${response.content}
    Should Contain    ${response.text}    Jane
    Dictionary Should Contain Key    ${json[0]}    firstName
    Dictionary Should Contain Key    ${json[0]}    lastName
    Dictionary Should Contain Key    ${json[0]}    email
