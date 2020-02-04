import QtQuick 2.9

import "GraphCanvasJS.js" as CanvasJS

Canvas {
    id: canvas

    property var ctx
    property var xGridValues: []
    property var yGridValues: []
    property var xGridCoords: []
    property var yGridCoords: []

    renderStrategy: Canvas.Immediate

    function updateCanvas() {
        controlsRect.stopAudio()
        if (available)
            CanvasJS.paintCanvas()
    }

    onAvailableChanged: updateCanvas()
    onWidthChanged: updateCanvas()
    onHeightChanged: updateCanvas()
}
