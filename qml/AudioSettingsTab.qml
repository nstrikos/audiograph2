import QtQuick 2.12
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.3

Tab {
    title: qsTr("Audio settings")
    Flickable {
        anchors.fill: parent
        contentHeight: 500
        clip: true
        Label {
            id: label1
            anchors.top: parent.top
            anchors.topMargin: 50
            anchors.left: parent.left
            width: 80
            height: 25
            text: qsTr("Duration") + ":"
        }

        SpinBox {
            height: 50
            anchors.verticalCenter: label1.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 80
            anchors.right: parent.right
            anchors.rightMargin: 10
            activeFocusOnTab: true
            Accessible.name: qsTr("Duration")
            value: parameters.duration
            minimumValue: 1
            maximumValue: 100
        }
        
        Label {
            id: label2
            text: qsTr("Minimum\nfrequency") + ":"
            anchors.top: label1.bottom
            anchors.left: parent.left
            anchors.topMargin: 50
            width: 80
            height: 25
        }
        SpinBox {
            height: 50
            anchors.verticalCenter: label2.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 80
            anchors.right: parent.right
            anchors.rightMargin: 10
            activeFocusOnTab: true
            Accessible.name: qsTr("Minimum frequency")
            value: parameters.minFreq
            minimumValue: 200
            maximumValue: 4000
        }
        
        Label {
            id: label3
            text: qsTr("Maximum\nfrequency") + ":"
            anchors.top: label2.bottom
            anchors.topMargin: 50
            anchors.left: parent.left
            width: 80
            height: 25
        }
        SpinBox {
            height: 50
            anchors.verticalCenter: label3.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 80
            anchors.right: parent.right
            anchors.rightMargin: 10
            activeFocusOnTab: true
            Accessible.name: qsTr("Maximum frequency")
            value: parameters.maxFreq
            minimumValue: 400
            maximumValue: 8000
        }
        
        Button {
            id: resetButton
            text: qsTr("Reset")
            anchors.top: label3.bottom
            anchors.topMargin: 50
            anchors.left: parent.left
            anchors.leftMargin: 80
            anchors.right: parent.right
            anchors.rightMargin: 10
            width: 80
            height: 50
            Accessible.name: qsTr("Reset audio settings")
            onClicked: {
                parameters.resetAudio()
            }
        }
    }
}
