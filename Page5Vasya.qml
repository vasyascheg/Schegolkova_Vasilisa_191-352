import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Window 2.0
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.15
import QtMultimedia 5.12
import QtGraphicalEffects 1.15
import QtWebView 1.1




Page {
    id:page5Vasya
    width: 600
    height: 400

    objectName: "Page_5"



    ColumnLayout{
        anchors.fill: parent

        RowLayout {
            Layout.alignment: Qt.AlignHCenter

            RadioButton {
                id: rbGrid
                text: "Таблица"
                checked: true
                onCheckedChanged:
                {
                    if (rbGrid.checked)
                    {
                        grid.cellWidth = grid.width/(Math.round(grid.width/300))
                    }
                    else{
                        grid.cellWidth = grid.width
                    }
                }
            }

            RadioButton {
                text: "Список"
            }
        }



        GridView{

            onWidthChanged: {
                if (rbGrid.checked)
                {
                    grid.cellWidth = grid.width/(Math.round(grid.width/300))
                }
                else{
                    grid.cellWidth = grid.width
                }
            }

            clip: true // чтобы не перекрывало кнопки
            id: grid
            cellWidth: width/(Math.round(width/300))
            cellHeight: 60
            Layout.fillWidth: true
            Layout.fillHeight: true
            model: dataModel


            delegate:
                Item {
                id: item
                width: grid.cellWidth
                height: grid.cellHeight

                Rectangle{
                    width: grid.cellWidth - 20
                    height: 50
                    radius: 60

                    color: "lightsteelblue"
                    anchors.centerIn: parent

            Column{
                anchors.fill: parent
                 anchors.leftMargin: 80
                    Text {
                        width: parent.width
                        //anchors.fill: parent
                        wrapMode: Text.Wrap
                        text: g_name
                        //anchors.leftMargin: 80
                    }
//                    Text {
//                        width: parent.width
//                       // anchors.fill: parent
//                        wrapMode: Text.Wrap
//                        text: g_activity
//                        //anchors.leftMargin: 80
//                    }

            }





                    Rectangle{
                        id: rect2
                        color: "pink"
                        width: 50
                        height: 50
                        radius: 25



                        layer.enabled: true
                        layer.effect: OpacityMask {
                            maskSource: Item {
                                width: rect2.width
                                height: rect2.height
                                Rectangle {
                                    anchors.centerIn: parent
                                    width: rect2.adapt ? rect2.width : Math.min(rect2.width, rect2.height)
                                    height: rect2.adapt ? rect2.height : width
                                    radius: 25
                                }
                            }
                        }


                        Image {
                            id: img2
                            source: g_photo
                        }
                    }



                }
            }
        }

    }








}









