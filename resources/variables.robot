*** Variables ***
${BASE_URL}       https://opensource-demo.orangehrmlive.com
${BROWSER}        chrome
${USERNAME}       Admin
${PASSWORD}       admin123
${API_URL}    http://127.0.0.1:5000
${auth_payload}    {"username": "admin", "password": "admin123"}
${TOKEN}          None
${headers}    Create Dictionary    Content-Type=application/json
