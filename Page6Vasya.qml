import QtQuick 2.0
import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Window 2.0
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.15
import QtMultimedia 5.12
import QtGraphicalEffects 1.15
import QtWebView 1.1
import QtQuick.Dialogs 1.0


Page {
    id:page6Vasya

    objectName: "Page_6"

    signal submitToEncrypt(string key, string str)
    signal submitToDecrypt(string key, string str)
    signal showFile(string str, int mode);

    // this function is our QML slot
    function showMessage(text){
        //        messageDialog.text = text
        messageText.text = text
        anchors.centerIn = swipeView
        messageDialog.open()
    }

    Popup {
        id: messageDialog
        width: parent.width * 0.8
        anchors.centerIn: parent
        ColumnLayout {
            anchors.fill: parent
            TextArea {
                id: messageText
                readOnly: true
                Layout.fillWidth: parent
                //                horizontalAlignment: Text.AlignHCenter
                wrapMode: TextEdit.Wrap
            }
            Button {
                Layout.alignment: Qt.AlignHCenter
                text: "Close"
                onClicked: {
                    messageDialog.close()
                }
            }
        }
    }


    ColumnLayout{
        anchors.fill: parent
        anchors.margins: 20
        //        width: parent.width * 0.9

        Label {
            text: "Key:"
        }

        TextField{
            id: keyText
            validator: RegExpValidator { regExp: /.{32}/ }
            // text: "01234567890123456789012345678901"        //TEMP!!!

            onAcceptableInputChanged: {
                background.visible = !acceptableInput;
                btnEncrypt.enabled = acceptableInput;
                btnDecrypt.enabled = acceptableInput;
            }

            leftInset: -10
            rightInset: -10
            implicitWidth: parent.width

            background: Rectangle {
                radius: 3
                border.color: "red"
                border.width: 1.5
            }
        }

        Label {
            text: "File to process:"
        }

        RowLayout {
            TextField{
                id: inFile
                Layout.fillWidth: parent
                text: "ABC"
            }
            Button {
                id: btnFile
                width: height
                text: "..."

                onClicked: {
                    fileDialog.open()
                }

                FileDialog {
                    id: fileDialog
                    title: "Please choose a file"
                    //folder: "file:///C:/TMP/AES256"
                    nameFilters: [ "Text files (*.txt)", "All files (*.*)"]
                    onAccepted: {
                        inFile.text = decodeURIComponent(fileDialog.fileUrl);

                        // Qt.quit()
                    }
                    onRejected: {
                        // Qt.quit()
                    }
                }
            }

        }
        RowLayout {

            Button {
                id: btnEncrypt
                Layout.fillWidth: parent
                text: "Encrypt"
                onClicked:
                {
                    submitToEncrypt(keyText.text, inFile.text)
                }
            }

            Button {
                id: btnDecrypt
                Layout.fillWidth: parent
                text: "Decrypt"
                onClicked:
                {
                    submitToDecrypt(keyText.text, inFile.text)
                }
            }
        }

        RowLayout {

            Button {
                id: btnOpenBoth
                Layout.fillWidth: parent
                text: "Open Plain + Encrypted"
                onClicked:
                {
                    showFile(inFile.text, 0);
                }
            }

            Button {
                id: btnOpenEnc
                Layout.fillWidth: parent
                text: "Open Encrypted"
                onClicked:
                {
                    showFile(inFile.text, 1);
                }
            }

            Button {
                id: btnOpenDec
                Layout.fillWidth: parent
                text: "Open Decrypted"
                onClicked:
                {
                    showFile(inFile.text, 2);
                }
            }
        }
    }
}
