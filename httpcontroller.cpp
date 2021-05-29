#include "httpcontroller.h"
#include <QNetworkRequest> // запрос
#include <QNetworkReply> // ответ
#include <QEventLoop> // (врезка обработки сигнала по месту действия)
// программа прерывается с режима ожидания, когда приходит объект и продолжает работу
#include <QDebug>
#include <QString>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QNetworkAccessManager>
#include <QUrl>
#include <QPushButton>
#include <regex>




HTTPController::HTTPController(QObject *QMLObject) : view(QMLObject)
{
    nam = new QNetworkAccessManager(this);//класс позволяет приложению отправлять сетевые запросы и получать ответы
    //    connect(nam, &QNetworkAccessManager::finished,
    //            this, &HTTPController::onPageInfo); //создание соединения сигнала о завершении запроса со слотом

    QPushButton *btn = view->findChild<QPushButton *>("sent");
    connect(btn, SIGNAL( clicked( bool ) ), SLOT(getPageInfo()) );
}
void HTTPController::getPageInfo()
{
    //    QNetworkRequest request; //создание запроса
    //    request.setUrl(QUrl("https://yandex.ru/pogoda/moscow")); //адрес
    qDebug() << "Вход в getPageInfo()";//ошибки
    //    QEventLoop evntLoop; //предоставляет средства входа в цикл событий и выхода из него
    //    connect(nam, &QNetworkAccessManager::finished, &evntLoop, &QEventLoop::quit);//создание соединения сигнала о выходе из цикла событий
    //    QNetworkReply * reply;
    //    reply = nam->get(request);//получаем возвращаемые данные и записываем их в reply
    //    evntLoop.exec();//завершение цикла

    QNetworkRequest request; //создание запроса
    QEventLoop evntLoop; //предоставляет средства входа в цикл событий и выхода из него
    connect(nam, &QNetworkAccessManager::finished, &evntLoop, &QEventLoop::quit);//создание соединения сигнала о выходе из цикла событий
    request.setUrl(QUrl("https://yandex.ru/pogoda/moscow")); //адрес
    qDebug() << "Перед get";
    QNetworkReply *reply = nam->get(request);//получаем возвращаемые данные
    evntLoop.exec();//завершение цикла
    qDebug() << "Ответ получен";
    QString str = reply->readAll(); // записываем в str наш сайт
    qDebug() << str;


    QString w = "";
    int j = 0;

    if((j = str.indexOf("</span><span class=\"temp__value temp__value_with-unit\">", j)) != -1) // ищем индекс этого тега в тексте
        //<span class="temp__value temp__value_with-unit">+11</span>
    {
        w= str.mid( j + 55, 5);

        j = 0;


        if((j = w.indexOf("<", j)) != -1)
        {
            w = w.mid(0, j) + " ºC";
        }

    }
    emit setTextField(str, w); // задаем параметр "текст" для textArea из qml
    //qDebug() << textArea;


}






bool HTTPController::failed (QString add){

    qDebug() <<  "failed";
    if(add.indexOf("st._hi=") != -1)
    {
        QString pop;
        pop = add.split("st._hi=")[1].split(" ")[0];
        return 1;
    }
    else {
        return 0;
    }
    return 0;
}

bool HTTPController::cancel (QString add){
    qDebug() <<  "failedcancel";
    if(add.indexOf("error=") != -1)
    {
        QString pop;
        pop = add.split("error=")[1].split(" ")[0];

        return 1;
    }
    else {
        return 0;
    }
    return 0;
}

void HTTPController::auth(){ // выполняем аутентификацию
    qDebug() << "auth";
    access_token = "";
    emit runPopup();
}

void HTTPController::onLoadingChanged(QString error, QString url)
{
    qDebug() << "onLoadingChanged";
    if (url.indexOf("https://oauth.vk.com/blank.html#access_token=") == 0){
        access_token = url.mid( 45, 85);
        emit closePopup();
        restRequest();
    }
    if (url.indexOf("error") != -1)
    {

        qDebug() << "Error: " << url;
        emit closePopup();
    }
    qDebug() << url;
    qDebug() << "Access token: " + access_token;
}


void HTTPController::restRequest() //5 лаба
{
    qDebug() << "restRequest";
    QNetworkRequest request; //создание запроса
    QEventLoop evntLoop; //предоставляет средства входа в цикл событий и выхода из него
    connect(nam, &QNetworkAccessManager::finished, &evntLoop, &QEventLoop::quit);//создание соединения сигнала о выходе из цикла событий
    request.setUrl(QUrl("https://api.vk.com/method/groups.get?access_token=" + access_token + "&v=5.130&extended=1&fields=members_count,activity")); //адрес
    QNetworkReply *reply = nam->get(request);//получаем возвращаемые данные
    evntLoop.exec();//завершение цикла
    QString str = reply->readAll(); // записываем в str наш сайт


    QJsonDocument jsonResponse = QJsonDocument::fromJson(str.toUtf8());
    QJsonObject jsonObject = jsonResponse.object();
    jsonObject = jsonObject["response"].toObject();
    QJsonArray jsonArray = jsonObject["items"].toArray();
    qDebug() << jsonArray.size();




    //  Заполнение модели данных

    foreach (const QJsonValue & value, jsonArray) {
        QJsonObject obj = value.toObject();
        qDebug() << obj["name"].toString();
        dataModel.addItem(
                    GroupItem(
                        obj["name"].toString(),
                    obj["photo_50"].toString(),
                obj["activity"].toString()
                )
                );
    }


}


