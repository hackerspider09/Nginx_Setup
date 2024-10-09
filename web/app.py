from flask import Flask, request, jsonify

app = Flask(__name__)

# Sample data to test GET and POST
data_store = {"message": "Hello, World!"}

# GET method: Fetch data from the server
@app.route('/data', methods=['GET'])
def get_data():
    return jsonify(data_store)

# POST method: Add or update data
@app.route('/data', methods=['POST'])
def post_data():
    new_data = request.json
    data_store.update(new_data)
    return jsonify({"status": "Data updated", "new_data": data_store})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000)
