ARCHS = armv7 arm64
include theos/makefiles/common.mk

BUNDLE_NAME = MCPEMod
MCPEMod_FILES = MCPEMod.mm
MCPEMod_INSTALL_PATH = /Library/PreferenceBundles
MCPEMod_FRAMEWORKS = UIKit
MCPEMod_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/MCPEMod.plist$(ECHO_END)
