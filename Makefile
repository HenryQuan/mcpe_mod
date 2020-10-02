TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = SpringBoard
ARCHS = armv7 arm64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = MCPEMod

MCPEMod_FILES = Tweak.xm
MCPEMod_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

SUBPROJECTS += bundles
include $(THEOS_MAKE_PATH)/aggregate.mk

after-install::
	install.exec "killall -9 SpringBoard"
