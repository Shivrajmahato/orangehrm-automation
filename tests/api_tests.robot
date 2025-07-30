*** Settings ***
Library           RequestsLibrary
Resource          ../resources/variables.robot

*** Test Cases ***
Get Auth Token
    ${response}=    Post Request    ${API_URL}/auth    ${auth_payload}    headers=${auth_headers}
    Should Be Equal As Integers    ${response.status_code}    200
    ${token}=    Set Variable    ${response.json()['token']}
    Set Suite Variable    ${TOKEN}    ${token}

Create User via API
    ${user_payload}=    Create Dictionary    name=John    email=john@example.com
    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}    Content-Type=application/json
    ${create_response}=    Post Request    ${API_URL}/users    json=${user_payload}    headers=${headers}
    Should Be Equal As Integers    ${create_response.status_code}    201

Validate User Exists And Schema
    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}
    ${resp}=    Get Request    ${API_URL}/users/1    headers=${headers}
    Should Be Equal As Integers    ${resp.status_code}    200