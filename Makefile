BUILD_DIR := build
SOURCE_DIR := source

.PHONY: all
all: $(SOURCE_DIR)/countries.xml $(SOURCE_DIR)/countries.xslt
	@mkdir -p $(BUILD_DIR);
	java -jar saxon.jar $^;

.PHONY: czechia
czechia: $(BUILD_DIR)/czechia.html
$(BUILD_DIR)/czechia.html: $(SOURCE_DIR)/czechia.xml $(SOURCE_DIR)/countries.xslt
	@mkdir -p $(BUILD_DIR);
	java -jar saxon.jar $^ > $@;

.PHONY: cote
cote: $(BUILD_DIR)/cote.html
$(BUILD_DIR)/cote.html: $(SOURCE_DIR)/cote.xml $(SOURCE_DIR)/countries.xslt
	@mkdir -p $(BUILD_DIR);
	java -jar saxon.jar $^ > $@;

.PHONY: uk
uk: $(BUILD_DIR)/united.html
$(BUILD_DIR)/united.html: $(SOURCE_DIR)/uk.xml $(SOURCE_DIR)/countries.xslt
	@mkdir -p $(BUILD_DIR);
	java -jar saxon.jar $^ > $@;

.PHONY: spain
spain: $(BUILD_DIR)/spain.html
$(BUILD_DIR)/spain.html: $(SOURCE_DIR)/spain.xml $(SOURCE_DIR)/countries.xslt
	@mkdir -p $(BUILD_DIR);
	java -jar saxon.jar $^ > $@;


.PHONY: clean
clean:
	@rm -rf $(BUILD_DIR)/* 2> /dev/null; \
	echo "Build cleaned";


.PHONY: exercise
exercise: Data.html
Data.html: exercises/XSLT1/Data-1.xml exercises/XSLT1/Data-1-Stylesheet.xsl
	java -jar saxon.jar $^ > exercises/XSLT1/$@;