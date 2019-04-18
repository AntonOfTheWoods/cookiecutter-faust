Cookiecutter Faust
===================

Features
---------

* For Faust 1.5.4
* Python 3.7
* Docker and docker-compose support
* Useful commands included in Makefile
* project skeleton is defined as a medium/large project according to [faust layout](https://faust.readthedocs.io/en/latest/userguide/application.html#projects-and-directory-layout)
* The `setup.py` has the entrypoint to resolve the [entrypoint problem](https://faust.readthedocs.io/en/latest/userguide/application.html#problem-entrypoint)


Settings
--------

Settings are created based on [local-settings](https://github.com/drgarcia1986/simple-settings) package.

The only settings required if the `KAFKA SERVER` environment variable which by default is `KAFKA_BOOTSTRAP_SERVER`

```python
SIMPLE_SETTINGS = {
    'OVERRIDE_BY_ENV': True,
    'CONFIGURE_LOGGING': True,
    'REQUIRED_SETTINGS': ('KAFKA_BOOTSTRAP_SERVER',),
}

# The following variables can be ovirriden from ENV
KAFKA_BOOTSTRAP_SERVER = "kafka://kafka:9092"
```

The settings also include a basic logging configuration:

```python
LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'formatters': {
        'default': {
            'format': '%(asctime)s %(levelname)s %(name)s %(message)s',
        },
    },
    'handlers': {
        'console': {
            'level': '{{cookiecutter.faust_loglevel}}',
            'class': 'logging.StreamHandler',
            'formatter': 'default',
        },
    },
    'loggers': {
        'your_project_slug': {
            'handlers': ['console'],
            'level': '{{cookiecutter.faust_loglevel}}',
        },
    },
}
```

Docker and Docker Compose
-------------------------

If `use_docker` option is `yes` a `Dockerfile` will be created.
The `Dockerfile` is based on  `python:3.7-slim`. The example is [here]()

If `include_docker_compose` option is `yes` the `docker-compose.yaml` will be created.

The `docker-compose.yaml` includes `zookeepeer`, `kafka` and `schema-registry` based on `confluent-inc`.
For more information you can go to [confluentinc](https://docs.confluent.io/current/installation/docker/docs/index.html) and see the docker compose example [here](https://github.com/confluentinc/cp-docker-images/blob/master/examples/cp-all-in-one/docker-compose.yml#L23-L48)

Useful ENVIRONMENT variables that you may change:

|Variable| description  | default |
|--------|--------------|---------|
| WORKER | Entrypoint in setup.py | Autogenerated by `cookiecutter`|
| WORKER_PORT | Worker port | Autogenerated by `cookiecutter`. |
| KAFKA_BOOSTRAP_SERVER (Variable name autogenerated by `cookiecutter`)| Kafka servers. | `kafka://kafka:9092` |
| KAFKA_BOOSTRAP_SERVER_NAME | Kafka server name| `kafka` |
| KAFKA_BOOSTRAP_SERVER_PORT | Kafka server port | `9092` |
| SCHEMA_REGISTRY_SERVER | Schema registry server name | `schema-registry` |
| SCHEMA_REGISTRY_SERVER_PORT | Schema registry server port | `8081` |
| SCHEMA_REGISTRY_URL | Schema Registry Server url | `http://schema-registry:8081` |


Usage
------

Let's pretend you want to create a Faust project called "super faust".

First, install `Cookiecutter`.

```
pip install "cookiecutter>=1.4.0"
```

Now run it against this repo::

```
cookiecutter https://github.com/marcosschroh/cookiecutter-faust
```

You'll be prompted for some values. Provide them, then a Faust project will be created for you
based on the convention of medium/large project mentioned above


Answer the prompts with your own desired options_. For example:

```
project_name [My Awesome Faust Project]: super faust
project_slug [super_faust]:
description [My Awesome Faust Project!]:
long_description [My Awesome Faust Project!]:
author_name [Marcos Schroh]:
author_email [marcos-schroh@gmail.com]:
version [0.1.0]:
Select open_source_license:
1 - MIT
2 - BSD
3 - GPLv3
4 - Apache Software License 2.0
5 - Not open source
Choose from 1, 2, 3, 4, 5 (1, 2, 3, 4, 5) [1]:
use_pycharm [n]:
use_docker [n]: y
include_docker_compose [n]: y
include_page_view_tutorial [n]: y
worker_port [6066]:
kafka_server_environment_variable [KAFKA_BOOTSTRAP_SERVER]:
Select faust_loglevel:
1 - CRITICAL
2 - ERROR
3 - WARNING
4 - INFO
5 - DEBUG
6 - NOTSET
Choose from 1, 2, 3, 4, 5, 6 (1, 2, 3, 4, 5, 6) [1]: 4
```

Enter the project and take a look around:

```
cd super_faust/
ls

CONTRIBUTORS.txt  Dockerfile  LICENSE  Makefile  README.md  docker-compose.yaml  run.sh  setup.cfg  setup.py  super_faust  wait_for_services.sh
```

Create a git repo and push it there:

```
git init
git add .
git commit -m "first awesome commit"
git remote add origin git@github.com:marcosschroh/super-faust.git
git push -u origin master
```

Now take a look at your repo. Don't forget to carefully look at the generated README. Awesome, right?

Bonus
-----

If you choose `yes` to `include_page_view_tutorial` option
you will have the app `page_views` running from the [tutorial](https://faust.readthedocs.io/en/latest/playbooks/pageviews.html)