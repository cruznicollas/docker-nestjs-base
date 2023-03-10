-include .env

all : new setup setup-check check-name destroy confirm-destroy lis-files
.PHONY : all

new: check-name
	@echo "creating new application"
	mv README.md README.md.origin
	nest new $(name) --directory=. --skip-git --package-manager yarn --language TS
	mv README.md.origin README.md

check-name:
ifndef name
	printf $(_ERROR) "name is undefined. use name=[app_name]" ; \
	exit 1 ;
endif

setup:
	@echo "Installing dependencies"
	yarn --skip-integrity-check --network-concurrency 1

setup-check:
	@echo "Installing dependencies and check files"
	yarn install --check-files

# To use the "confirm" target inside another target,
# use the " if $(MAKE) -s confirm ; " syntax.
file-rm = src
file-rm += dist
file-rm += test
file-rm += node_modules
file-rm += .eslintrc.js
file-rm += nest-cli.json
file-rm += package.json
file-rm += .prettierrc
file-rm += tsconfig.build.json
file-rm += yarn.lock
file-rm += tsconfig.json

destroy:
	@if $(MAKE) -s confirm-destroy ; then \
		rm -rf $(file-rm) ; \
	fi

confirm-destroy: list-files
	@if [[ -z "$(CI)" ]]; then \
		REPLY="" ; \
		read -p "⚠ Are you sure? [y/n] > " -r ; \
		if [[ ! $$REPLY =~ ^[Yy]$$ ]]; then \
			printf $(_ERROR) "Stopping" ; \
			exit 1 ; \
		else \
			printf $(_TITLE) "OK excluindo" ; \
			exit 0; \
		fi \
	fi

list-files:
	@printf $(_WARN) "os seguintes arquivos serão excluídos"...
	@for v in $(file-rm) ; do \
		echo $$v | xargs printf $(_LISTFILES); \
	done

_WARN := "\033[33m[%s]\033[0m %s\n"  # Yellow text for "printf"
_TITLE := "\033[32m[%s]\033[0m %s\n" # Green text for "printf"
_ERROR := "\033[31m[%s]\033[0m %s\n" # Red text for "printf"
_LISTFILES := "\033[31m - %s\033[0m %s\n" # Red text for "printf"
