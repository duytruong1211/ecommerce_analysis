import os
from sqlalchemy import create_engine, text

def test_currency_exchange_table_exists():
    db_url = os.environ.get("DATABASE_URL")
    engine = create_engine(db_url)
    with engine.connect() as conn:
        result = conn.execute(
            text("SELECT to_regclass('dagster_project.currency_exchange');")
        )
        table_name = result.scalar()
        assert table_name == "dagster_project.currency_exchange"
