.DEFAULT_GOAL := help

.PHONY: help check

help: ## Show available commands.
	@awk 'BEGIN {FS = ":.*## "} /^[a-zA-Z0-9_.-]+:.*## / {printf "  %-20s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

check: ## Run the public release gate.
	./scripts/validate.sh
