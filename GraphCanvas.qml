import QtQuick 2.9
import QtQml 2.2

import "GraphCanvasJS.js" as CanvasJS

Canvas {
    id: canvas

    renderStrategy: Canvas.Immediate

    function updatePoints() {
        CanvasJS.paintCanvas()
    }
}
