import unittest

from app import app


class EmployeePortalTests(unittest.TestCase):
    def setUp(self):
        app.config["TESTING"] = True
        self.client = app.test_client()

    def test_home_page(self):
        response = self.client.get("/")

        self.assertEqual(response.status_code, 200)
        self.assertIn(b"Employee Portal", response.data)
        self.assertIn(b"Company Announcements", response.data)

    def test_health_endpoint(self):
        response = self.client.get("/health")
        data = response.get_json()

        self.assertEqual(response.status_code, 200)
        self.assertEqual(data["status"], "healthy")
        self.assertEqual(data["application"], "employee-portal")


if __name__ == "__main__":
    unittest.main()