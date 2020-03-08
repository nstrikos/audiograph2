import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.3

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
