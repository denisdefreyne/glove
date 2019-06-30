.PHONY: default
default: spec

.PHONY: doc
doc:
	@echo "*** Building documentation…"
	crystal docs
	mv doc docs
	@echo

.PHONY: spec
spec:
	@echo "*** Testing…"
	crystal spec
	@echo
