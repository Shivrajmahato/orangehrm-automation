*** Settings ***
Library           RequestsLibrary
Resource          ../resources/variables.robot

*** Test Cases ***
Get Auth Token
    Create Session    hrm    ${API_URL}
    ${response}=    POST    hrm    /token    data={"username": "${USERNAME}", "password": "${PASSWORD}"}    headers={"Content-Type": "application/json"}
    ${TOKEN}=    Set Variable    ${response.json()['access_token']}
    Log    Token is: ${TOKEN}

Create User via API
    Create Dictionary    ${headers}    Authorization=Bearer ${TOKEN}    Content-Type=application/json
    Create Dictionary    ${data}    firstName=Shivaraj    lastName=Mahato    email=mahatoshivraj85@gmail.com
    ${response}=    POST    hrm    /users    json=${data}    headers=${headers}
    Should Be Equal As Strings    ${response.status_code}    201

Validate User Exists And Schema
    ${response}=    GET    hrm    /users    headers=${headers}
    ${json}=    Evaluate    ${response.json()}    json
    Should Contain    ${response.text}    Shivaraj
    Dictionary Should Contain Key    ${json[0]}    firstName
    Dictionary Should Contain Key    ${json[0]}    lastName
    Dictionary Should Contain Key    ${json[0]}    email
