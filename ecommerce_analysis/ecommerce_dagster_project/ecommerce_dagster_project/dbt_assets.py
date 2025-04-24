import os
from dotenv import load_dotenv
from dagster_dbt import load_assets_from_dbt_project

load_dotenv(dotenv_path=os.path.join(os.path.dirname(__file__), ".env"))

DBT_PROJECT_DIR = os.getenv("DBT_PROJECT_DIR")
DBT_PROFILES_DIR = os.getenv("DBT_PROFILES_DIR")

if not DBT_PROJECT_DIR or not DBT_PROFILES_DIR:
    raise EnvironmentError("Missing DBT_PROJECT_DIR or DBT_PROFILES_DIR in environment variables.")

dbt_asset = load_assets_from_dbt_project(
    project_dir=DBT_PROJECT_DIR,
    profiles_dir=DBT_PROFILES_DIR,
)
