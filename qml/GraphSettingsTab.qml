import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.3

Rectangle {
    color: "black"
    Flickable {
        anchors.fill: parent
        contentHeight: 800
        clip: true
        Label {
            id: label1
            anchors.top: parent.top
            anchors.topMargin: 50
            anchors.left: parent.left
            width: 80
            height: 25
            text: qsTr("Graph\ncolor") + ":"
            color: "white"
        }
        FocusScope {
            height: 50
            anchors.verticalCenter: label1.verticalCenter
            anchors.left: label1.right
            anchors.leftMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 10
            property alias color: lineColorRect.color
            activeFocusOnTab: true
            Accessible.name: qsTr("Graph color")
            onActiveFocusChanged: {
                if (activeFocus) {
                    lineColorRect.border.color = "blue"
                    lineColorRect.border.width = 4
                }
                else {
                    lineColorRect.border.color = "gray"
                    lineColorRect.border.width = 1
                }
            }
            Keys.onSpacePressed: openColorDialog("line color")
            Keys.onEnterPressed: openColorDialog("line color")
            Keys.onReturnPressed: openColorDialog("line color")
            
            Rectangle {
                id: lineColorRect
                anchors.fill: parent
                color: lineColor
                border.color: "gray"
                MouseArea {
                    anchors.fill: parent
                    onPressed: openColorDialog("line color")
                }
            }
        }
        
        Label {
            id: label2
            text: qsTr("Background") + ":"
            anchors.top: label1.bottom
            anchors.left: parent.left
            anchors.topMargin: 50
            width: 80
            height: 25
            color: "white"
        }
        FocusScope {
            height: 50
            anchors.verticalCenter: label2.verticalCenter
            anchors.left: label2.right
            anchors.leftMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 10
            activeFocusOnTab: true
            property alias color: backGroundColorRect.color
            Accessible.name: qsTr("Background color")
            onActiveFocusChanged: {
                if (activeFocus) {
                    backGroundColorRect.border.color = "blue"
                    backGroundColorRect.border.width = 4
                }
                else {
                    backGroundColorRect.border.color = "gray"
                    backGroundColorRect.border.width = 1
                }
            }
            Keys.onSpacePressed: openColorDialog("background color")
            Keys.onEnterPressed: openColorDialog("background color")
            Keys.onReturnPressed: openColorDialog("background color")
            Rectangle {
                id: backGroundColorRect
                anchors.fill: parent
                color: backgroundColor
                border.color: "gray"
                MouseArea {
                    anchors.fill: parent
                    onPressed: openColorDialog("background color")
                }
            }
        }
        
        Label {
            id: label3
            text: qsTr("Width") + ":"
            anchors.top: label2.bottom
            anchors.topMargin: 50
            anchors.left: parent.left
            width: 80
            height: 25
            color: "white"
        }
        SpinBox {
            id: lineWidthSpinbox
            height: 50
            anchors.verticalCenter: label3.verticalCenter
            anchors.left: label3.right
            anchors.leftMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 10
            from: 1
            to: 10
            value: parameters.lineWidth
            Accessible.name: qsTr("Line width")
            onValueChanged: {
                graphRect.curveWidth = value
                parameters.lineWidth = value
            }
            editable: false

            contentItem: TextInput {
                z: 2
                text: lineWidthSpinbox.textFromValue(lineWidthSpinbox.value, lineWidthSpinbox.locale)

                font: lineWidthSpinbox.font
                color: "white"//"#21be2b"
                selectionColor: "#21be2b"
                selectedTextColor: "#ffffff"
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter

                readOnly: !lineWidthSpinbox.editable
                validator: lineWidthSpinbox.validator
                inputMethodHints: Qt.ImhFormattedNumbersOnly
            }

            up.indicator: Rectangle {
                x: lineWidthSpinbox.mirrored ? 0 : parent.width - width
                height: parent.height
                implicitWidth: 40
                implicitHeight: 40
                color: "black"//durationSpinbox.up.pressed ? "#e4e4e4" : "#f6f6f6"
                border.color: lineWidthSpinbox.activeFocus ? "blue" : "white"

                Text {
                    text: "+"
                    font.pixelSize: lineWidthSpinbox.font.pixelSize * 2
                    color: "white"//"#21be2b"
                    anchors.fill: parent
                    fontSizeMode: Text.Fit
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }

            down.indicator: Rectangle {
                x: lineWidthSpinbox.mirrored ? parent.width - width : 0
                height: parent.height
                implicitWidth: 40
                implicitHeight: 40
                color: "black"//durationSpinbox.down.pressed ? "#e4e4e4" : "#f6f6f6"
                border.color: lineWidthSpinbox.activeFocus ? "blue" : "white"


                Text {
                    text: "-"
                    font.pixelSize: lineWidthSpinbox.font.pixelSize * 2
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
                border.color: lineWidthSpinbox.activeFocus ? "blue" : "white"
                border.width: 2
            }
        }

        Label {
            id: label4
            anchors.top: label3.bottom
            anchors.topMargin: 50
            anchors.left: parent.left
            width: 80
            height: 25
            text: qsTr("Highlight") + ":"
            color: "white"
        }
        FocusScope {
            height: 50
            anchors.verticalCenter: label4.verticalCenter
            anchors.left: label4.right
            anchors.leftMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 10
            property alias color: highlightColorRect.color
            activeFocusOnTab: true
            Accessible.name: qsTr("Highlight color")
            onActiveFocusChanged: {
                if (activeFocus) {
                    highlightColorRect.border.color = "blue"
                    highlightColorRect.border.width = 4
                }
                else {
                    highlightColorRect.border.color = "gray"
                    highlightColorRect.border.width = 1
                }
            }
            Keys.onSpacePressed: openColorDialog("highlight color")
            Keys.onEnterPressed: openColorDialog("highlight color")
            Keys.onReturnPressed: openColorDialog("hightlight color")

            Rectangle {
                id: highlightColorRect
                anchors.fill: parent
                color: highlightColor
                border.color: "gray"
                MouseArea {
                    anchors.fill: parent
                    onPressed: openColorDialog("highlight color")
                }
            }
        }

        Label {
            id: label5
            text: qsTr("Highlight\nsize") + ":"
            anchors.top: label4.bottom
            anchors.topMargin: 50
            anchors.left: parent.left
            width: 80
            height: 25
            color: "white"
        }
        SpinBox {
            id: highlightSizeSpinbox
            height: 50
            anchors.verticalCenter: label5.verticalCenter
            anchors.left: label5.right
            anchors.leftMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 10
            from: 5
            to: 20
            value: parameters.highlightSize
            Accessible.name: qsTr("Highlight size")
            onValueChanged: {
                graphRect.highlightSize = value
                parameters.highlightSize = value
            }
            editable: true

            contentItem: TextInput {
                z: 2
                text: highlightSizeSpinbox.textFromValue(highlightSizeSpinbox.value, highlightSizeSpinbox.locale)

                font: highlightSizeSpinbox.font
                color: "white"//"#21be2b"
                selectionColor: "#21be2b"
                selectedTextColor: "#ffffff"
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter

                readOnly: !highlightSizeSpinbox.editable
                validator: highlightSizeSpinbox.validator
                inputMethodHints: Qt.ImhFormattedNumbersOnly
            }

            up.indicator: Rectangle {
                x: highlightSizeSpinbox.mirrored ? 0 : parent.width - width
                height: parent.height
                implicitWidth: 40
                implicitHeight: 40
                color: "black"//durationSpinbox.up.pressed ? "#e4e4e4" : "#f6f6f6"
                border.color: highlightSizeSpinbox.activeFocus ? "blue" : "white"

                Text {
                    text: "+"
                    font.pixelSize: highlightSizeSpinbox.font.pixelSize * 2
                    color: "white"//"#21be2b"
                    anchors.fill: parent
                    fontSizeMode: Text.Fit
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }

            down.indicator: Rectangle {
                x: highlightSizeSpinbox.mirrored ? parent.width - width : 0
                height: parent.height
                implicitWidth: 40
                implicitHeight: 40
                color: "black"//durationSpinbox.down.pressed ? "#e4e4e4" : "#f6f6f6"
                border.color: highlightSizeSpinbox.activeFocus ? "blue" : "white"


                Text {
                    text: "-"
                    font.pixelSize: highlightSizeSpinbox.font.pixelSize * 2
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
                border.color: highlightSizeSpinbox.activeFocus ? "blue" : "white"
                border.width: 2
            }
        }

        Label {
            id: label6
            anchors.top: label5.bottom
            anchors.topMargin: 50
            anchors.left: parent.left
            width: 80
            height: 25
            text: qsTr("Axes") + ":"
            color: "white"
        }
        FocusScope {
            height: 50
            anchors.verticalCenter: label6.verticalCenter
            anchors.left: label6.right
            anchors.leftMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 10
            property alias color: axesColorRect.color
            Accessible.name: qsTr("Axes color")
            activeFocusOnTab: true
            onActiveFocusChanged: {
                if (activeFocus) {
                    axesColorRect.border.color = "blue"
                    axesColorRect.border.width = 4
                }
                else {
                    axesColorRect.border.color = "gray"
                    axesColorRect.border.width = 1
                }
            }
            Keys.onSpacePressed: openColorDialog("axes color")
            Keys.onEnterPressed: openColorDialog("axes color")
            Keys.onReturnPressed: openColorDialog("axes color")
            Rectangle {
                id: axesColorRect
                anchors.fill: parent
                color: axesColor
                border.color: "white"
                MouseArea {
                    anchors.fill: parent
                    onPressed: openColorDialog("axes color")
                }
            }
        }
        Label {
            id: label7
            text: qsTr("Axes size")
            anchors.top: label6.bottom
            anchors.topMargin: 50
            anchors.left: parent.left
            width: 80
            height: 25
            color: "white"
        }
        SpinBox {
            id: axesSizeSpinbox
            height: 50
            anchors.verticalCenter: label7.verticalCenter
            anchors.left: label7.right
            anchors.leftMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 10
            from: 1
            to: 10
            value: parameters.axesSize
            Accessible.name: qsTr("Axes size")
            onValueChanged: {
                parameters.axesSize = value
                graphRect.graphCanvas.updateCanvas()
            }
            editable: true

            contentItem: TextInput {
                z: 2
                text: axesSizeSpinbox.textFromValue(axesSizeSpinbox.value, axesSizeSpinbox.locale)

                font: axesSizeSpinbox.font
                color: "white"//"#21be2b"
                selectionColor: "#21be2b"
                selectedTextColor: "#ffffff"
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter

                readOnly: !axesSizeSpinbox.editable
                validator: axesSizeSpinbox.validator
                inputMethodHints: Qt.ImhFormattedNumbersOnly
            }

            up.indicator: Rectangle {
                x: axesSizeSpinbox.mirrored ? 0 : parent.width - width
                height: parent.height
                implicitWidth: 40
                implicitHeight: 40
                color: "black"//durationSpinbox.up.pressed ? "#e4e4e4" : "#f6f6f6"
                border.color: axesSizeSpinbox.activeFocus ? "blue" : "white"

                Text {
                    text: "+"
                    font.pixelSize: axesSizeSpinbox.font.pixelSize * 2
                    color: "white"//"#21be2b"
                    anchors.fill: parent
                    fontSizeMode: Text.Fit
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }

            down.indicator: Rectangle {
                x: axesSizeSpinbox.mirrored ? parent.width - width : 0
                height: parent.height
                implicitWidth: 40
                implicitHeight: 40
                color: "black"//durationSpinbox.down.pressed ? "#e4e4e4" : "#f6f6f6"
                border.color: axesSizeSpinbox.activeFocus ? "blue" : "white"


                Text {
                    text: "-"
                    font.pixelSize: axesSizeSpinbox.font.pixelSize * 2
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
                border.color: axesSizeSpinbox.activeFocus ? "blue" : "white"
                border.width: 2
            }
        }
        Label {
            id: label8
            text: qsTr("Show grid") + ":"
            anchors.top: label7.bottom
            anchors.topMargin: 50
            anchors.left: parent.left
            width: 80
            height: 25
            color: "white"
        }
        FocusScope {
            height: 50
            anchors.verticalCenter: label8.verticalCenter
            anchors.left: label8.right
            anchors.leftMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 10
            property alias color: showAxesCheckBox.color
            activeFocusOnTab: true
            Accessible.name: qsTr("Show grid")
            onActiveFocusChanged: {
                if (activeFocus) {
                    showAxesCheckBox.border.color = "blue"
                    showAxesCheckBox.border.width = 4
                }
                else {
                    showAxesCheckBox.border.color = "gray"
                    showAxesCheckBox.border.width = 1
                }
            }
            Keys.onSpacePressed: showAxesCheckBox.checked = ! showAxesCheckBox.checked
            Keys.onEnterPressed: showAxesCheckBox.checked = ! showAxesCheckBox.checked
            Keys.onReturnPressed: showAxesCheckBox.checked = ! showAxesCheckBox.checked
            
            Rectangle {
                id: showAxesCheckBox
                anchors.fill: parent
                color: "black"//showAxesCheckBox.checked ? "gray" : "light gray"
                border.color: "white"
                property bool checked: parameters.showAxes
                Text {
                    text: showAxesCheckBox.checked ? qsTr("On") : qsTr("Off")
                    anchors.centerIn: parent
                    font.pointSize: 16
                    color: "white"
                }
                
                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        showAxesCheckBox.checked = ! showAxesCheckBox.checked
                    }
                }
                onCheckedChanged: {
                    parameters.showAxes = checked
                    graphRect.graphCanvas.updateCanvas()
                }
            }
        }

        Label {
            id: label9
            text: qsTr("Invert theme") + ":"
            anchors.top: label8.bottom
            anchors.topMargin: 50
            anchors.left: parent.left
            width: 80
            height: 25
            color: "white"
        }
        FocusScope {
            height: 50
            anchors.verticalCenter: label9.verticalCenter
            anchors.left: label9.right
            anchors.leftMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 10
            property alias color: invertThemeCheckBox.color
            activeFocusOnTab: true
            Accessible.name: qsTr("Show grid")
            onActiveFocusChanged: {
                if (activeFocus) {
                    invertThemeCheckBox.border.color = "blue"
                    invertThemeCheckBox.border.width = 4
                }
                else {
                    invertThemeCheckBox.border.color = "gray"
                    invertThemeCheckBox.border.width = 1
                }
            }
            Keys.onSpacePressed: invertThemeCheckBox.checked = ! invertThemeCheckBox.checked
            Keys.onEnterPressed: invertThemeCheckBox.checked = ! invertThemeCheckBox.checked
            Keys.onReturnPressed: invertThemeCheckBox.checked = ! invertThemeCheckBox.checked

            Rectangle {
                id: invertThemeCheckBox
                anchors.fill: parent
                color: "black"//invertThemeCheckBox.checked ? "gray" : "light gray"
                border.color: "white"
                property bool checked: parameters.showAxes
                Text {
                    text: invertThemeCheckBox.checked ? qsTr("On") : qsTr("Off")
                    anchors.centerIn: parent
                    font.pointSize: 16
                    color: "white"
                }

                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        invertThemeCheckBox.checked = ! invertThemeCheckBox.checked
                    }
                }
                onCheckedChanged: {
                    parameters.invertTheme = checked
                    audioSettingsTab.invertTheme = checked
                    window.setColor()
                }
            }
        }
        
        Button {
            id: resetButton
            text: qsTr("Reset")
            anchors.top: label9.bottom
            anchors.topMargin: 50
            anchors.left: label8.right
            anchors.right: parent.right
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            width: 80
            height: 50
            Accessible.name: qsTr("Reset graph settings")
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
            onClicked: {
                parameters.reset()
                lineColor = parameters.lineColor
                graphRect.curveColor = parameters.lineColor
                backGroundColorRect.color = parameters.backgroundColor
                graphRect.curveWidth = parameters.lineWidth
                lineWidthSpinbox.value = parameters.lineWidth
                highlightColor = parameters.highlightColor
                graphRect.highlightColor = parameters.highlightColor
                axesColorRect.color = parameters.axesColor
                axesSizeSpinbox.value = parameters.axesSize
                showAxesCheckBox.checked = parameters.showAxes
                graphRect.updateCanvas()
                invertThemeCheckBox.checked = parameters.invertTheme
                window.setColor()
            }
        }
    }
}
