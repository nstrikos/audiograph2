import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.3

Rectangle {
    color: bgColor

    property bool invertTheme: parameters.invertTheme

    property color fontColor:  parameters.invertTheme ? "white" : "black"
    onInvertThemeChanged: {
        fontColor = parameters.invertTheme ? "white" : "black"
        bgColor = !parameters.invertTheme ? "white" : "black"
    }

    property color bgColor: !parameters.invertTheme ? "white" : "black"

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
            color: fontColor
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

            editable: false

            contentItem: TextInput {
                z: 2
                text: durationSpinbox.textFromValue(durationSpinbox.value, durationSpinbox.locale)

                font: durationSpinbox.font
                color: fontColor
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
                color: "light gray"
                border.color: {
                    if (durationSpinbox.activeFocus) {
                        if (invertTheme)
                            return "yellow"
                        else
                            return "blue"
                    }
                    else {
                        return "light gray"
                    }
                }
                border.width: durationSpinbox.activeFocus ? 2 : 1

                Text {
                    text: "+"
                    font.pixelSize: durationSpinbox.font.pixelSize * 2
                    color: fontColor
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
                color: "light gray"
                border.color: {
                    if (durationSpinbox.activeFocus) {
                        if (invertTheme)
                            return "yellow"
                        else
                            return "blue"
                    }
                    else {
                        return "light gray"
                    }
                }
                border.width: durationSpinbox.activeFocus ? 2 : 1

                Text {
                    text: "-"
                    font.pixelSize: durationSpinbox.font.pixelSize * 2
                    color: fontColor
                    anchors.fill: parent
                    fontSizeMode: Text.Fit
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }

            background: Rectangle {
                implicitWidth: 140
                color: bgColor
                border.color: {
                    if (durationSpinbox.activeFocus) {
                        if (invertTheme)
                            return "yellow"
                        else
                            return "blue"
                    }
                    else {
                        return "light gray"
                    }
                }
                border.width: durationSpinbox.activeFocus ? 2 : 1
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
            color: fontColor
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

            editable: false

            contentItem: TextInput {
                z: 2
                text: minFreqSpinbox.textFromValue(minFreqSpinbox.value, minFreqSpinbox.locale)

                font: minFreqSpinbox.font
                color: fontColor
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
                color: "light gray"
                border.color: {
                    if (minFreqSpinbox.activeFocus) {
                        if (invertTheme)
                            return "yellow"
                        else
                            return "blue"
                    }
                    else {
                        return "light gray"
                    }
                }
                border.width: minFreqSpinbox.activeFocus ? 2 : 1
                Text {
                    text: "+"
                    font.pixelSize: minFreqSpinbox.font.pixelSize * 2
                    color: fontColor
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
                color: "light gray"
                border.color: {
                    if (minFreqSpinbox.activeFocus) {
                        if (invertTheme)
                            return "yellow"
                        else
                            return "blue"
                    }
                    else {
                        return "light gray"
                    }
                }
                border.width: minFreqSpinbox.activeFocus ? 2 : 1


                Text {
                    text: "-"
                    font.pixelSize: minFreqSpinbox.font.pixelSize * 2
                    color: fontColor
                    anchors.fill: parent
                    fontSizeMode: Text.Fit
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }

            background: Rectangle {
                implicitWidth: 140
                color: bgColor
                border.color: {
                    if (minFreqSpinbox.activeFocus) {
                        if (invertTheme)
                            return "yellow"
                        else
                            return "blue"
                    }
                    else {
                        return "light gray"
                    }
                }
                border.width: minFreqSpinbox.activeFocus ? 2 : 1
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
            color: fontColor
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

            editable: false

            contentItem: TextInput {
                z: 2
                text: maxFreqSpinbox.textFromValue(maxFreqSpinbox.value, maxFreqSpinbox.locale)

                font: maxFreqSpinbox.font
                color: fontColor
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
                color: "light gray"
                border.color: {
                    if (maxFreqSpinbox.activeFocus) {
                        if (invertTheme)
                            return "yellow"
                        else
                            return "blue"
                    }
                    else {
                        return "light gray"
                    }
                }
                border.width: maxFreqSpinbox.activeFocus ? 2 : 1

                Text {
                    text: "+"
                    font.pixelSize: maxFreqSpinbox.font.pixelSize * 2
                    color: fontColor
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
                color: "light gray"
                border.color: {
                    if (maxFreqSpinbox.activeFocus) {
                        if (invertTheme)
                            return "yellow"
                        else
                            return "blue"
                    }
                    else {
                        return "light gray"
                    }
                }


                Text {
                    text: "-"
                    font.pixelSize: maxFreqSpinbox.font.pixelSize * 2
                    color: fontColor
                    anchors.fill: parent
                    fontSizeMode: Text.Fit
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }

            background: Rectangle {
                implicitWidth: 140
                color: bgColor
                border.color: {
                    if (maxFreqSpinbox.activeFocus) {
                        if (invertTheme)
                            return "yellow"
                        else
                            return "blue"
                    }
                    else {
                        return "light gray"
                    }
                }
                border.width: maxFreqSpinbox.activeFocus ? 2 : 1
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
            color: fontColor
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
                    if (invertTheme)
                        useNotesCheckBox.border.color = "yellow"
                    else
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
                color: bgColor
                property bool checked: parameters.useNotes
                border.color: "light gray"
                Text {
                    text: useNotesCheckBox.checked ? qsTr("On") : qsTr("Off")
                    anchors.centerIn: parent
                    font.pointSize: 16
                    color: fontColor
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
                color: fontColor
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }
            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 40
                opacity: enabled ? 1 : 0.3
                border.color: "light gray"
                color: bgColor
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
