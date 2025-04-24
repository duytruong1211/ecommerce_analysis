from dagster import asset, Output, MetadataValue
import os
import pandas as pd
import requests
from sqlalchemy import create_engine, text
from dotenv import load_dotenv
from datetime import datetime

load_dotenv()

@asset
def currency_exchange():
    db_url = os.environ.get("DATABASE_URL")
    assert db_url, "Missing DATABASE_URL env variable"

    response = requests.get("https://open.er-api.com/v6/latest/BRL")
    response.raise_for_status()
    data = response.json()

    # Format date
    fetch_date = datetime.strptime(
        data["time_last_update_utc"], "%a, %d %b %Y %H:%M:%S %z"
    ).date()

    # Create DataFrame
    df = pd.DataFrame([{
        "date": fetch_date,
        "base_currency": "BRL",
        "USD": data["rates"].get("USD"),
        "VND": data["rates"].get("VND")
    }])

    # Write to Postgres
    engine = create_engine(db_url)

    # Ensure schema exists
    with engine.connect() as conn:
        conn.execute(text("CREATE SCHEMA IF NOT EXISTS dagster_project"))

    df.to_sql(
        name="currency_exchange",
        con=engine,
        schema="dagster_project",
        if_exists="append",
        index=False
    )

    return Output(
        df,
        metadata={
            "row_count": len(df),
            "date": str(fetch_date),
            "preview": MetadataValue.md(df.head().to_markdown())
        }
    )
assets = [currency_exchange]
