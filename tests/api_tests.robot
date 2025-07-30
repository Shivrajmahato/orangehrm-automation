*** Settings ***
Library           RequestsLibrary
Resource          ../resources/variables.robot

*** Test Cases ***
Get Auth Token
    Create Session    auth    ${BASE_URL}
    ${response}=    POST On Session    auth    /auth/login    data=${auth_payload}    headers=${headers}
    Should Be Equal As Integers    ${response.status_code}    200
    ${auth_token}=    Set Variable    ${response.json()['token']}

Create User via API
    ${user_payload}=    Create Dictionary    name=shivarajapi    email=shivarajApi@gmail.com
    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}    Content-Type=application/json
    ${create_response}=    POST On Session    ${API_URL}/users    json=${user_payload}    headers=${headers}
    Should Be Equal As Integers    ${create_response.status_code}    201

Validate User Exists And Schema
    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}
    ${resp}=    GET On Session    ${API_URL}/users/1    headers=${headers}
    Should Be Equal As Integers    ${resp.status_code}    200