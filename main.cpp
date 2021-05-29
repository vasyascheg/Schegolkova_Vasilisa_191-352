#include <QGuiApplication>
#include <QNetworkReply>
#include <QQmlContext>
#include <QQmlApplicationEngine>
#include <QtWebView/QtWebView>
#include "httpcontroller.h"
#include "cryptocontroller.h"
#include <utility>
#include <iostream>
//#include <QtWebEngine/qtwebengineglobal.h>


#include <QtWidgets/qlistview.h>

#include <QDir>

int main(int argc, char *argv[])
{

   // QtWebView::initialize();

#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);
    //QtWebEngine::initialize();
    QtWebView::initialize();





    HTTPController httpController;
      QQmlApplicationEngine engine;
      const QUrl url(QStringLiteral("qrc:/main.qml"));

       QQmlContext *context = engine.rootContext();//Контексты позволяют предоставлять данные компонентам QML, созданным механизмом QML
      context->setContextProperty("httpController", &httpController);
         //преобразование пути стартовой страницы из char в Qurl
      //подлючение слота, срабатывающего после создания objectCreated
  /* engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
   if (engine.rootObjects().isEmpty())
       return -1;*/
      //подлючение слота, срабатывающего после создания objectCreated


//    httpController.dataModel.addItem(GroupItem("name_1", "photo_1", "activity_1"));
//    httpController.dataModel.addItem(GroupItem("name_2", "photo_2", "activity_2"));

   engine.rootContext()->setContextProperty("dataModel", &(httpController.dataModel)); // 5 лаба
   //устанавливает значения свойства модели данных


   engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
   if (engine.rootObjects().isEmpty())
       return -1;
   QObject * mainwindow=engine.rootObjects().first();


   QObject::connect(mainwindow, SIGNAL(failed(QString)),
   &httpController, SLOT(failed(QString)));


   QObject::connect(mainwindow, SIGNAL(cancel(QString)),
   &httpController, SLOT(cancel(QString)));



   QObject* main = engine.rootObjects()[0];
    HTTPController sendtoqml(main);
   engine.rootContext()->setContextProperty("_send", &sendtoqml);




   QObject::connect(mainwindow, SIGNAL(httprequest()),
                        &httpController, SLOT(getPageInfo()));

   QObject::connect(mainwindow, SIGNAL(runAuth()),
                        &httpController, SLOT(auth()));


   //6 лаба
   CryptoController cryptoController(0);

   QObject *obj6 = engine.rootObjects().value(0)->findChild<QObject *>("Page_6");

   //Encrypt
   QObject::connect(obj6, SIGNAL(submitToEncrypt(QString, QString)),
                    &cryptoController, SLOT(encryptFile(QString, QString)));

   QObject::connect(&cryptoController, SIGNAL(showMessage(QVariant)),
                    obj6, SLOT(showMessage(QVariant)));


   //Decrypt
   QObject::connect(obj6, SIGNAL(submitToDecrypt(QString, QString)),
                    &cryptoController, SLOT(decryptFile(QString, QString)));

   QObject::connect(&cryptoController, SIGNAL(showMessage(QVariant)),
                    obj6, SLOT(showMessage(QVariant)));

   //Show File
   QObject::connect(obj6, SIGNAL(showFile(QString, int)),
                    &cryptoController, SLOT(showFile(QString, int)));
   //6 лаба

    qDebug() << "QCoreApplication::applicationDirPath() = " << QCoreApplication::applicationDirPath();
    qDebug() << "QDir::currentPath() = " << QDir::currentPath();
#ifdef ANDROID
    //m_currentDir = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
    qDebug() << "QStandardPaths::writableLocation() = " + QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
#elif IOS_PLATFORM
    m_currentDir = QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation);
#else
    qDebug() << "QDir::currentPath() = " + QDir::currentPath();
#endif

    return app.exec();
}
