
#Nuguri Game - Makefile
#컴파일 방법:
#Windows / MacOS / Linux 공통 → 프로젝트 폴더에서: make
#실행 방법:
#
#
#Windows (PowerShell): .\nuguri.exe
#Windows (CMD):         nuguri.exe
#MacOS / Linux:         ./nuguri
#
#
#make clean   → 빌드 파일(.o, 실행 파일) 삭제
#make print   → 감지된 OS와 적용된 플래그 출력




# OS DETECTION 운영체제 자동 감지
ifeq ($(OS),Windows_NT)
    TARGET_OS = WINDOWS
else
    UNAME_S := $(shell uname -s)
    ifeq ($(UNAME_S),Darwin)
        TARGET_OS = MACOS
    else
        TARGET_OS = LINUX
    endif
endif

#  COMPILER
CC = gcc
CFLAGS = -Wall -Wextra -g

#  OS-specific Flags
ifeq ($(TARGET_OS),WINDOWS)
    OS_FLAG = -D _WIN32
endif

ifeq ($(TARGET_OS),MACOS)
    OS_FLAG = -D __MACH__
endif

ifeq ($(TARGET_OS),LINUX)
    OS_FLAG = -D linux
endif

# SOURCE FILES
SRCS = nuguri.c
OBJS = $(SRCS:.c=.o)

# 최종 실행 파일 이름
TARGET = nuguri

# BUILD RULES
all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) $(OS_FLAG) -o $@ $^

%.o: %.c
	$(CC) $(CFLAGS) $(OS_FLAG) -c $< -o $@

# CLEAN
clean:
	rm -f $(OBJS) $(TARGET)


