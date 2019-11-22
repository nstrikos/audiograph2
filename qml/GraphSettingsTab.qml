import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.3

Rectangle {
    property bool invertTheme: parameters.invertTheme

    property color fontColor:  parameters.invertTheme ? "white" : "black"
    property color lightColor: parameters.invertTheme ? "yellow" : "blue"
    onInvertThemeChanged: {
        fontColor = parameters.invertTheme ? "white" : "black"
        bgColor = !parameters.invertTheme ? "white" : "black"
        lightColor = parameters.invertTheme ? "yellow" : "blue"
    }

    property color bgColor: !parameters.invertTheme ? "white" : "black"

    color: bgColor

    Flickable {
        anchors.fill: parent
        contentHeight: 800
        clip: true
        Label {
            id: label1
            anchors.top: parent.top
            anchors.topMargin: 30
            anchors.left: parent.left
            anchors.leftMargin: 10
            width: 80
            height: 15
            text: qsTr("Graph color") + ":"
            color: fontColor
        }
        FocusScope {
            id: graphColorFocusScope
            height: 30
            width: 100
            anchors.verticalCenter: label1.verticalCenter
            //anchors.left: label1.right
            //anchors.leftMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 10
            property alias color: lineColorRect.color
            activeFocusOnTab: true
            Accessible.name: qsTr("Graph color")
            Keys.onSpacePressed: openColorDialog("line color")
            Keys.onEnterPressed: openColorDialog("line color")
            Keys.onReturnPressed: openColorDialog("line color")
            
            Rectangle {
                id: lineColorRect
                anchors.fill: parent
                color: lineColor
                border.color: graphColorFocusScope.activeFocus ? lightColor : "light gray"
                border.width: graphColorFocusScope.activeFocus ? 2 : 1
                MouseArea {
                    anchors.fill: parent
                    onPressed: openColorDialog("line color")
                }
            }
        }
        
        Label {
            id: label2
            text: qsTr("Background color") + ":"
            anchors.top: label1.bottom
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.topMargin: 30
            width: 80
            height: 15
            color: fontColor
        }
        FocusScope {
            id: backgroundColorFocusScope
            height: 30
            width: 100
            anchors.verticalCenter: label2.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 10
            activeFocusOnTab: true
            property alias color: backGroundColorRect.color
            Accessible.name: qsTr("Background color")
            Keys.onSpacePressed: openColorDialog("background color")
            Keys.onEnterPressed: openColorDialog("background color")
            Keys.onReturnPressed: openColorDialog("background color")
            Rectangle {
                id: backGroundColorRect
                anchors.fill: parent
                color: backgroundColor
                border.color: backgroundColorFocusScope.activeFocus ? lightColor : "light gray"
                border.width: backgroundColorFocusScope.activeFocus ? 2 : 1
                MouseArea {
                    anchors.fill: parent
                    onPressed: openColorDialog("background color")
                }
            }
        }
        
        Label {
            id: label3
            text: qsTr("Line width") + ":"
            anchors.top: label2.bottom
            anchors.topMargin: 30
            anchors.left: parent.left
            anchors.leftMargin: 10
            width: 80
            height: 15
            color: fontColor
        }
        SpinBox {
            id: lineWidthSpinbox
            height: 30
            width: 100
            anchors.verticalCenter: label3.verticalCenter
            //anchors.left: label3.right
            //anchors.leftMargin: 10
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
                color: fontColor
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
                implicitWidth: 30
                implicitHeight: 30
                color: "light gray"
                border.color: {
                    if (lineWidthSpinbox.activeFocus) {
                        if (invertTheme)
                            return "yellow"
                        else
                            return "blue"
                    }
                    else {
                        return "light gray"
                    }
                }
                border.width: lineWidthSpinbox.activeFocus ? 2 : 1

                Text {
                    text: "+"
                    font.pixelSize: lineWidthSpinbox.font.pixelSize * 2
                    color: fontColor
                    anchors.fill: parent
                    fontSizeMode: Text.Fit
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }

            down.indicator: Rectangle {
                x: lineWidthSpinbox.mirrored ? parent.width - width : 0
                height: parent.height
                implicitWidth: 30
                implicitHeight: 30
                color: "light gray"
                border.color: {
                    if (lineWidthSpinbox.activeFocus) {
                        if (invertTheme)
                            return "yellow"
                        else
                            return "blue"
                    }
                    else {
                        return "light gray"
                    }
                }
                border.width: lineWidthSpinbox.activeFocus ? 2 : 1

                Text {
                    text: "-"
                    font.pixelSize: lineWidthSpinbox.font.pixelSize * 2
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
                    if (lineWidthSpinbox.activeFocus) {
                        if (invertTheme)
                            return "yellow"
                        else
                            return "blue"
                    }
                    else {
                        return "light gray"
                    }
                }
                border.width: lineWidthSpinbox.activeFocus ? 2 : 1
            }
        }

        Label {
            id: label4
            anchors.top: label3.bottom
            anchors.topMargin: 30
            anchors.left: parent.left
            anchors.leftMargin: 10
            width: 80
            height: 15
            text: qsTr("Highlight color") + ":"
            color: fontColor
        }
        FocusScope {
            id: highlightColorFocusScope
            height: 30
            width: 100
            anchors.verticalCenter: label4.verticalCenter
//            anchors.left: label4.right
//            anchors.leftMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 10
            property alias color: highlightColorRect.color
            activeFocusOnTab: true
            Accessible.name: qsTr("Highlight color")
            Keys.onSpacePressed: openColorDialog("highlight color")
            Keys.onEnterPressed: openColorDialog("highlight color")
            Keys.onReturnPressed: openColorDialog("hightlight color")

            Rectangle {
                id: highlightColorRect
                anchors.fill: parent
                color: highlightColor
                border.color: highlightColorFocusScope.activeFocus ? lightColor : "light gray"
                border.width: highlightColorFocusScope.activeFocus ? 2 : 1
                MouseArea {
                    anchors.fill: parent
                    onPressed: openColorDialog("highlight color")
                }
            }
        }

        Label {
            id: label5
            text: qsTr("Highlight size") + ":"
            anchors.top: label4.bottom
            anchors.topMargin: 30
            anchors.left: parent.left
            anchors.leftMargin: 10
            width: 80
            height: 15
            color: fontColor
        }
        SpinBox {
            id: highlightSizeSpinbox
            height: 30
            width: 100
            anchors.verticalCenter: label5.verticalCenter
//            anchors.left: label5.right
//            anchors.leftMargin: 10
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
            editable: false

            contentItem: TextInput {
                z: 2
                text: highlightSizeSpinbox.textFromValue(highlightSizeSpinbox.value, highlightSizeSpinbox.locale)

                font: highlightSizeSpinbox.font
                color: fontColor
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
                implicitWidth: 30
                implicitHeight: 30
                color: "light gray"
                border.color: {
                    if (highlightSizeSpinbox.activeFocus) {
                        if (invertTheme)
                            return "yellow"
                        else
                            return "blue"
                    }
                    else {
                        return "light gray"
                    }
                }
                border.width: highlightSizeSpinbox.activeFocus ? 2 : 1

                Text {
                    text: "+"
                    font.pixelSize: highlightSizeSpinbox.font.pixelSize * 2
                    color: fontColor
                    anchors.fill: parent
                    fontSizeMode: Text.Fit
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }

            down.indicator: Rectangle {
                x: highlightSizeSpinbox.mirrored ? parent.width - width : 0
                height: parent.height
                implicitWidth: 30
                implicitHeight: 30
                color: "light gray"
                border.color: {
                    if (highlightSizeSpinbox.activeFocus) {
                        if (invertTheme)
                            return "yellow"
                        else
                            return "blue"
                    }
                    else {
                        return "light gray"
                    }
                }
                border.width: highlightSizeSpinbox.activeFocus ? 2 : 1

                Text {
                    text: "-"
                    font.pixelSize: highlightSizeSpinbox.font.pixelSize * 2
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
                    if (highlightSizeSpinbox.activeFocus) {
                        if (invertTheme)
                            return "yellow"
                        else
                            return "blue"
                    }
                    else {
                        return "light gray"
                    }
                }
                border.width: highlightSizeSpinbox.activeFocus ? 2 : 1
            }
        }

        Label {
            id: label6
            anchors.top: label5.bottom
            anchors.topMargin: 30
            anchors.left: parent.left
            anchors.leftMargin: 10
            width: 80
            height: 15
            text: qsTr("Axes") + ":"
            color: fontColor
        }
        FocusScope {
            id: axesColorFocusScope
            height: 30
            width: 100
            anchors.verticalCenter: label6.verticalCenter
//            anchors.left: label6.right
//            anchors.leftMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 10
            property alias color: axesColorRect.color
            Accessible.name: qsTr("Axes color")
            activeFocusOnTab: true
            Keys.onSpacePressed: openColorDialog("axes color")
            Keys.onEnterPressed: openColorDialog("axes color")
            Keys.onReturnPressed: openColorDialog("axes color")
            Rectangle {
                id: axesColorRect
                anchors.fill: parent
                color: axesColor
                border.color: axesColorFocusScope.activeFocus ? lightColor : "light gray"
                border.width: axesColorFocusScope.activeFocus ? 2 : 1
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
            anchors.topMargin: 30
            anchors.left: parent.left
            anchors.leftMargin: 10
            width: 80
            height: 15
            color: fontColor
        }
        SpinBox {
            id: axesSizeSpinbox
            height: 30
            width: 100
            anchors.verticalCenter: label7.verticalCenter
//            anchors.left: label7.right
//            anchors.leftMargin: 10
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
            editable: false

            contentItem: TextInput {
                z: 2
                text: axesSizeSpinbox.textFromValue(axesSizeSpinbox.value, axesSizeSpinbox.locale)

                font: axesSizeSpinbox.font
                color: fontColor
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
                implicitWidth: 30
                implicitHeight: 30
                color: "light gray"
                border.color: {
                    if (axesSizeSpinbox.activeFocus) {
                        if (invertTheme)
                            return "yellow"
                        else
                            return "blue"
                    }
                    else {
                        return "light gray"
                    }
                }
                border.width: axesSizeSpinbox.activeFocus ? 2 : 1

                Text {
                    text: "+"
                    font.pixelSize: axesSizeSpinbox.font.pixelSize * 2
                    color: fontColor
                    anchors.fill: parent
                    fontSizeMode: Text.Fit
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }

            down.indicator: Rectangle {
                x: axesSizeSpinbox.mirrored ? parent.width - width : 0
                height: parent.height
                implicitWidth: 30
                implicitHeight: 30
                color: "light gray"
                border.color: {
                    if (axesSizeSpinbox.activeFocus) {
                        if (invertTheme)
                            return "yellow"
                        else
                            return "blue"
                    }
                    else {
                        return "light gray"
                    }
                }
                border.width: axesSizeSpinbox.activeFocus ? 2 : 1

                Text {
                    text: "-"
                    font.pixelSize: axesSizeSpinbox.font.pixelSize * 2
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
                    if (axesSizeSpinbox.activeFocus) {
                        if (invertTheme)
                            return "yellow"
                        else
                            return "blue"
                    }
                    else {
                        return "light gray"
                    }
                }
                border.width: axesSizeSpinbox.activeFocus ? 2 : 1
            }
        }
        Label {
            id: label8
            text: qsTr("Show grid") + ":"
            anchors.top: label7.bottom
            anchors.topMargin: 30
            anchors.left: parent.left
            anchors.leftMargin: 10
            width: 80
            height: 15
            color: fontColor
        }
        FocusScope {
            id: showAxesFocusScope
            height: 30
            width: 100
            anchors.verticalCenter: label8.verticalCenter
//            anchors.left: label8.right
//            anchors.leftMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 10
            property alias color: showAxesCheckBox.color
            activeFocusOnTab: true
            Accessible.name: qsTr("Show grid")
            Keys.onSpacePressed: showAxesCheckBox.checked = ! showAxesCheckBox.checked
            Keys.onEnterPressed: showAxesCheckBox.checked = ! showAxesCheckBox.checked
            Keys.onReturnPressed: showAxesCheckBox.checked = ! showAxesCheckBox.checked
            
            Rectangle {
                id: showAxesCheckBox
                anchors.fill: parent
                color: bgColor
                border.color: showAxesFocusScope.activeFocus ? lightColor : "light gray"
                border.width: showAxesFocusScope.activeFocus ? 2 : 1
                property bool checked: parameters.showAxes
                Text {
                    text: showAxesCheckBox.checked ? qsTr("On") : qsTr("Off")
                    anchors.centerIn: parent
                    font.pointSize: 16
                    color: fontColor
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
            anchors.topMargin: 30
            anchors.left: parent.left
            anchors.leftMargin: 10
            width: 80
            height: 15
            color: fontColor
        }
        FocusScope {
            id: invertThemeFocusScope
            height: 30
            width: 100
            anchors.verticalCenter: label9.verticalCenter
//            anchors.left: label9.right
//            anchors.leftMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 10
            property alias color: invertThemeCheckBox.color
            activeFocusOnTab: true
            Accessible.name: qsTr("Invert theme")

            Keys.onSpacePressed: invertThemeCheckBox.checked = ! invertThemeCheckBox.checked
            Keys.onEnterPressed: invertThemeCheckBox.checked = ! invertThemeCheckBox.checked
            Keys.onReturnPressed: invertThemeCheckBox.checked = ! invertThemeCheckBox.checked

            Rectangle {
                id: invertThemeCheckBox
                anchors.fill: parent
                color: bgColor
                border.color: invertThemeFocusScope.activeFocus ? lightColor : "light gray"
                border.width: invertThemeFocusScope.activeFocus ? 2 : 1
                property bool checked: parameters.invertTheme
                Text {
                    text: invertThemeCheckBox.checked ? qsTr("On") : qsTr("Off")
                    anchors.centerIn: parent
                    font.pointSize: 16
                    color: fontColor
                }

                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        invertThemeCheckBox.checked = ! invertThemeCheckBox.checked
                    }
                }
                onCheckedChanged: {
                    parameters.invertTheme = checked
                    controlsRect.invertTheme = checked
                    audioSettingsTab.invertTheme = checked
                    graphSettingsTab.invertTheme = checked
                    window.setColor()
                }
            }
        }
        
        Button {
            id: resetButton
            text: qsTr("Reset")
            anchors.top: label9.bottom
            anchors.topMargin: 30
            anchors.left: parent.left
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
                color: fontColor
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }
            background: Rectangle {
                implicitWidth: 100
                implicitHeight: 40
                opacity: enabled ? 1 : 0.3
                color: bgColor
                radius: 2
                border.color: resetButton.activeFocus ? lightColor : "light gray"
                border.width: resetButton.activeFocus ? 2 : 1
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
