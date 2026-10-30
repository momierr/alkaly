# Makefile
.PHONY: help lint format typecheck test test-all check docs build clean

export UV_NO_CONFIG := 1
export PIP_CONFIG_FILE := /dev/null

help:           ## list targets
	@grep -E '^[a-zA-Z_-]+:.*##' $(MAKEFILE_LIST) | awk -F':.*## ' '{printf "  %-10s %s\n", $$1, $$2}'

lint:           ## ruff lint
	uv run ruff check src tests

format:         ## ruff format
	uv run ruff format src tests

typecheck:      ## mypy strict on src
	uv run mypy src

test:           ## fast tests
	uv run pytest -m "not slow and not network"

test-all:       ## all tests
	uv run pytest

check: lint typecheck test   ## everything before pushing

docs:           ## serve docs locally
	uv run mkdocs serve

build:          ## build sdist + wheel
	uv build

clean:          ## remove caches and build artefacts
	rm -rf dist build .pytest_cache .mypy_cache .ruff_cache .coverage htmlcov
