.PHONY: default
default: spec

.PHONY: ext
ext:
	@echo "*** Building ext…"
	make -C src/ext
	@echo

.PHONY: doc
doc:
	@echo "*** Building documentation…"
	crystal docs
	mv doc docs
	@echo

.PHONY: spec
spec: ext
	@echo "*** Testing…"
	crystal spec
	@echo
