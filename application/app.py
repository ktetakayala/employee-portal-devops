from flask import Flask, jsonify, render_template

app = Flask(__name__)


@app.get("/")
def home():
    employee = {
        "name": "Tetakayala Mohana Venkata Krishna",
        "employee_id": "EMP-1024",
        "department": "Engineering",
        "job_title": "Devops Engineer",
        "leave_balance": 14,
    }

    announcements = [
        {
            "title": "Quarterly Town Hall",
            "description": "The quarterly town hall will be held on Friday at 3:00 PM.",
        },
        {
            "title": "Updated Leave Policy",
            "description": "The updated leave policy is available in the HR resources section.",
        },
    ]

    departments = [
        "Engineering",
        "Human Resources",
        "Finance",
        "Sales",
        "Operations",
    ]

    return render_template(
        "index.html",
        employee=employee,
        announcements=announcements,
        departments=departments,
    )


@app.get("/health")
def health():
    return jsonify(
        status="healthy",
        application="employee-portal",
    ), 200


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)