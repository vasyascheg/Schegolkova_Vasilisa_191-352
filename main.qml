import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12




ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("Tabs")

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
    }

    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex

        TabButton {
            text: qsTr("Lab 1")
        }
        TabButton {
            text: qsTr("Lab 2")
        }
        TabButton {
            text: qsTr("Lab 3")
        }
    }
}
