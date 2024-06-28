# Solution

## Technical aspects

The presented case is a dockerized version of dbt and a Postgres database. While the initial setup went smooth, I slightly changed the way I work with the case.

First, I only used dockerized version of the Postgres, while dbt I installed in a Python's virtual environment. One inconveniece with the initial version is that every time I restart the containers, it starts over `dbt deps` and `dbt seed` commands. That took time and rpresented no real value since packages and seeds haven't changed since the initial setup.

Second, there were some inconvenieces in using dbt v1.2, which is quite outdated at this point (released in 2022). For example, it requires for profiles.yml to be in `~/.dbt/` folder or provided explicitly with `--profiles-dir` parameter. I work around this inconveniece by copying profiles to the suggested path:
```
mkdir ~/.dbt
cp ./profiles/profiles.yml ~/.dbt/profiles.yml
```
For the sake of the case, I kept using v1.2, but I would insist on update to a newer verion in the real project.

## Modeling approach

For data modeling part I used modeling layers approach. It suggests split all models in (at least) three layers:
- staging
- intermedites
- marts

Staging layer should map source tables and add light transformations. Marts layer contains user-facing tables, that should be used by data analysts or BI tools. Intermediate layer can be used as additional glue between staging and marts, where we may want to have some business logic that is not exposed to end-users.

In our case, staging models map 1:1 tables that we seeded when bootstraping the project. (In real project we would probably not needing this step as seeds can be directly used with `ref()` macro.)

Every **staging** model contains some light transformations. For example, I unified column namings, e.g. `pid` -> `product_id`, and so on. Also, for each staging models I've added a surrogate key and removed duplicated using `ROW_NUMBER()` window finction. Every model initially had duplicates.

Source data was desribed in `/models/staging/sources.yml` file.

Staging models were desribed in `/models/staging/schema.yml` file. Also, I've added tests for duplicates and non-null values for a surrogate key.

In marts layer I mapped all staging models so that they can be used by end-users. Since original names of staging tables were quite technical, I renamed data marts to better explain what the model is responsible for, for example `stg_rugs_usa_parent` -> `products`, `stg_rugs_usa_color_map` -> `product_colors`. This way it should be easier to find needed data.

All marts models have schema desribed in `/models/marts/_marts_schema_.yml` file. Also this file contains tests for primary key (surrogate key from staging) and a short documentation of the model.

Intermediate layer contains one model that is used in two separate data marts. It is needed to avoid of duplication of the same code in both models.

## Insights generation

Looking at the presented tables, the company can generate several insights based off it.

Marketing team may find `product_searches` model useful. That models shows which products were searched and displayed to users. That may give ideas of produts that are in demand, or vise versa, lack attention from the potential customers. Knowing that the team can adjust the marketing strategy to better speak about our product line and come up with a nice offers.

Operations team may find useful `product_variants` and `product_pads` models that contain information about stock availability. That should prevent product shortages and provide a constant supply of all products in demand.

Product team can utilize `products` models to have a high-level understanding of product performance thanks to the additional calculated fields, like  how many times the product was searched `product_searched_times`), availability of each item (`variants_in_stock`, `variants_out_of_stock`, `variants_back_ordered`), and also available colors (`available_colors` column). For extracting additional knowledge about the product, they can reach out to other models, like `product_searches`, `product_variants`, `product_colors`, etc.

All this information should be possible to get in a BI tool, such as Looker or Metabase, besed on the models provided by dbt.

## Final consideration

To make the project even better, we should consider a couple of changes:
- update dbt version, so that newer features are avaiable
- in addition to previous point, it will open ability ot use the latest versions of dbt packages
- further work with team to identify pain-points in existing data models and adjust them accoring to the real business requirements
- work with the team on data quality of the models, for example
    - price column in `product_variants` table is lower than MSRP, that looks suspicious and may be a bug
    - for the same model, `low_stock` column is almost always `false`, even if `stock_level` has low number. that looks suspicios and may be a bug that could lead to incorrect conclusions
