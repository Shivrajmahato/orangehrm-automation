*** Variables ***
${BASE_URL}        https://opensource-demo.orangehrmlive.com
${API_URL}         https://reqres.in
${headers}         Create Dictionary    Content-Type=application/json
${auth_payload}    {"username": "admin", "password": "admin123"}
${headers}    Create Dictionary    Content-Type=application/json
${TOKEN}           None



