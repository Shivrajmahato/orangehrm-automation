from flask import Flask, request, jsonify

app = Flask(__name__)
users = []

@app.route("/api/token", methods=["POST"])
def get_token():
    data = request.get_json()
    if data["username"] == "Admin" and data["password"] == "admin123":
        return jsonify(access_token="fake-jwt-token")
    return jsonify(message="Invalid credentials"), 401

@app.route("/api/users", methods=["POST"])
def create_user():
    auth = request.headers.get("Authorization")
    if auth != "Bearer fake-jwt-token":
        return jsonify(message="Unauthorized"), 403
    user = request.get_json()
    users.append(user)
    return jsonify(user), 201

@app.route("/api/users", methods=["GET"])
def get_users():
    return jsonify(users), 200

if __name__ == "__main__":
    app.run(port=5000)
