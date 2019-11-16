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

    Keys.onPressed: {
        if (event.key === Qt.Key_F2) {
            controlsRect.startSoundButtonClicked()
            event.accepted = true;
        }
    }

    TabView {
        id: frame
        anchors.fill: parent
        anchors.margins: 4
        GraphSettingsTab {
        }
        AudioSettingsTab {
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
