ARCHS = armv7 arm64

include theos/makefiles/common.mk

TWEAK_NAME = AwesomeSlider
AwesomeSlider_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 backboardd"
SUBPROJECTS += awesomesliderprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
