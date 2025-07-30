from flask import Flask, request, jsonify

app = Flask(__name__)

# Route: Get Auth Token
@app.route('/api/token', methods=['POST'])
def get_token():
    # Parse JSON input correctly
    data = request.get_json()

    if data.get("username") == "admin" and data.get("password") == "admin123":
        return jsonify(access_token="mocked_jwt_token")
    else:
        return jsonify(error="Unauthorized"), 401

# Route: Create User
@app.route('/api/users', methods=['POST'])
def create_user():
    # Check Authorization header
    auth_header = request.headers.get("Authorization", "")
    if auth_header != "Bearer mocked_jwt_token":
        return jsonify(error="Forbidden"), 403

    user_data = request.get_json()
    # Simulate user creation response
    return jsonify(message="User created", user=user_data), 201

# Route: Get Users List
@app.route('/api/users', methods=['GET'])
def get_users():
    auth_header = request.headers.get("Authorization", "")
    if auth_header != "Bearer mocked_jwt_token":
        return jsonify(error="Forbidden"), 403

    users = [
        {"id": 1, "name": "John Doe", "email": "john@example.com"},
        {"id": 2, "name": "Jane Smith", "email": "jane@example.com"},
    ]
    return jsonify(users=users)

# Run the app
if __name__ == '__main__':
    app.run(debug=True)