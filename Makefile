OUTDIR=_book
MODULES=$(sort $(notdir $(wildcard Supports_formations/*)))

.PHONY: all $(MODULES)

all: $(MODULES)

$(MODULES):
	$(MAKE) gitbook -C $(addprefix Supports_formations/,$@) OUTDIR=$(OUTDIR)
