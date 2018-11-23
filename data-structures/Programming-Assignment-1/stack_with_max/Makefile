GTEST_DIR = /googletest

CXX = g++
CPPFLAGS += -I$(GTEST_DIR)/googletest/include
CXXFLAGS += -g -Wall -Wextra -pthread -pipe -O2 -std=c++14

LDFLAGS += -L$(GTEST_DIR)/build/lib
LDLIBS += -lgtest -lgtest_main -lpthread -lm

TARGET = $(join $(notdir $(shell pwd)), _test.out)
SRC = $(wildcard *.cc)
OBJ = $(addsuffix .o, $(basename $(SRC)))

all: $(TARGET)

$(TARGET): $(OBJ)
	$(CXX) $(LDFLAGS) $(OBJ) -o $@ $(LDLIBS)

clean:
	@rm -f $(TARGET) $(OBJ)

lint:
	@cpplint.py $(wildcard *.h) $(SRC)

test: clean all
	@for file in $(sort $(filter-out %.a, $(wildcard tests/*))); do \
		if [ "`cat $$file | ./$(TARGET))`" != "`cat $$file.a`" ]; then \
			echo "$$file: FAIL"; \
		fi; \
	done

.PHONY: clean lint test
