import QtQuick 2.12
import Curve 1.0
import CurveMovingPoint 1.0

Rectangle {
    id: graphRect
    z: 10
    color: "white"

    layer.enabled: true
    layer.samples: 256

    property var graphCanvas: graphCanvas
    property color curveColor: parameters.lineColor
    property var curveWidth: parameters.lineWidth
    property color highlightColor: parameters.highlightColor
    property var highlightSize: parameters.highlightSize

    property alias curveMovingPoint: curveMovingPoint

    property int currentPoint: 0

    function stopPoint() {
        audioNotes.stopNotes()
    }

    function previousPoint() {
        currentPoint -= 100;
        curveMovingPoint.setPoint(myfunction, currentPoint)
        audioNotes.setNote(myfunction, currentPoint, parameters.minFreq, parameters.maxFreq, parameters.useNotes)
    }

    function nextPoint() {
        currentPoint += 100;
        curveMovingPoint.setPoint(myfunction, currentPoint)
        audioNotes.setNote(myfunction, currentPoint, parameters.minFreq, parameters.maxFreq, parameters.useNotes)
    }

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
        color: parameters.lineColor
        lineWidth: parameters.lineWidth
    }

    CurveMovingPoint {
        id: curveMovingPoint
        anchors.fill: parent
        layer.enabled: true
        layer.samples: 256
        color: parameters.highlightColor
        size: parameters.highlightSize
    }

    onCurveColorChanged: curve.color = curveColor
    onCurveWidthChanged: curve.lineWidth = curveWidth
    onHighlightColorChanged: curveMovingPoint.color = highlightColor
    onHighlightSizeChanged: curveMovingPoint.size = highlightSize

    PinchArea {
        anchors.fill: parent
        onPinchStarted: controlsRect.startPinch()
        onPinchUpdated: controlsRect.handlePinch(pinch.scale)
        onPinchFinished: controlsRect.pinchFinished()
        MouseArea {
            anchors.fill: parent
            onWheel: {
                if (!parameters.exploreMode)
                    controlsRect.handleZoom(wheel.angleDelta.y)
            }

            onPressedChanged: {
                if (!parameters.exploreMode) {
                    if (pressed)
                        controlsRect.startDrag(mouseX, mouseY)
                } else {
                    if (!pressed)
                        audioNotes.stopNotes()
                }
            }
            onPositionChanged: {
                if (!parameters.exploreMode) {
                    if (pressed)
                        controlsRect.handleDrag(mouseX, mouseY)
                } else {
                    if (pressed) {
                        graphRect.curveMovingPoint.setMouseX(myfunction, mouseX)
                        audioNotes.setNote(myfunction, mouseX, width, parameters.minFreq, parameters.maxFreq, parameters.useNotes)
                    }
                }
            }
        }
    }

    function updateCanvas() {
        graphCanvas.updateCanvas()
        curve.draw(myfunction)
        curve.visible = true
    }

    function clearCanvas() {
        curve.clear()
    }

    function startMovingPoint() {
        curveMovingPoint.drawPoint(myfunction, parameters.duration)
    }

    function stopMovingPoint() {
        curveMovingPoint.stopPoint()
    }

    onWidthChanged: updateCanvas()
    onHeightChanged: updateCanvas()

    BeautifyGraphRect {

    }

    BeautifyGraphRect {
        anchors.top: parent.top
        anchors.bottom: undefined
        height: 8
        visible: (settingsRect.height > 0) && (!anchorToLeft)

        gradient: Gradient {
            GradientStop {
                color: Qt.rgba(0, 0, 0, 0.4)
                position: 0
            }
            GradientStop {
                color: Qt.rgba(0, 0, 0, 0.15)
                position: 0.5
            }
            GradientStop {
                color: Qt.rgba(0, 0, 0, 0)
                position: 1
            }
        }
    }

    BeautifyRect {
        visible: (settingsRect.width > 0)
    }
}
