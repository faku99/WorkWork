include $(THEOS)/makefiles/common.mk

TARGET = iphone::9.0:9.0

BUNDLE_NAME = WWPrefs
WWPrefs_FILES = WWPRootListController.m
WWPrefs_INSTALL_PATH = /Library/PreferenceBundles
WWPrefs_FRAMEWORKS = UIKit
WWPrefs_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/WWPrefs.plist$(ECHO_END)
