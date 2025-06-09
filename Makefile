SUBDIRS := adc block-diagram cit dma fs fs/access irq mem mutex os/context os/kernel os/pcb

all: pdfs

$(SUBDIRS):
	$(MAKE) -C $@

pdfs:
	@for d in $(SUBDIRS); do $(MAKE) -C $$d pdfs; done

pngs:
	@for d in $(SUBDIRS); do $(MAKE) -C $$d pngs; done

svgs:
	@for d in $(SUBDIRS); do $(MAKE) -C $$d svgs; done

images:
	@for d in $(SUBDIRS); do $(MAKE) -C $$d images; done

clean:
	@for d in $(SUBDIRS); do $(MAKE) -C $$d clean; done

.PHONY: all pdfs pngs svgs images clean $(SUBDIRS)
