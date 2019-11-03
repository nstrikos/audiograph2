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

    TabView {
        id: frame
        anchors.fill: parent
        anchors.margins: 4
        Tab {
            title: "Tab 1"
            Flickable {
                Row {
                    anchors.top: parent.top
                    anchors.topMargin: 30
                    spacing: 20
                    Label {
                        id: label1
                        text: qsTr("Graph color") + ":"
                    }
                    Rectangle {
                        id: lineColorRect
                        height: 50
                        width: 50
                        anchors.verticalCenter: label1.verticalCenter
                        color: lineColor
                        border.color: "gray"
                        MouseArea {
                            anchors.fill: parent
                            onPressed: openColorDialog("line color")
                        }
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
                console.log("Dialog color: ", color)
                parameters.lineColor = color
                lineColor = color
                graphRect.curveColor = color
            }
        }
    }

    function openColorDialog(request) {
        if (request === "line color") {
            colorDialog.color = parameters.lineColor
        }
        colorDialog.request = request
        colorDialog.open()
    }
}
