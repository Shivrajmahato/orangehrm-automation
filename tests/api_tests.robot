*** Settings ***
Library           RequestsLibrary
Resource          ../resources/variables.robot

*** Test Cases ***
Get Auth Token
    Create Session    reqres    ${BASE_URL}
    ${response}=    Post On Session    reqres    url=/api/login    headers=${headers}    data=${auth_payload}
    Should Be Equal As Integers    ${response.status_code}    200
    ${auth_token}=    Set Variable    ${response.json()['token']}
    Log    Token: ${auth_token}
    Set Suite Variable    ${TOKEN}    ${auth_token}

Create User via API
    Create Session    reqres    ${BASE_URL}
    ${user_payload}=    Create Dictionary    name=shivarajapi    job=QA
    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}    Content-Type=application/json
    ${create_response}=    Post On Session    reqres    url=/api/users    json=${user_payload}    headers=${headers}
    Should Be Equal As Integers    ${create_response.status_code}    201
    Log    Created user ID: ${create_response.json()['id']}

Validate User Exists And Schema
    Create Session    reqres    ${BASE_URL}
    ${headers}=    Create Dictionary    Authorization=Bearer ${TOKEN}
    ${resp}=    Get On Session    reqres    url=/api/users/2    headers=${headers}
    Should Be Equal As Integers    ${resp.status_code}    200
    Log    User Email: ${resp.json()['data']['email']}