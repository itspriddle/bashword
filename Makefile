DIRS=bin share
INSTALL_DIRS=`find $(DIRS) -type d`
INSTALL_FILES=`find $(DIRS) -type f`

PREFIX?=/usr/local

VERSION?=$(error Must specify version, eg: VERSION=v0.0.0)

.PHONY: help
help: ## show this help text
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: test
test: test-shellcheck test-bats ## run full test suite

.PHONY: test-shellcheck
test-shellcheck: ## run shellcheck
	shellcheck -f gcc -s bash bin/bashword test/*.bats test/*.bash

.PHONY: test-bats
test-bats: bats-setup ## run bats tests
	./test/bats/bin/bats test

.PHONY: bats-setup
bats-setup: ## setup bats
	./test/setup

bootstrap: bats-setup ## bootstrap for development/test
	gem install kramdown-man
	./test/setup

share/man/man1/bashword.1: doc/man/bashword.1.md
	kramdown-man doc/man/bashword.1.md > share/man/man1/bashword.1

.PHONY: man
man: share/man/man1/bashword.1 ## generate man file using kramdown-man

.PHONY: install
install: ## install bashword to PREFIX
	for dir in $(INSTALL_DIRS); do mkdir -p $(DESTDIR)$(PREFIX)/$$dir; done
	for file in $(INSTALL_FILES); do cp $$file $(DESTDIR)$(PREFIX)/$$file; done

.PHONY: uninstall
uninstall: ## uninstall bashword from PREFIX
	for file in $(INSTALL_FILES); do rm -f $(DESTDIR)$(PREFIX)/$$file; done

.PHONY: archive
archive: ## create a zip archive of the current version
	mkdir -p pkg
	git archive --prefix=bashword-$(VERSION)/ --output=pkg/bashword-$(VERSION).zip $(VERSION) $(INSTALL_FILES)

.PHONY: release
release: ## create a new tag and push to GitHub
	git tag -m "$(VERSION)" $(VERSION)
	git push --tags
