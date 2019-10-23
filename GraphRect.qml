import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import Curve 1.0


Rectangle {
    id: graphRect
    z: 10
    color: "white"

    layer.enabled: true
    layer.samples: 256

    property var graphCanvas: graphCanvas

    GraphCanvas {
        id: graphCanvas
        anchors.fill: parent
    }

    Curve {
        id: curve
        anchors.fill: parent
        layer.enabled: true
        layer.samples: 256
        color: "red"
    }

    function updatePoints() {
        graphCanvas.updatePoints()
        curve.draw(myfunction)
    }
}
