import requests

def test_currency_api_response_ok():
    url = "https://open.er-api.com/v6/latest/BRL"
    response = requests.get(url)
    assert response.status_code == 200
    data = response.json()
    assert data["base_code"] == "BRL"
    assert "USD" in data["rates"]
    assert "VND" in data["rates"]
