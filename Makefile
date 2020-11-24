BUILD_DIR := build
SOURCE_DIR := source

.PHONY: all
all: index.html
index.html: $(SOURCE_DIR)/countries.xml $(SOURCE_DIR)/countries.xslt
	@mkdir -p $(BUILD_DIR);
	java -jar saxon.jar $^ > $(BUILD_DIR)/$@;

.PHONY: czechia
czechia: $(SOURCE_DIR)/Czechia.xml $(SOURCE_DIR)/countries.xslt
	@mkdir -p $(BUILD_DIR);
	java -jar saxon.jar $^;

.PHONY: cote
cote: $(SOURCE_DIR)/countries.xml $(SOURCE_DIR)/countries.xslt
	@mkdir -p $(BUILD_DIR);
	java -jar saxon.jar $^;


.PHONY: clean
clean:
	@rm -rf $(BUILD_DIR)/* 2> /dev/null; \
	echo "Build cleaned";


.PHONY: exercise
exercise: Data.html
Data.html: exercises/XSLT1/Data-1.xml exercises/XSLT1/Data-1-Stylesheet.xsl
	java -jar saxon.jar $^ > exercises/XSLT1/$@;