.PHONY: init plan apply destroy check create deps build

init:
	@docker compose run --rm terraform init

plan:
	@docker compose run --rm terraform plan

apply:
	@docker compose run --rm terraform apply -auto-approve

destroy:
	@docker compose run --rm terraform destroy

check:
	@docker compose run --rm terraform fmt -recursive
	@docker compose run --rm terraform fmt -check
	@docker compose run --rm terraform validate
	@docker compose run --rm elixir /bin/bash -c "cd $(FUNC) && mix test"

create:
	@docker compose run --rm elixir mix new $(FUNC)
	@sudo chmod -R a+w infrastructure/functions/$(FUNC)

deps:
	@docker compose run --rm elixir /bin/bash -c "cd $(FUNC) && mix deps.get"

build:
	@docker compose run --rm elixir /bin/bash -c "cd $(FUNC) && mix aws.release"
