*** Settings ***
Library    RequestsLibrary
Library    Collections
Suite Setup    Disable SSL Warnings
Resource   ../resources/variables.robot

*** Keywords ***
Disable SSL Warnings
    Create Session    dummy    https://reqres.in    verify=False


*** Test Cases ***

Get Users List
    Create Session    reqres    ${BASE_URL}
    ${response}=    Get On Session    reqres    url=/api/users?page=2
    Should Be Equal As Integers    ${response.status_code}    200

Create User via API
    Create Session    reqres    ${BASE_URL}
    ${user_payload}=    Create Dictionary    name=shivarajapi    job=leader
    ${resp}=    Post On Session    reqres    /api/users    json=${user_payload}    headers=${headers}
    Should Be Equal As Integers    ${resp.status_code}    201

Validate User Exists (Mock)
    Create Session    reqres    ${BASE_URL}
    ${resp}=    Get On Session    reqres    /api/users/2
    Should Be Equal As Integers    ${resp.status_code}    200

*** Test Cases ***

Get Users List
    Create Session    reqres    ${BASE_URL}
    ${response}=    Get On Session    reqres    url=/api/users?page=2
    Should Be Equal As Integers    ${response.status_code}    200

Create User via API
    Create Session    reqres    ${BASE_URL}
    ${user_payload}=    Create Dictionary    name=shivarajapi    job=leader
    ${resp}=    Post On Session    reqres    /api/users    json=${user_payload}    headers=${headers}
    Should Be Equal As Integers    ${resp.status_code}    201

Validate User Exists (Mock)
    Create Session    reqres    ${BASE_URL}
    ${resp}=    Get On Session    reqres    /api/users/2
    Should Be Equal As Integers    ${resp.status_code}    200