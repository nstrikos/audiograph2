import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.12
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.3

Rectangle {
    id: settingsRect
    anchors.leftMargin: window.width / 8

    property color lineColor: parameters.lineColor
    property color backgroundColor: parameters.backgroundColor

    TabView {
        id: frame
        anchors.fill: parent
        anchors.margins: 4
        Tab {
            title: qsTr("Graph settings")
            Flickable {
                Label {
                    id: label1
                    anchors.top: parent.top
                    anchors.topMargin: 50
                    text: qsTr("Graph color") + ":"
                }
                Rectangle {
                    id: lineColorRect
                    height: 50
                    width: 50
                    anchors.verticalCenter: label1.verticalCenter
                    anchors.left: parent.horizontalCenter
                    anchors.leftMargin: -80
                    color: lineColor
                    border.color: "gray"
                    MouseArea {
                        anchors.fill: parent
                        onPressed: openColorDialog("line color")
                    }
                }

                Label {
                    id: label2
                    text: qsTr("Background color") + ":"
                    anchors.top: label1.bottom
                    anchors.topMargin: 50
                }
                Rectangle {
                    id: backGroundColorRect
                    height: 50
                    width: 50
                    anchors.verticalCenter: label2.verticalCenter
                    anchors.left: parent.horizontalCenter
                    anchors.leftMargin: -80
                    color: backgroundColor
                    border.color: "gray"
                    MouseArea {
                        anchors.fill: parent
                        onPressed: openColorDialog("background color")
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
                implicitWidth: settingsRect.width / 2//Math.max(text.width + 4, 180)
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
            }
        }
    }

    function openColorDialog(request) {
        if (request === "line color") {
            colorDialog.color = parameters.lineColor
        } else if (request === "background color") {
            colorDialog.color = parameters.backgroundColor
        }

        colorDialog.request = request
        colorDialog.open()
    }
}
