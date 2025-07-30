*** Variables ***
${BASE_URL}     https://opensource-demo.orangehrmlive.com
${API_URL}      http://127.0.0.1:5000
${BROWSER}      chrome
${USERNAME}     Admin
${PASSWORD}     admin123
${auth_payload}     Create Dictionary    username= Admin  password=admin123
${TOKEN}        None