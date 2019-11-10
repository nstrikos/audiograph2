import QtQuick 2.9
import QtQml 2.2

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
        if (available)
            CanvasJS.paintCanvas()
    }

    onAvailableChanged: updateCanvas()
}
