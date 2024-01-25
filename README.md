# Analytics Engineer: Coding Exercise
This is a coding exercise to help us assess candidates looking to join the Analytics Engineering team at Ruggable.

The test is intended to be completed at home, and we expect you to spend no more than 1-4 hours on it. Since this is an unattended test, we would be expecting it to be completed within 48 hours.

If you do not have time to fully complete the exercise or you get stuck, that's fine and not entirely unexpected, just send us as much as you have done.

We look forward to talking through this project with you.

## Project Prerequisites

In order to get this projects up and running you will need to have docker installed

https://docs.docker.com/get-docker/

## Running the project with Docker
This is a containerised project that uses DBT with Postgres instance to build and model data from a rugs usa data.

Navigate to this directory in your terminal and make sure that your current working directory contains the dockerfile and docker_compose files.

You'll first need to build and run the services via Docker (as defined in `docker-compose.yml`):
```bash
$ docker-compose build
$ docker-compose up
```

The commands above will run a Postgres instance and then build the dbt resources and seed the rugs usa data need for the project These containers will remain up and running so that you can:
- Query the Postgres database and the tables created out of dbt models
- Run further dbt commands via dbt CLI

NOTE: the seeding of all the data into the postgres database will take 30-40 minutes


## Building additional or modified data models
Once the containers are up and running, you can still make any modifications in the existing dbt project 
and re-run any command to serve the purpose of the modifications. 

In order to build your data models, you first need to access the container.

Open up an new terminal to be able to enter the running terminals.

To do so, we infer the container id for `dbt` running container:
```bash
docker ps
```

Then enter the running container:
```bash
docker exec -it <container-id> /bin/bash
```

And finally:

```bash
# Install dbt deps (might not required as long as you have no -or empty- `dbt_packages.yml` file)
dbt deps

# Build seeds (all the data gets seeded on the inital build so this is also not required)
dbt seeds --profiles-dir profiles

# Build data models
dbt run --profiles-dir profiles

# Build snapshots
dbt snapshot --profiles-dir profiles

# Run tests
dbt test --profiles-dir profiles
```

Alternatively, you can run everything in just a single command:

```bash
dbt build --profiles-dir profiles
```

## Querying  data models on Postgres
In order to query and verify the seeds, models and snapshots created in the dummy dbt project, simply follow the 
steps below. 

Find the container id of the postgres service:
```commandline
docker ps 
```

Then run 
```commandline
docker exec -it <container-id> /bin/bash
```

We will then use `psql`, a terminal-based interface for PostgreSQL that allows us to query the database:
```commandline
psql -U postgres
```

You can list tables and views as shown below:
```bash
postgres=# \dt
                 List of relations
 Schema |         Name          | Type  |  Owner   
--------+-----------------------+-------+----------
 public | rugs_usa_category_map | table | postgres
 public | rugs_usa_color_map    | table | postgres
 public | rugs_usa_links        | table | postgres
 public | rugs_usa_pads_upsell  | table | postgres
 public | rugs_usa_parent       | table | postgres
 public | rugs_usa_variant      | table | postgres
(6 rows)

```

Now you can query the tables constructed form the seeds, models and snapshots defined in the dbt project:
```sql
SELEC * FROM <table_or_view_name>;
```
## Project Requirements

Utilize the provided dataset to generate insights that can benefit business users in marketing, product, and operations.



