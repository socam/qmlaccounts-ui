VERSION = 0.0.1
PROJECT_NAME = qmlaccounts-ui
TEMPLATE = app

QT += declarative
TARGET = $$PROJECT_NAME

CONFIG += link_pkgconfig
PKGCONFIG += \
    accounts-qt \
    QtDeclarative

INCLUDEPATH += $${TOP_SRC_DIR}
DEPENDPATH += $${INCLUDEPATH}

packagesExist(qdeclarative-boostable) {
    message("Building with qdeclarative-boostable support")
    DEFINES += HAS_BOOSTER
    PKGCONFIG += qdeclarative-boostable
} else {
    warning("qdeclarative-boostable not available; startup times will be slower")
}

SOURCES += main.cpp \
    provider-helper.cpp \
    account-provider-model.cpp \
    process-caller.cpp \
    provider-plugin-proxy-singleton.cpp \
    account-model.cpp
RESOURCES += res.qrc

QML_FILES = qml/*.qml
JS_FILES = *qml/.js

OTHER_FILES += $${QML_FILES} $${JS_FILES}

target.path = $$INSTALL_ROOT/usr/bin/
INSTALLS += target

desktop.files = $${PROJECT_NAME}.desktop
desktop.path = $$INSTALL_ROOT/usr/share/applications

#this is just for testing, these files will be automatically created with libaccounts-ui
#when it starts working.
provider-example.files = ../google-example.provider
provider-example.path = /usr/share/accounts/providers
INSTALLS += desktop \
    provider-example


HEADERS += \
    provider-helper.h \
    account-provider-model.h \
    process-caller.h \
    provider-plugin-proxy-singleton.h \
    account-model.h

