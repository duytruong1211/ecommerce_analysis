import os
from dotenv import load_dotenv

# Load .env from the dagster project directory (one level up)
load_dotenv(dotenv_path=os.path.join(os.path.dirname(__file__), "../ecommerce_dagster_project/.env"))
