QT += quick
QT += svg # for svg icons
QT += quick multimedia multimediawidgets
QT += network
CONFIG+=qml_debug
CONFIG += console #temp
#CONFIG+=declarative_debug
QT += core qml quickcontrols2 webview
#CONFIF += console qml_debug

CONFIG += c++11 # настройки компиляции

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \ # раздел файлов исходного кода на С++
        cryptocontroller.cpp \
        groupsmodel.cpp \
        httpcontroller.cpp \
        main.cpp

RESOURCES += qml.qrc # список файлов, включаемых в раздел ресурсов получаемого исполняемого модуля

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
# синтаксис "название платформы:" -последующие команды сборки будут
# работать на обозначенной платформе
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target


#ANDROID_PACKAGE_SOURCE_DIR = $$PWD/




HEADERS += \
    cryptocontroller.h \
    groupsmodel.h \
    httpcontroller.h

DISTFILES += \
    android/AndroidManifest.xml \
    android/build.gradle \
    android/gradle.properties \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew \
    android/gradlew.bat \
    android/res/values/libs.xml

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

#Lab 6



win32 {
INCLUDEPATH += "C:/Qt/Tools/OpenSSL/Win_x64/include"
LIBS += "C:/Qt/Tools/OpenSSL/Win_x64/lib/libcrypto.lib" \
        "C:/Qt/Tools/OpenSSL/Win_x64/lib/libssl.lib"
}
else: android {
        INCLUDEPATH += "C:\Users\Vasilisa\AppData\Local\Android\Sdk\android_openssl\static\include"
       LIBS += "C:\Users\Vasilisa\Documents\Schegolkova_191_352_4sem\Android\Sdk\android_openssl\static\lib\multiabi\libcrypto_armeabi-v7a.a" \
               "C:\Users\Vasilisa\Documents\Schegolkova_191_352_4sem\Android\Sdk\android_openssl\static\lib\multiabi\libssl_armeabi-v7a.a"

}

#ANDROID_EXTRA_LIBS += \
#    <path_to_libs_dir>/libcrypto_1_1.so \
#    <path_to_libs_dir>/libssl_1_1.so
#android {
#    build_var.path = /assets
#    build_var.files = /files_to_copy
#    INSTALLS += build_var
#}
android: include(C:/Users/Vasilisa/AppData/Local/Android/Sdk/android_openssl/openssl.pri)
