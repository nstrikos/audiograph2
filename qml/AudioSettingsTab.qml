import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.3

Rectangle {
    color: "black"
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
            color: "white"
            text: qsTr("Duration") + ":"
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
            from: 10
            to: 100
            onValueChanged: parameters.duration = value

            editable: true

            contentItem: TextInput {
                z: 2
                text: durationSpinbox.textFromValue(durationSpinbox.value, durationSpinbox.locale)

                font: durationSpinbox.font
                color: "white"//"#21be2b"
                selectionColor: "#21be2b"
                selectedTextColor: "#ffffff"
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter

                readOnly: !durationSpinbox.editable
                validator: durationSpinbox.validator
                inputMethodHints: Qt.ImhFormattedNumbersOnly
            }

            up.indicator: Rectangle {
                x: durationSpinbox.mirrored ? 0 : parent.width - width
                height: parent.height
                implicitWidth: 40
                implicitHeight: 40
                color: "black"//durationSpinbox.up.pressed ? "#e4e4e4" : "#f6f6f6"
                border.color: durationSpinbox.activeFocus ? "blue" : "white"

                Text {
                    text: "+"
                    font.pixelSize: durationSpinbox.font.pixelSize * 2
                    color: "white"//"#21be2b"
                    anchors.fill: parent
                    fontSizeMode: Text.Fit
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }

            down.indicator: Rectangle {
                x: durationSpinbox.mirrored ? parent.width - width : 0
                height: parent.height
                implicitWidth: 40
                implicitHeight: 40
                color: "black"//durationSpinbox.down.pressed ? "#e4e4e4" : "#f6f6f6"
                border.color: durationSpinbox.activeFocus ? "blue" : "white"


                Text {
                    text: "-"
                    font.pixelSize: durationSpinbox.font.pixelSize * 2
                    color: "white"//"#21be2b"
                    anchors.fill: parent
                    fontSizeMode: Text.Fit
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }

            background: Rectangle {
                implicitWidth: 140
                color: "black"
                border.color: durationSpinbox.activeFocus ? "blue" : "white"
                border.width: 2
            }

        }
        
        Label {
            id: label2
            text: qsTr("Minimum\nfrequency") + ":"
            anchors.top: label1.bottom
            anchors.left: parent.left
            anchors.topMargin: 50
            width: 80
            height: 25
            color: "white"
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
            stepSize: 100
            onValueChanged: parameters.minFreq = value

            editable: true

            contentItem: TextInput {
                z: 2
                text: minFreqSpinbox.textFromValue(minFreqSpinbox.value, minFreqSpinbox.locale)

                font: minFreqSpinbox.font
                color: "white"//"#21be2b"
                selectionColor: "#21be2b"
                selectedTextColor: "#ffffff"
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter

                readOnly: !minFreqSpinbox.editable
                validator: minFreqSpinbox.validator
                inputMethodHints: Qt.ImhFormattedNumbersOnly
            }

            up.indicator: Rectangle {
                x: minFreqSpinbox.mirrored ? 0 : parent.width - width
                height: parent.height
                implicitWidth: 40
                implicitHeight: 40
                color: "black"//durationSpinbox.up.pressed ? "#e4e4e4" : "#f6f6f6"
                border.color: minFreqSpinbox.activeFocus ? "blue" : "white"

                Text {
                    text: "+"
                    font.pixelSize: minFreqSpinbox.font.pixelSize * 2
                    color: "white"//"#21be2b"
                    anchors.fill: parent
                    fontSizeMode: Text.Fit
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }

            down.indicator: Rectangle {
                x: minFreqSpinbox.mirrored ? parent.width - width : 0
                height: parent.height
                implicitWidth: 40
                implicitHeight: 40
                color: "black"//durationSpinbox.down.pressed ? "#e4e4e4" : "#f6f6f6"
                border.color: minFreqSpinbox.activeFocus ? "blue" : "white"


                Text {
                    text: "-"
                    font.pixelSize: minFreqSpinbox.font.pixelSize * 2
                    color: "white"//"#21be2b"
                    anchors.fill: parent
                    fontSizeMode: Text.Fit
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }

            background: Rectangle {
                implicitWidth: 140
                color: "black"
                border.color: minFreqSpinbox.activeFocus ? "blue" : "white"
                border.width: 2
            }
        }
        
        Label {
            id: label3
            text: qsTr("Maximum\nfrequency") + ":"
            anchors.top: label2.bottom
            anchors.topMargin: 50
            anchors.left: parent.left
            width: 80
            height: 25
            color: "white"
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
            stepSize: 100
            onValueChanged: parameters.maxFreq = value

            editable: true

            contentItem: TextInput {
                z: 2
                text: maxFreqSpinbox.textFromValue(maxFreqSpinbox.value, maxFreqSpinbox.locale)

                font: maxFreqSpinbox.font
                color: "white"//"#21be2b"
                selectionColor: "#21be2b"
                selectedTextColor: "#ffffff"
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter

                readOnly: !maxFreqSpinbox.editable
                validator: maxFreqSpinbox.validator
                inputMethodHints: Qt.ImhFormattedNumbersOnly
            }

            up.indicator: Rectangle {
                x: maxFreqSpinbox.mirrored ? 0 : parent.width - width
                height: parent.height
                implicitWidth: 40
                implicitHeight: 40
                color: "black"//durationSpinbox.up.pressed ? "#e4e4e4" : "#f6f6f6"
                border.color: maxFreqSpinbox.activeFocus ? "blue" : "white"

                Text {
                    text: "+"
                    font.pixelSize: maxFreqSpinbox.font.pixelSize * 2
                    color: "white"//"#21be2b"
                    anchors.fill: parent
                    fontSizeMode: Text.Fit
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }

            down.indicator: Rectangle {
                x: maxFreqSpinbox.mirrored ? parent.width - width : 0
                height: parent.height
                implicitWidth: 40
                implicitHeight: 40
                color: "black"//durationSpinbox.down.pressed ? "#e4e4e4" : "#f6f6f6"
                border.color: maxFreqSpinbox.activeFocus ? "blue" : "white"


                Text {
                    text: "-"
                    font.pixelSize: maxFreqSpinbox.font.pixelSize * 2
                    color: "white"//"#21be2b"
                    anchors.fill: parent
                    fontSizeMode: Text.Fit
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }

            background: Rectangle {
                implicitWidth: 140
                color: "black"
                border.color: maxFreqSpinbox.activeFocus ? "blue" : "white"
                border.width: 2
            }
        }

        Label {
            id: label4
            text: qsTr("Use notes") + ":"
            anchors.top: label3.bottom
            anchors.topMargin: 50
            anchors.left: parent.left
            width: 80
            height: 25
            color: "white"
        }

        FocusScope {
            height: 50
            anchors.verticalCenter: label4.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 80
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
                color: "black"//useNotesCheckBox.checked ? "gray" : "light gray"
                property bool checked: parameters.useNotes
                border.color: "white"
                Text {
                    text: useNotesCheckBox.checked ? qsTr("On") : qsTr("Off")
                    anchors.centerIn: parent
                    font.pointSize: 16
                    color: "white"
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
            contentItem: Text {
                text: resetButton.text
                font: resetButton.font
                opacity: enabled ? 1.0 : 0.3
                color: "white"//resetButton.down ? "#17a81a" : "#21be2b"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }
            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 40
                opacity: enabled ? 1 : 0.3
                border.color: "white"//resetButton.down ? "#17a81a" : "#21be2b"
                color: "black"
                border.width: 1
                radius: 2
            }
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
