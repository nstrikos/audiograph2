QT += quick multimedia texttospeech

CONFIG += c++11

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        audio.cpp \
        audioengine.cpp \
        audionotes.cpp \
        audiopoints.cpp \
        curve.cpp \
        curveinterface.cpp \
        curvemovingpoint.cpp \
        fparser/fparser.cc \
        fparser/fpoptimizer.cc \
        function.cpp \
        generator.cpp \
        generator/genclipper.cpp \
        generator/genfunctioncalculator.cpp \
        generator/genmaxfinder.cpp \
        generator/genminfinder.cpp \
        generator/genmod.cpp \
        generator/genmodvalues.cpp \
        generator/genparameters.cpp \
        generator/genphicalculator.cpp \
        generator/gensum.cpp \
        main.cpp \
        parameters.cpp \
        point.cpp \
        pointsinterest.cpp \
        texttospeech.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
    fparser/extrasrc/fp_identifier_parser.inc \
    fparser/extrasrc/fp_opcode_add.inc

HEADERS += \
    audio.h \
    audioengine.h \
    audionotes.h \
    audiopoints.h \
    constants.h \
    curve.h \
    curveinterface.h \
    curvemovingpoint.h \
    fparser/extrasrc/fpaux.hh \
    fparser/extrasrc/fptypes.hh \
    fparser/fparser.hh \
    fparser/fparser_gmpint.hh \
    fparser/fparser_mpfr.hh \
    fparser/fpconfig.hh \
    function.h \
    generator.h \
    generator/genclipper.h \
    generator/genfunctioncalculator.h \
    generator/genmaxfinder.h \
    generator/genminfinder.h \
    generator/genmod.h \
    generator/genmodvalues.h \
    generator/genparameters.h \
    generator/genphicalculator.h \
    generator/gensum.h \
    parameters.h \
    point.h \
    pointsinterest.h \
    texttospeech.h
