from fastapi import FastAPI
from pydantic import BaseModel
from datetime import datetime
from typing import List
import requests
from bs4 import BeautifulSoup

app = FastAPI()

class FuelPriceModel(BaseModel):
    fuel_type: str
    price: float
    timestamp: datetime


def scrape_fuel_prices() -> List[FuelPriceModel]:
    url = "https://www.pvoil.com.vn/truyen-thong/tin-gia-xang-dau"
    try:
        response = requests.get(url)
        response.raise_for_status()  # Kiểm tra xem yêu cầu có thành công không
    except requests.RequestException as e:
        print(f"Error fetching data from {url}: {e}")
        return []

    soup = BeautifulSoup(response.text, 'html.parser')

    prices = []
    try:
        table = soup.find('div', id='cctb-1').find('table')
        rows = table.find('tbody').find_all('tr')

        for row in rows:
            cols = row.find_all('td')
            fuel_type = cols[1].text.strip()
            price = float(cols[2].text.strip().replace('.', '').replace(',', '.'))
            timestamp = datetime.now()
            prices.append(FuelPriceModel(fuel_type=fuel_type, price=price, timestamp=timestamp))

        for price in prices:
            print(f"Fuel Type: {price.fuel_type}, Price: {price.price}, Timestamp: {price.timestamp}")
    except Exception as e:
        print(f"Error parsing HTML: {e}")
        return []

    return prices


@app.get("/")
def read_root():
    return {"Hello everyone": "My name is Chung Hoang. Welcome to Fuel Price Forecast!"}


@app.get("/current-prices", response_model=List[FuelPriceModel])
def get_current_prices():
    prices = scrape_fuel_prices()
    if not prices:
        return {"error": "Could not fetch fuel prices."}
    return prices


# if __name__ == "__main__":
#     import uvicorn
#     uvicorn.run(app, port=8000)
