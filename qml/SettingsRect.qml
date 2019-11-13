import QtQuick 2.12
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.3

Rectangle {
    id: settingsRect
    anchors.leftMargin: window.width / 8

    property color lineColor: parameters.lineColor
    property color backgroundColor: parameters.backgroundColor
    property color axesColor: parameters.axesColor

    TabView {
        id: frame
        anchors.fill: parent
        anchors.margins: 4
        Tab {
            title: qsTr("Graph settings")
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
                    text: qsTr("Graph color") + ":"
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
                }
                SpinBox {
                    id: lineWidthSpinbox
                    height: 50
                    anchors.verticalCenter: label3.verticalCenter
                    anchors.left: label3.right
                    anchors.leftMargin: 10
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    minimumValue: 1
                    maximumValue: 10
                    value: parameters.lineWidth
                    Accessible.name: qsTr("Line width")
                    onValueChanged: {
                        graphRect.curveWidth = value
                        parameters.lineWidth = value
                    }
                }
                Label {
                    id: label4
                    anchors.top: label3.bottom
                    anchors.topMargin: 50
                    anchors.left: parent.left
                    width: 80
                    height: 25
                    text: qsTr("Axes") + ":"
                }
                FocusScope {
                    height: 50
                    anchors.verticalCenter: label4.verticalCenter
                    anchors.left: label4.right
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
                        border.color: "gray"
                        MouseArea {
                            anchors.fill: parent
                            onPressed: openColorDialog("axes color")
                        }
                    }
                }
                Label {
                    id: label5
                    text: qsTr("Axes size") + ":"
                    anchors.top: label4.bottom
                    anchors.topMargin: 50
                    anchors.left: parent.left
                    width: 80
                    height: 25
                }
                SpinBox {
                    id: axesSizeSpinbox
                    height: 50
                    anchors.verticalCenter: label5.verticalCenter
                    anchors.left: label5.right
                    anchors.leftMargin: 10
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    minimumValue: 1
                    maximumValue: 10
                    value: parameters.axesSize
                    Accessible.name: qsTr("Axes size")
                    onValueChanged: {
                        parameters.axesSize = value
                        graphRect.graphCanvas.updateCanvas()
                    }
                }
                Label {
                    id: label6
                    text: qsTr("Show grid") + ":"
                    anchors.top: label5.bottom
                    anchors.topMargin: 50
                    anchors.left: parent.left
                    width: 80
                    height: 25
                }
                FocusScope {
                    height: 50
                    anchors.verticalCenter: label6.verticalCenter
                    anchors.left: label6.right
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
                        color: showAxesCheckBox.checked ? "gray" : "light gray"
                        property bool checked: parameters.showAxes
                        Text {
                            text: showAxesCheckBox.checked ? qsTr("On") : qsTr("Off")
                            anchors.centerIn: parent
                            font.pointSize: 16
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

                Button {
                    id: resetBuuton
                    text: qsTr("Reset")
                    anchors.top: label6.bottom
                    anchors.topMargin: 50
                    anchors.left: label6.right
                    anchors.right: parent.right
                    anchors.leftMargin: 10
                    anchors.rightMargin: 10
                    width: 80
                    height: 50
                    Accessible.name: qsTr("Reset graph settings")
                    onClicked: {
                        parameters.reset()
                        lineColor = parameters.lineColor
                        graphRect.curveColor = parameters.lineColor
                        backGroundColorRect.color = parameters.backgroundColor
                        graphRect.curveWidth = parameters.lineWidth
                        lineWidthSpinbox.value = parameters.lineWidth
                        axesColorRect.color = parameters.axesColor
                        axesSizeSpinbox.value = parameters.axesSize
                        showAxesCheckBox.checked = parameters.showAxes
                        graphRect.updateCanvas()
                    }
                }
            }
        }
        Tab { title: "Tab 2" }
        Tab { title: "Tab 3" }

        style: TabViewStyle {
            frameOverlap: 10
            tab: Rectangle {
                color: styleData.selected ? "gray" :"light gray"
                border.color:  "gray"
                implicitWidth: settingsRect.width / 2
                implicitHeight: 30
                radius: 2
                Text {
                    id: text
                    anchors.centerIn: parent
                    text: styleData.title
                    color: styleData.selected ? "white" : "black"
                }
            }
            frame: Rectangle { color: "white" }
        }
    }

    ColorDialog {
        id: colorDialog
        property var request
        onAccepted: {
            if (request === "line color") {
                parameters.lineColor = color
                lineColor = color
                graphRect.curveColor = color
            } else if (request === "background color") {
                parameters.backgroundColor = color
                backgroundColor = color
                graphRect.graphCanvas.updateCanvas()
            } else if (request === "axes color") {
                parameters.axesColor = color
                axesColor = color
                graphRect.graphCanvas.updateCanvas()
            }
        }
    }

    function openColorDialog(request) {
        if (request === "line color") {
            colorDialog.color = parameters.lineColor
        } else if (request === "background color") {
            colorDialog.color = parameters.backgroundColor
        } else if (request === "axes color") {
            colorDialog.color = parameters.axesColor
        }

        colorDialog.request = request
        colorDialog.open()
    }
}
