import unittest

from app import app


class EmployeePortalTests(unittest.TestCase):

    def setUp(self):
        """
        Create a Flask test client before every test.
        """
        app.config["TESTING"] = True
        self.client = app.test_client()

    def test_home_page_returns_200(self):
        """
        The portfolio home page should load successfully.
        """
        response = self.client.get("/")

        self.assertEqual(
            response.status_code,
            200,
        )

    def test_home_page_is_html(self):
        """
        The home page should return HTML content.
        """
        response = self.client.get("/")

        self.assertIn(
            "text/html",
            response.content_type,
        )

    def test_home_page_contains_portfolio_content(self):
        """
        The new DevOps portfolio content should exist.
        """
        response = self.client.get("/")

        expected_content = [
            b"Employee Portal",
            b"Automated CI/CD Pipeline",
            b"About the Project",
            b"Cloud Architecture",
            b"Technology Stack",
            b"GitHub Actions",
            b"Amazon ECR",
            b"Terraform",
            b"Docker",
            b"APPLICATION HEALTHY",
        ]

        for content in expected_content:
            with self.subTest(content=content):
                self.assertIn(
                    content,
                    response.data,
                )

    def test_health_endpoint_returns_200(self):
        """
        Health endpoint should return HTTP 200.
        """
        response = self.client.get("/health")

        self.assertEqual(
            response.status_code,
            200,
        )

    def test_health_endpoint_returns_json(self):
        """
        Health endpoint should return JSON.
        """
        response = self.client.get("/health")

        self.assertTrue(
            response.is_json,
        )

    def test_health_endpoint_content(self):
        """
        Health endpoint should report the application as healthy.
        """
        response = self.client.get("/health")

        data = response.get_json()

        self.assertEqual(
            data["application"],
            "employee-portal",
        )

        self.assertEqual(
            data["status"],
            "healthy",
        )

    def test_unknown_route_returns_404(self):
        """
        Unknown URLs should return HTTP 404.
        """
        response = self.client.get(
            "/this-route-does-not-exist"
        )

        self.assertEqual(
            response.status_code,
            404,
        )


if __name__ == "__main__":
    unittest.main()