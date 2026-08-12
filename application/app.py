from flask import Flask, jsonify, render_template


app = Flask(__name__)


@app.get("/")
def home():
    """
    Render the DevOps project portfolio page.
    """
    return render_template("index.html")


@app.get("/health")
def health():
    """
    Health endpoint used by Docker and the CI/CD deployment pipeline.
    """
    return jsonify(
        application="employee-portal",
        status="healthy",
    ), 200


if __name__ == "__main__":
    app.run(
        host="0.0.0.0",
        port=5000,
        debug=False,
    )