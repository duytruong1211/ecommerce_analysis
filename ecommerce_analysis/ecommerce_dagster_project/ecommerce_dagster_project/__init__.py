from dagster import Definitions
from . import dbt_assets, currency_api_assets
from dagster_dbt import dbt_cli_resource

defs = Definitions(
    assets=[
        *dbt_assets.dbt_asset,
        *currency_api_assets.assets,
    ],
    resources={"dbt": dbt_cli_resource},
)
