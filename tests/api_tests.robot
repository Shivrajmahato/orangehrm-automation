*** Settings ***
Library           RequestsLibrary
Resource          ../resources/variables.robot

*** Test Cases ***
Get Users List
    Create Session    reqres    ${BASE_URL}
    ${response}=    Get On Session    reqres    /api/users?page=2
    Should Be Equal As Integers    ${response.status_code}    200

Create User via API
    ${user_payload}=    Create Dictionary    name=shivarajapi    job=leader
    ${headers}=    Create Dictionary    Content-Type=application/json
    Create Session    reqres    ${BASE_URL}
    ${create_response}=    Post On Session    reqres    /api/users    json=${user_payload}    headers=${headers}
    Should Be Equal As Integers    ${create_response.status_code}    201

Validate User Exists (Mock)
    Create Session    reqres    ${BASE_URL}
    ${resp}=    Get On Session    reqres    /api/users/2
    Should Be Equal As Integers    ${resp.status_code}    200