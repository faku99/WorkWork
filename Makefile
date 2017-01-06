TARGET = iphone::9.0:9.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = WorkWork
WorkWork_FILES = WWTimerManager.mm Tweak.xm
WorkWork_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 backboardd"

SUBPROJECTS += Prefs

include $(THEOS_MAKE_PATH)/aggregate.mk
