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
        visible: false
        layer.enabled: true
        layer.samples: 256
        color: "red"
    }

    PinchArea {
        anchors.fill: parent
        onPinchStarted: controlsRect.startPinch()
        onPinchUpdated: controlsRect.handlePinch(pinch.scale)
        onPinchFinished: controlsRect.pinchFinished()
        MouseArea {
            anchors.fill: parent
            onWheel: controlsRect.handleZoom(wheel.angleDelta.y)

            onPressedChanged: {
                if (pressed)
                    controlsRect.startDrag(mouseX, mouseY)
            }
            onPositionChanged: {
                if (pressed)
                    controlsRect.handleDrag(mouseX, mouseY)
            }
        }
    }

    function updateCanvas() {
        graphCanvas.updateCanvas()
        curve.draw(myfunction)
        curve.visible = true
    }

    onWidthChanged: controlsRect.calculate()
    onHeightChanged: controlsRect.calculate()
}
