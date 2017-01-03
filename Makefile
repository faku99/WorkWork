include $(THEOS)/makefiles/common.mk

export ARCHS = armv7 armv7s arm64

TWEAK_NAME = WorkWork
WorkWork_FILES = WWManager.mm Tweak.xm
WorkWork_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 backboardd"
