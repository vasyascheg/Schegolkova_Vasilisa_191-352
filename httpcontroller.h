#ifndef HTTPCONTROLLER_H
#define HTTPCONTROLLER_H
#include <QNetworkAccessManager>
#include <QObject>
#include <QJsonArray>
#include <QtWebView/QtWebView>
//#include <QtWebView/private/qquickwebviewloadrequest_p.h>
//#include "C:/Qt/5.15.2/msvc2019_64/include/QtWebView/5.15.2/QtWebView/private/qquickwebviewloadrequest_p.h"

#include <groupsmodel.h> //5 лаба

class HTTPController : public QObject
{
    Q_OBJECT
public: //доступ открыт всем другим классам, кто видит определение данного класса
    explicit HTTPController(QObject *parent = nullptr); //делаем конструктор явным, используя ключевое слово explicit
    //nullptr для описания константы нулевого указателя
    QNetworkAccessManager *nam; //определяю переменную nam-NetworkAccessManager
    //класс позволяет приложению отправлять сетевые запросы и получать ответы

    // void getPageInfo();//определяем функцию getPageInfo

    GroupsModel dataModel; //5 лаба


signals:
    void setTextField(QString text, QString w); // !!
    void runPopup();
    void closePopup();

public slots:
    // void onPageInfo(QNetworkReply *reply); //определяем функцию onPageInfo
    void getPageInfo();//определяем функцию getPageInfo
    bool failed (QString add);
    bool cancel (QString add);

    void auth();
    void onLoadingChanged(QString error, QString url);  //обработчик события LoadingChanged - изменение состояния
                                                        //используется при изменении состояния WebView (main.qml)

    void restRequest(); // 5 лаба API запрос сообществ вк

    QString getAccessToken(){ //4 лаба
        return access_token;
    }

public: // доступ открыт классам, производным от данного
    QObject *view;

    QString access_token;  //4 лаба



};

#endif // HTTPCONTROLLER_H
