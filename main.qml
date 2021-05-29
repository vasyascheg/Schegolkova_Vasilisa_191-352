import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Window 2.0
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.15
import QtMultimedia 5.12
import QtGraphicalEffects 1.15
import QtWebView 1.1




ApplicationWindow {
    id: window

    signal httprequest()
    signal runAuth() //4 лаба

    width: 640
    height: 480
    visible: true
    title: qsTr("Tabs")




    Popup {
        objectName: "Popup"
        anchors.centerIn: parent

        id: popup
        implicitHeight: 350 //page4Vasya.height //* 0.99
        implicitWidth: 750 //page4Vasya.width //* 0.99
        modal: true
        focus: true
        bottomPadding: 0
        topPadding: 0
        leftPadding: 0
        rightPadding: 0

        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
        onOpened: {
            wv.url = "https://oauth.vk.com/authorize?client_id=7836005&display=page&redirect_uri=https://oauth.vk.com/blank.html&scope=5&response_type=token&v=5.130&state=123456"
        }



        ColumnLayout {
            anchors.fill: parent

            WebView {
                id: wv
                objectName: "webview"

                url: "https://oauth.vk.com/authorize?client_id=7836005&display=page&redirect_uri=https://oauth.vk.com/blank.html&scope=5&response_type=token&v=5.130&state=123456"

                implicitHeight: 370
                implicitWidth: 730

                onLoadingChanged: {
                    httpController.onLoadingChanged(loadRequest.errorString, loadRequest.url)

                }
            }


            Button {
                width: 120
                anchors.horizontalCenter: parent.horizontalCenter


                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    text: qsTr("Назад")
                    color: "white"
                }

                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 30
                    color: "#5181b8"
                    radius: 10
                }

                onClicked: {
                    popup.close()
                }


            }
        }
    }





    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        Page1Vasya {
        }

        Page2Vasya {
        }

        Page3Vasya {
        }

        Page4Vasya {
        }

        Page5Vasya {
        }

        Page6Vasya {
        }
    }





    //drawer 6 lab
    Drawer {
        id: drawer
        width: tabButton1.height //0.25 * window.width
        height: window.height
        edge: Qt.LeftEdge


        Item{
            width: drawer.height
            height: drawer.width


            transform: [
                Rotation { origin.x: 0; origin.y: 0; angle: -90} // rotate around the upper left corner counterclockwise
                ,Translate { y: drawer.height; x: 0 } // move to the bottom of the base
            ]

            TabBar {
                id: tabBar
                currentIndex: swipeView.currentIndex
                width: drawer.height
                height: drawer.width

                TabButton {
                    id:tabButton1
                    text: qsTr("Lab 1")
                }
                TabButton {
                    text: qsTr("Lab 2")
                }
                TabButton {
                    text: qsTr("Lab 3")
                }
                TabButton {
                    text: qsTr("Lab 4")
                }
                TabButton {
                    text: qsTr("Lab 5")
                }
                TabButton {
                    text: qsTr("Lab 6")
                }

            }

        }



    }


}

