from dagster import Definitions, load_assets_from_modules
from dags import my_pipeline

all_assets = load_assets_from_modules([my_pipeline])

defs = Definitions(
    assets=all_assets,
)

