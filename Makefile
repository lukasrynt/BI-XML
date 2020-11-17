BUILD_DIR := build
SOURCE_DIR := source

.PHONY: czechia
czechia: Czechia.html
Czechia.html: $(SOURCE_DIR)/Czechia.xml $(SOURCE_DIR)/Czechia.xslt
	@mkdir -p $(BUILD_DIR);
	java -jar saxon.jar $^ > $(BUILD_DIR)/$@;


.PHONY: clean
clean:
	@rm -rf $(BUILD_DIR)/* 2> /dev/null; \
	echo "Build cleaned";