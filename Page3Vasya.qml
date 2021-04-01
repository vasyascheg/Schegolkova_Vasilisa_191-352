import QtQuick 2.0
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick 2.15
import QtQuick.Layouts 1.12
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtQuick.Controls.Material 2.12
import QtMultimedia 5.15



Page {
    id: page3Vasya
    header:Rectangle {
        id: header
        height: 100
        color: "#e6e6fa"

        Image {
            id: logo
            source: "qrc:/logo.jpg"
            width: 100
            height: 100
        }

        Label {
            color: "#778899"
            text: "Lab 1\nElements of the graphical interface"
            anchors.verticalCenter: logo.verticalCenter
            anchors.leftMargin: 120
            anchors.left: parent.left
            font.weight: Font.Medium
            font.pointSize: 15
            font.family: "Helvetica"
        }
    }




    ColumnLayout {
        anchors.fill:parent
        Rectangle
        {
            id: background
            anchors.fill: parent
            color: "#f5f5f5"
        }

        RowLayout{
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            RadioButton {
                id: video
                checked: true
                text: qsTr("Видео")
            }
            RadioButton {
                id: camera
                text: qsTr("Камера")
            }
        }





            RowLayout{

                Rectangle {
                    color: "#f5f5f5"
                    anchors.fill: parent

                    MediaPlayer {
                        id: player
                        source: "qrc:/sample.avi"
                        autoPlay: false
                    }

                    VideoOutput {
                        flushMode : FirstFrame
                        id: videoOutput
                        source: player
                        anchors.fill: parent
                    }
                }
            }

            RowLayout {
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                RoundButton {
                    icon.source: "qrc:/play.svg"
                    onClicked: {
                        if (player.playbackState == MediaPlayer.PlayingState)
                        {
                            icon.source = "qrc:/play.svg"
                            player.pause()
                        }
                        else
                        {
                            icon.source = "qrc:/pause.svg"
                            player.play()
                        }
                    }
                    icon.height: height
                    icon.width: width
                }

            }
        }
    }












