import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Dialogs 1.3

import "AudioSettings"

Rectangle {
    id: settingsRect
    anchors.leftMargin: window.width / 8

    property color lineColor: parameters.lineColor
    property color backgroundColor: parameters.backgroundColor
    property color highlightColor: parameters.highlightColor
    property color axesColor: parameters.axesColor

    TabBar {
        id: bar
        width: parent.width
        TabButton {
            text: qsTr("Audio")
        }
        TabButton {
            text: qsTr("Graph")
        }
    }

    StackLayout {
        width: parent.width
        anchors.top: bar.bottom
        anchors.bottom: parent.bottom
        currentIndex: bar.currentIndex
        AudioSettingsTab {
            id: audioSettingsTab
        }
        GraphSettingsTab {
            id: graphSettingsTab
        }
        Item {
            id: activityTab
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
            } else if (request === "highlight color") {
                parameters.highlightColor = color
                highlightColor = color
                graphRect.highlightColor = color
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
        } else if (request === "highlight color") {
            colorDialog.color = parameters.highlightColor
        }

        colorDialog.request = request
        colorDialog.open()
    }
}
