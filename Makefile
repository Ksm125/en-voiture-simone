
.PHONY: build_ci
build_ci: ## Builds the docker container service to run the test later
	docker compose build server

.PHONY: test
test: build_ci
	@echo "Running tests"
	docker-compose run --rm -e "RAILS_ENV=test" server sh -c "bundle exec rails db:setup && bundle exec rspec"
	@echo "Tests passed"