import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.3

Rectangle {
    color: bgColor

    property bool invertTheme: parameters.invertTheme

    property color fontColor:  parameters.invertTheme ? "white" : "black"
    property color lightColor: parameters.invertTheme ? "yellow" : "blue"

    onInvertThemeChanged: {
        fontColor = parameters.invertTheme ? "white" : "black"
        bgColor = !parameters.invertTheme ? "white" : "black"
        lightColor = parameters.invertTheme ? "yellow" : "blue"
    }

    property color bgColor: !parameters.invertTheme ? "white" : "black"

    Flickable {
        anchors.fill: parent
        contentHeight: 500
        clip: true
        Label {
            id: label1
            anchors.top: parent.top
            anchors.topMargin: 30
            anchors.left: parent.left
            anchors.leftMargin: 10
            width: 80
            height: 15
            color: fontColor
            text: qsTr("Duration") + ":"
        }

        SpinBox {
            id: durationSpinbox
            height: 30
            width: 150
            anchors.verticalCenter: label1.verticalCenter
//            anchors.left: parent.left
//            anchors.leftMargin: 80
            anchors.right: parent.right
            anchors.rightMargin: 10
            activeFocusOnTab: true
            Accessible.name: qsTr("Duration")
            value: parameters.duration
            from: 10
            to: 100
            onValueChanged: {
                window.stopAudio()
                parameters.duration = value
            }

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
                implicitWidth: 30
                implicitHeight: 30
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
                implicitWidth: 30
                implicitHeight: 30
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
            text: qsTr("Minimum frequency") + ":"
            anchors.top: label1.bottom
            anchors.left: parent.left
            anchors.topMargin: 30
            anchors.leftMargin: 10
            width: 80
            height: 15
            color: fontColor
        }
        SpinBox {
            id: minFreqSpinbox
            height: 30
            width: 150
            anchors.verticalCenter: label2.verticalCenter
//            anchors.left: parent.left
//            anchors.leftMargin: 80
            anchors.right: parent.right
            anchors.rightMargin: 10
            activeFocusOnTab: true
            Accessible.name: qsTr("Minimum frequency")
            value: parameters.minFreq
            from: 200
            to: 4000
            stepSize: 100
            onValueChanged: {
                window.stopAudio()
                parameters.minFreq = value
            }

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
                implicitWidth: 30
                implicitHeight: 30
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
                implicitWidth: 30
                implicitHeight: 30
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
            text: qsTr("Maximum frequency") + ":"
            anchors.top: label2.bottom
            anchors.topMargin: 30
            anchors.left: parent.left
            anchors.leftMargin: 10
            width: 80
            height: 15
            color: fontColor
        }
        SpinBox {
            id: maxFreqSpinbox
            height: 30
            width: 150
            anchors.verticalCenter: label3.verticalCenter
//            anchors.left: parent.left
//            anchors.leftMargin: 80
            anchors.right: parent.right
            anchors.rightMargin: 10
            activeFocusOnTab: true
            Accessible.name: qsTr("Maximum frequency")
            value: parameters.maxFreq
            from: 400
            to: 8000
            stepSize: 100
            onValueChanged: {
                window.stopAudio
                parameters.maxFreq = value
            }

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
                implicitWidth: 30
                implicitHeight: 30
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
                implicitWidth: 30
                implicitHeight: 30
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
            anchors.topMargin: 30
            anchors.left: parent.left
            anchors.leftMargin: 10
            width: 80
            height: 15
            color: fontColor
        }

        FocusScope {
            id: useNotesFocusScope
            height: 30
            width: 150
            anchors.verticalCenter: label4.verticalCenter
//            anchors.left: parent.left
//            anchors.leftMargin: 80
            anchors.right: parent.right
            anchors.rightMargin: 10
            property alias color: useNotesCheckBox.color
            activeFocusOnTab: true
            Accessible.name: qsTr("Use notes")

            Keys.onSpacePressed: useNotesCheckBox.checked = ! useNotesCheckBox.checked
            Keys.onEnterPressed: useNotesCheckBox.checked = ! useNotesCheckBox.checked
            Keys.onReturnPressed: useNotesCheckBox.checked = ! useNotesCheckBox.checked

            Rectangle {
                id: useNotesCheckBox
                anchors.fill: parent
                color: bgColor
                property bool checked: parameters.useNotes
                border.color: useNotesFocusScope.activeFocus ? lightColor : "light gray"
                border.width: useNotesFocusScope.activeFocus ? 2 : 1
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
                    window.stopAudio()
                    parameters.useNotes = checked
                }
            }
        }

        Label {
            id: label5
            text: qsTr("Explore mode") + ":"
            anchors.top: label4.bottom
            anchors.topMargin: 30
            anchors.left: parent.left
            anchors.leftMargin: 10
            width: 80
            height: 15
            color: fontColor
        }

        FocusScope {
            id: exploreModeFocusScope
            height: 30
            width: 150
            anchors.verticalCenter: label5.verticalCenter
//            anchors.left: parent.left
//            anchors.leftMargin: 80
            anchors.right: parent.right
            anchors.rightMargin: 10
            property alias color: exploreModeCheckBox.color
            activeFocusOnTab: true
            Accessible.name: qsTr("Explore mode")

            Keys.onSpacePressed: exploreModeCheckBox.checked = ! exploreModeCheckBox.checked
            Keys.onEnterPressed: exploreModeCheckBox.checked = ! exploreModeCheckBox.checked
            Keys.onReturnPressed: exploreModeCheckBox.checked = ! exploreModeCheckBox.checked

            Rectangle {
                id: exploreModeCheckBox
                anchors.fill: parent
                color: bgColor
                property bool checked: parameters.exploreMode
                border.color: exploreModeFocusScope.activeFocus ? lightColor : "light gray"
                border.width: exploreModeFocusScope.activeFocus ? 2 : 1
                Text {
                    text: exploreModeCheckBox.checked ? qsTr("On") : qsTr("Off")
                    anchors.centerIn: parent
                    font.pointSize: 16
                    color: fontColor
                }

                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        exploreModeCheckBox.checked = ! exploreModeCheckBox.checked
                    }
                }
                onCheckedChanged: {
                    window.stopAudio()
                    parameters.exploreMode = checked
                }
            }
        }
        
        Button {
            id: resetButton
            text: qsTr("Reset")
            anchors.top: label5.bottom
            anchors.topMargin: 30
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 10
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
                border.color: resetButton.activeFocus ? lightColor : "light gray"
                color: bgColor
                border.width: resetButton.activeFocus ? 2 : 1
                radius: 2
            }
            Accessible.name: qsTr("Reset audio settings")
            onClicked: {
                parameters.resetAudio()
                durationSpinbox.value = parameters.duration
                minFreqSpinbox.value = parameters.minFreq
                maxFreqSpinbox.value = parameters.maxFreq
                useNotesCheckBox.checked = parameters.useNotes
                window.stopAudio()
            }
        }
    }
}
