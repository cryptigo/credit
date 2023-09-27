# Compiler and compiler flags
CC := cc
CFLAGS := -Wall -Wextra -pedantic -std=c99

# Directories
SRC_DIR := src
BUILD_DIR := build
BIN_DIR := $(BUILD_DIR)/bin
OBJ_DIR := $(BUILD_DIR)/obj
INSTALL_DIR := /usr/local/bin # Default install directory

# Source and object files
SRC_FILES := $(wildcard $(SRC_DIR)/*.c)
OBJ_FILES := $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(SRC_FILES))

# Executable name
EXECUTABLE := credit

# Phony targets and default goal
.PHONY: all clean install
.DEFAULT_GOAL := all

# Build the executable
all: $(BIN_DIR)/$(EXECUTABLE)

$(BIN_DIR)/$(EXECUTABLE): $(OBJ_FILES) | $(BIN_DIR)
	$(CC) $(CFLAGS) $(OBJ_FILES) -o $@

# Compile source files to object files
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c | $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Create necessary directories
$(BIN_DIR):
	mkdir -p $@

$(OBJ_DIR):
	mkdir -p $@

# Install the executable
install: all 
	install -m 755 $(BIN_DIR)/$(EXECUTABLE) $(INSTALL_DIR)

# Clean build artifacts
clean:
	rm -rf $(BIN_DIR)/* $(OBJ_DIR)/*