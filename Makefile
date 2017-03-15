SP=" "
HEADER_START=\x1b[46;30m$(SP)
HEADER_END=$(SP)\x1b[0m

.PHONY: default
default: spec

.PHONY: deps
deps: lib

lib: shard.yml
	@echo "$(HEADER_START)Installing dependencies…$(HEADER_END)"
	crystal deps
	mkdir -p `dirname $@`
	touch $@
	@echo

.PHONY: clean
clean:
	@echo "$(HEADER_START)Cleaning…$(HEADER_END)"
	rm -rf .crystal
	rm -rf tmp
	rm -rf build
	rm -rf .shards
	rm -rf lib
	@echo

.PHONY: spec
spec: deps
	@echo "$(HEADER_START)Testing…$(HEADER_END)"
	crystal spec
	@echo
