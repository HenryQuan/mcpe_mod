ARCHS = armv7 arm64
include theos/makefiles/common.mk

TWEAK_NAME = MCPEMod
MCPEMod_FILES = Tweak.xm
MCPEMod_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += mcpemod
include $(THEOS_MAKE_PATH)/aggregate.mk
