.PHONY: default
default: spec

.PHONY: deps
deps: lib

lib: shard.yml
	@echo "*** Installing dependencies…"
	crystal deps
	mkdir -p `dirname $@`
	touch $@
	@echo

.PHONY: clean
clean:
	@echo "*** Cleaning…"
	rm -rf .crystal
	rm -rf tmp
	rm -rf build
	rm -rf .shards
	rm -rf lib
	@echo

.PHONY: ext
ext:
	@echo "*** Building ext…"
	make -C src/ext
	@echo

.PHONY: spec
spec: deps ext
	@echo "*** Testing…"
	crystal spec
	@echo
