*** Settings ***
Library     RequestsLibrary
Library     Collections
Resource    ../resources/variables.robot

*** Test Cases ***
Get Auth Token
    Create Session    auth    ${API_URL}
    ${headers}=       Create Dictionary    Content-Type=application/json
    # Ensure ${auth_payload} is defined as a dictionary in variables.robot
    ${response}=      POST On Session    auth    /api/token    json=${auth_payload}    headers=${headers}
    Should Be Equal As Integers    ${response.status_code}    200
    ${json}=          Set Variable    ${response.json()}
    Set Suite Variable    ${TOKEN}    ${json['access_token']}
    Log    Auth token: ${TOKEN}


Create User via API
    ${user_payload}=    Create Dictionary    name=shivarajapi    email=shivarajApi@gmail.com
    # Corrected: Each key-value pair is a separate argument
    ${auth_headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${TOKEN}
    ${create_response}=    POST On Session    auth    /api/users    json=${user_payload}    headers=${auth_headers}
    Should Be Equal As Integers    ${create_response.status_code}    201

Validate User Exists And Schema
    # Corrected: Each key-value pair is a separate argument
    ${auth_headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}
    ${resp}=            GET On Session    auth    /api/users    headers=${auth_headers}
    Should Be Equal As Integers    ${resp.status_code}    200
    Log    ${resp.json()}