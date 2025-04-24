from sqlalchemy import create_engine, text
import os

def test_database_connection():
    db_url = os.environ.get("DATABASE_URL")
    assert db_url is not None, "Missing DATABASE_URL env var"

    engine = create_engine(db_url)
    with engine.connect() as conn:
        result = conn.execute(text("SELECT 1;"))
        assert result.scalar() == 1
