import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Window 2.0
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.15
import QtMultimedia 5.12
import QtGraphicalEffects 1.15


Page {
    id: page3Vasya
    width: 600
    height: 400





    header: ToolBar{ //создание панели
        background: Rectangle { //создание фона
            id:rec3//заполнение панели цветом
            //height: 50
            color: "#d3d3d3" //цвет
        }
        GridLayout{

            id:layout3
            anchors.fill:parent //по ширине родителя
            anchors.margins: 10
            columns:4
            rows: 1

            ToolButton { //создание кнопки с иконкой
                id:buttontwit
                Layout.row:0
                Layout.column:0
                anchors.left:parent.left //привязка слева от родителя

                //icon.source: "qrc:/play.svg" //источник
                Image {
                    source: "qrc:/images/pinterest_svg.svg"
                    width: 32
                    height: 32
                    Layout.row:0
                    Layout.column:0
                }
            }



            Label { //Создание метки с текстом
                id:label3 //задание id
                //text: qsTr("Запросы к серверу по HTTP") //текст
                text: "Лабораторная работа №3"
                color:"#dc143c" //цвет
                font.family: "Franklin Gothic Medium"
                Layout.row:0
                Layout.column:1
                font.weight: Font.Medium
                font.pointSize: 11
            }



        }
    }
    Rectangle {
        id: rectangle122
        color: "white"
        anchors.topMargin: 0
        anchors.fill: parent
    }
    GridLayout {
        anchors.topMargin: 52
        anchors.fill: parent
        columns: 2

        Button {
            id: sent
            Layout.alignment: Qt.AlignCenter
            Layout.columnSpan: 2

            onClicked:
            {
                httprequest();
                //   _send.getPageInfo();
                helloImage.visible = false;
            }


            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                text: qsTr("Отправить")
            }
            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 30
                opacity: enabled ? 1 : 0.3
                color: "pink"
                radius: 10
            }
        }


        ScrollView {
            //ScrollBar.vertical.policy: ScrollBar.AlwaysOn
            Layout.fillHeight: true
            Layout.columnSpan: 2
            Layout.fillWidth: true

            clip:  true

            Connections{
                target: httpController
                function onSetTextField(str, w){
                    textArea.text = str;

                    weather_info.text = w;

                }
            }
            TextArea{
                id: textArea
                //textFormat: Text.RichText //формат текста
                objectName: "textArea"
                readOnly: true//только чтение
                anchors.fill: parent
                // wrapMode:TextEdit.WordWrap
                wrapMode: TextEdit.Wrap
                rightPadding: 10


                background: Rectangle {
                    id: rectangle
                    anchors.fill: parent
                    color: "#fff"
                    Image {
                        id: helloImage
                        anchors.fill: parent
                        width: 100
                        height: 100
                        source: "qrc:/images/weather3.jpg"

                    }
                }
            }
        }

        Label {
            Layout.alignment: Qt.AlignCenter
            //Layout.fillWidth: true
            Layout.columnSpan: 2
            text: "<b>Погода в данный момент<b>"
            color: "#dc143c"
        }
        RowLayout{
            Layout.fillWidth: true
            Layout.columnSpan: 2
            Layout.alignment: Qt.AlignCenter

            TextField {
                id: weather_info

                objectName: "weather_info"
                color: "black"
                horizontalAlignment: Text.AlignHCenter
                readOnly: true
                Layout.alignment: Qt.AlignCenter
                Layout.columnSpan: 2
                Material.accent: Material.Red
            }
        }
    }
}
