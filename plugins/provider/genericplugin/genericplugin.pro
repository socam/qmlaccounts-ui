TEMPLATE = app

INSTALL_PREFIX = /usr
PLUGIN_PATH = $$INSTALL_PREFIX/lib/AccountSetup

CONFIG += qt \
          plugin \
          meegotouch \
          link_pkgconfig
QT += xml

PKGCONFIG += accounts-qt
PKGCONFIG += libsignon-qt
PKGCONFIG += AccountPlugin
PKGCONFIG += QtDeclarative

TARGET = genericplugin

HEADERS += \
	genericplugin.h

SOURCES += \
	genericplugin.cpp

plugin.path = $$PLUGIN_PATH 
plugin.files = $${_PRO_FILE_PWD_}/genericplugin

INSTALLS += \
	plugin 
