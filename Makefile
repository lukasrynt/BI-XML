BUILD_DIR := build
SOURCE_DIR := source
STYLESHEET_DIR := stylesheets
SAXON_EXEC := java -jar saxon.jar
INCLUDED := $(BUILD_DIR)/parsed.xml

.PHONY: all
all: pdf html validate

$(INCLUDED): $(SOURCE_DIR)/countries.xml
	@mkdir -p $(BUILD_DIR);
	xmllint $< --xinclude --output $(INCLUDED)

.PHONY: validate
validate: $(INCLUDED)
	xmllint --noout --dtdvalid 'validation/countries.dtd' $<;
	xmllint --noout --relaxng 'validation/countries.rng' $<;

.PHONY: pdf
pdf: $(BUILD_DIR)/countries.pdf
$(BUILD_DIR)/countries.pdf: $(INCLUDED) $(STYLESHEET_DIR)/countries.xsl
	@mkdir -p $(BUILD_DIR);
	$(SAXON_EXEC) $^ > $(BUILD_DIR)/countries.fo;
	fop -fo $(BUILD_DIR)/countries.fo -pdf $@;
	@rm $(BUILD_DIR)/countries.fo 2> /dev/null;

.PHONY: html
html: index countries
countries: $(INCLUDED) $(STYLESHEET_DIR)/countries.xslt
	@mkdir -p $(BUILD_DIR);
	$(SAXON_EXEC) $^;

.PHONY: index
index: $(BUILD_DIR)/index.html
$(BUILD_DIR)/index.html: $(INCLUDED) $(STYLESHEET_DIR)/index.xslt
	@mkdir -p $(BUILD_DIR);
	$(SAXON_EXEC) $^ > $@;

.PHONY: czechia
czechia: $(BUILD_DIR)/czechia.html
$(BUILD_DIR)/czechia.html: $(SOURCE_DIR)/czechia.xml $(STYLESHEET_DIR)/countries.xslt
	@mkdir -p $(BUILD_DIR);
	xmllint --noout --dtdvalid 'validation/countries.dtd' $<;
	xmllint --noout --relaxng 'validation/countries.rng' $<;
	$(SAXON_EXEC) $^ > $@;

.PHONY: cote
cote: $(BUILD_DIR)/cote.html
$(BUILD_DIR)/cote.html: $(SOURCE_DIR)/cote.xml $(STYLESHEET_DIR)/countries.xslt
	@mkdir -p $(BUILD_DIR);
	xmllint --noout --dtdvalid 'validation/countries.dtd' $<;
	xmllint --noout --relaxng 'validation/countries.rng' $<;
	$(SAXON_EXEC) $^ > $@;

.PHONY: uk
uk: $(BUILD_DIR)/united.html
$(BUILD_DIR)/united.html: $(SOURCE_DIR)/uk.xml $(STYLESHEET_DIR)/countries.xslt
	@mkdir -p $(BUILD_DIR);
	xmllint --noout --dtdvalid 'validation/countries.dtd' $<
	xmllint --noout --relaxng 'validation/countries.rng' $<;
	$(SAXON_EXEC) $^ > $@;

.PHONY: spain
spain: $(BUILD_DIR)/spain.html
$(BUILD_DIR)/spain.html: $(SOURCE_DIR)/spain.xml $(STYLESHEET_DIR)/countries.xslt
	@mkdir -p $(BUILD_DIR);
	xmllint --noout --dtdvalid 'validation/countries.dtd' $<
	xmllint --noout --relaxng 'validation/countries.rng' $<
	$(SAXON_EXEC) $^ > $@;

.PHONY: clean
clean:
	@rm -rf $(BUILD_DIR)/* 2> /dev/null; \
	echo "Build cleaned";

.PHONY: zip
zip:
	zip -r $(BUILD_DIR)/semestral.zip source stylesheets validation Makefile README.md Zadání.md design