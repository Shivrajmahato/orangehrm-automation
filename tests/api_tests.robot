*** Settings ***
Library     RequestsLibrary
Resource    ../resources/variables.robot

*** Test Cases ***
Get Auth Token
    Create Session    auth    ${API_URL}
    ${response}=    POST On Session    auth    /api/token    json=${auth_payload}    headers=${headers}
    Should Be Equal As Integers    ${response.status_code}    200
    ${TOKEN}=    Set Variable    Bearer ${response.json()['access_token']}

Create User via API
    ${user_payload}=    Create Dictionary    name=shivarajapi    email=shivarajApi@gmail.com
    ${auth_headers}=    Create Dictionary    Authorization=${TOKEN}    Content-Type=application/json
    ${create_response}=    POST On Session    auth    /api/users    json=${user_payload}    headers=${auth_headers}
    Should Be Equal As Integers    ${create_response.status_code}    201

Validate User Exists And Schema
    ${auth_headers}=    Create Dictionary    Authorization=${TOKEN}
    ${resp}=    GET On Session    auth    /api/users    headers=${auth_headers}
    Should Be Equal As Integers    ${resp.status_code}    200
    Log    ${resp.json()}