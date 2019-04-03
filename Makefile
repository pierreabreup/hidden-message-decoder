SHELL := /bin/bash # Use bash syntax

mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir_name := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))

run:
	docker-compose run -e APP_ENVIRONMENT_NAME=production --service-ports --rm app \
	ruby start.rb

test:
	docker-compose run --service-ports --rm app \
	rspec

dev:
	docker-compose run --service-ports --rm app

down:
	docker-compose down

destroy:
	docker-compose down
	docker volume rm ${current_dir_name}_ruby-usrlocal
	docker rmi hidden-message-decoder
