import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Window 2.0
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.15
import QtMultimedia 5.12
import QtGraphicalEffects 1.15
import QtWebView 1.1


Page {
    id: page4Vasya
    width: 600
    height: 400


    Connections  {
        target: httpController
        function onRunPopup(){
            console.log("onRunPopup");
            popup.open();
        }
    }



    Connections  {
        target: httpController
        function onClosePopup(){
            console.log("onClosePopup");
            popup.close();
            if (httpController.getAccessToken() !== ""){
                token_text.text = httpController.getAccessToken();
            }

        }
    }

    Button {
        id:btn
        width: 140
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        contentItem: Item {
            Row {
                spacing: 5
                Text {
                    text: qsTr("Войти через ")
                    color: "white"
                }
                Image {
                    source: "qrc:/images/vk_logo_2.png"
                    width: 20
                    height: 20
                }

            }
        }

        background: Rectangle {
            implicitWidth: 100
            implicitHeight: 30
            color: "#5181b8"
            radius: 10
        }

        onClicked: {
            //wv.url = "https://oauth.vk.com/authorize?client_id=7836005&display=page&redirect_uri=https://oauth.vk.com/blank.html&scope=5&response_type=token&v=5.130&state=123456"
            // httpController.auth()
            console.log("onClicked")
            runAuth();
            // popup.open()
        }


    }

    // область для токена
    GroupBox {
        width: parent.width * 0.9
        anchors.horizontalCenter: parent.horizontalCenter
        //y: 60 //btn.bottom
        anchors.top: btn.bottom
        anchors.bottom: parent.bottom
        title: "Access token"
        anchors.bottomMargin: 30

        Text {
            id: token_text
            anchors.fill: parent
            text: "Пока не получен"
            wrapMode: "WrapAnywhere"


        }
    }








}
