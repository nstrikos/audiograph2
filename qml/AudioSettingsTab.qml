import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.3

Rectangle {
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
            color: "white"
        }

        SpinBox {
            id: durationSpinbox
            height: 50
            anchors.verticalCenter: label1.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 80
            anchors.right: parent.right
            anchors.rightMargin: 10
            activeFocusOnTab: true
            Accessible.name: qsTr("Duration")
            value: parameters.duration
            from: 1
            to: 100
            onValueChanged: parameters.duration = value
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
            id: minFreqSpinbox
            height: 50
            anchors.verticalCenter: label2.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 80
            anchors.right: parent.right
            anchors.rightMargin: 10
            activeFocusOnTab: true
            Accessible.name: qsTr("Minimum frequency")
            value: parameters.minFreq
            from: 200
            to: 4000
            onValueChanged: parameters.minFreq = value
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
            id: maxFreqSpinbox
            height: 50
            anchors.verticalCenter: label3.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 80
            anchors.right: parent.right
            anchors.rightMargin: 10
            activeFocusOnTab: true
            Accessible.name: qsTr("Maximum frequency")
            value: parameters.maxFreq
            from: 400
            to: 8000
            onValueChanged: parameters.maxFreq = value
        }

        Label {
            id: label4
            text: qsTr("Use notes") + ":"
            anchors.top: label3.bottom
            anchors.topMargin: 50
            anchors.left: parent.left
            width: 80
            height: 25
        }
        FocusScope {
            height: 50
            anchors.verticalCenter: label4.verticalCenter
            anchors.left: label4.right
            anchors.leftMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 10
            property alias color: useNotesCheckBox.color
            activeFocusOnTab: true
            Accessible.name: qsTr("Use notes")
            onActiveFocusChanged: {
                if (activeFocus) {
                    useNotesCheckBox.border.color = "blue"
                    useNotesCheckBox.border.width = 4
                }
                else {
                    useNotesCheckBox.border.color = "gray"
                    useNotesCheckBox.border.width = 1
                }
            }
            Keys.onSpacePressed: useNotesCheckBox.checked = ! useNotesCheckBox.checked
            Keys.onEnterPressed: useNotesCheckBox.checked = ! useNotesCheckBox.checked
            Keys.onReturnPressed: useNotesCheckBox.checked = ! useNotesCheckBox.checked

            Rectangle {
                id: useNotesCheckBox
                anchors.fill: parent
                color: useNotesCheckBox.checked ? "gray" : "light gray"
                property bool checked: parameters.useNotes
                Text {
                    text: useNotesCheckBox.checked ? qsTr("On") : qsTr("Off")
                    anchors.centerIn: parent
                    font.pointSize: 16
                }

                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        useNotesCheckBox.checked = ! useNotesCheckBox.checked
                    }
                }
                onCheckedChanged: {
                    parameters.useNotes = checked
                }
            }
        }
        
        Button {
            id: resetButton
            text: qsTr("Reset")
            anchors.top: label4.bottom
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
                durationSpinbox.value = parameters.duration
                minFreqSpinbox.value = parameters.minFreq
                maxFreqSpinbox.value = parameters.maxFreq
                useNotesCheckBox.checked = parameters.useNotes
            }
        }
    }
}
