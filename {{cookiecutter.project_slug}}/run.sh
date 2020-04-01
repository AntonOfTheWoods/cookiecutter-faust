#!/bin/bash
set -x

export SIMPLE_SETTINGS={{cookiecutter.project_slug}}.settings

PYTHONPATH={{cookiecutter.project_slug}} venv/bin/faust -A app worker --web-port={% if cookiecutter.include_docker_compose %}$WORKER_PORT{% else %}{{cookiecutter.worker_port}}{% endif %}
