# Makefile for use with KeywordsTxtGenerator

KEYWORDS_TXT_GENERATOR_DIR = $(PWD)
DOXYGEN := doxygen
DOXYFILE := $(KEYWORDS_TXT_GENERATOR_DIR)/keywords_txt_generator.doxy
XSLTPROC := xsltproc
TRANSFORMATION := $(KEYWORDS_TXT_GENERATOR_DIR)/doxygen2keywords.xsl

keywords.txt: xml/index.xml
	$(XSLTPROC) $(TRANSFORMATION) $< > $@

xml/index.xml:
	$(DOXYGEN) $(DOXYFILE)

%/xml/index.xml:
	(cd $* ; $(DOXYGEN) $(DOXYFILE))

%/keywords.txt: %/xml/index.xml
	$(XSLTPROC) $(TRANSFORMATION) $< > $@

clean:
	rm -rf xml keywords.txt

.PHONY: clean
