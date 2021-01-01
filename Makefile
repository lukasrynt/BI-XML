BUILD_DIR := build
SOURCE_DIR := source
STYLESHEET_DIR := stylesheets

.PHONY: all
all: pdf html

.PHONY: pdf
pdf: $(BUILD_DIR)/countries.pdf
$(BUILD_DIR)/countries.pdf: $(SOURCE_DIR)/countries.xml $(STYLESHEET_DIR)/countries.xsl
	@mkdir -p $(BUILD_DIR);
	java -jar saxon.jar $^ > $(BUILD_DIR)/countries.fo;
	fop -fo $(BUILD_DIR)/countries.fo -pdf $@;
	@rm $(BUILD_DIR)/countries.fo 2> /dev/null;

.PHONY: html
html: index countries
countries: $(SOURCE_DIR)/countries.xml $(STYLESHEET_DIR)/countries.xslt
	@mkdir -p $(BUILD_DIR);
	xmllint --noout --dtdvalid 'validation/countries.dtd' $<;
	xmllint --noout --relaxng 'validation/countries.rng' $<;
	java -jar saxon.jar $^;

.PHONY: index
index: $(BUILD_DIR)/index.html
$(BUILD_DIR)/index.html: $(SOURCE_DIR)/countries.xml $(STYLESHEET_DIR)/index.xslt
	@mkdir -p $(BUILD_DIR);
	java -jar saxon.jar $^ > $@;

.PHONY: czechia
czechia: $(BUILD_DIR)/czechia.html
$(BUILD_DIR)/czechia.html: $(SOURCE_DIR)/czechia.xml $(STYLESHEET_DIR)/countries.xslt
	@mkdir -p $(BUILD_DIR);
	xmllint --noout --dtdvalid 'validation/countries.dtd' $<;
	xmllint --noout --relaxng 'validation/countries.rng' $<;
	java -jar saxon.jar $^ > $@;

.PHONY: cote
cote: $(BUILD_DIR)/cote.html
$(BUILD_DIR)/cote.html: $(SOURCE_DIR)/cote.xml $(STYLESHEET_DIR)/countries.xslt
	@mkdir -p $(BUILD_DIR);
	xmllint --noout --dtdvalid 'validation/countries.dtd' $<;
	xmllint --noout --relaxng 'validation/countries.rng' $<;
	java -jar saxon.jar $^ > $@;

.PHONY: uk
uk: $(BUILD_DIR)/united.html
$(BUILD_DIR)/united.html: $(SOURCE_DIR)/uk.xml $(STYLESHEET_DIR)/countries.xslt
	@mkdir -p $(BUILD_DIR);
	xmllint --noout --dtdvalid 'validation/countries.dtd' $<
	xmllint --noout --relaxng 'validation/countries.rng' $<;
	java -jar saxon.jar $^ > $@;

.PHONY: spain
spain: $(BUILD_DIR)/spain.html
$(BUILD_DIR)/spain.html: $(SOURCE_DIR)/spain.xml $(STYLESHEET_DIR)/countries.xslt
	@mkdir -p $(BUILD_DIR);
	xmllint --noout --dtdvalid 'validation/countries.dtd' $<
	xmllint --noout --relaxng 'validation/countries.rng' $<
	java -jar saxon.jar $^ > $@;


.PHONY: clean
clean:
	@rm -rf $(BUILD_DIR)/* 2> /dev/null; \
	echo "Build cleaned";


.PHONY: exercise
exercise: Data.html
Data.html: exercises/XSLT1/Data-1.xml exercises/XSLT1/Data-1-Stylesheet.xsl
	java -jar saxon.jar $^ > exercises/XSLT1/$@;