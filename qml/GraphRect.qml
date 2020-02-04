import QtQuick 2.12
import Curve 1.0
import CurveMovingPoint 1.0
import DisplayView 1.0

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
    property int step: 100

    function moveForward() {
        currentPoint += step;
        if (currentPoint >= myfunction.lineSize())
            currentPoint = myfunction.lineSize() - 1
        curveMovingPoint.setPoint(myfunction, currentPoint)
        sayYCoordinate()
    }

    function moveBackward() {
        currentPoint -= step;
        if (currentPoint < 0)
            currentPoint = 0;
        curveMovingPoint.setPoint(myfunction, currentPoint)
        sayYCoordinate()
    }

    function sayXCoordinate() {
        if (myfunction.isValid(currentPoint)) {
            var x = Math.round(myfunction.x(currentPoint) * 100) / 100
            textToSpeech.speak(x)
        } else {
            textToSpeech.speak(qsTr("out of function domain"))
        }

    }

    function sayYCoordinate() {
        if (myfunction.isValid(currentPoint)) {
            var y = Math.round(myfunction.y(currentPoint) * 100) / 100
            textToSpeech.speak(y)
        } else {
            textToSpeech.speak(qsTr("not defined"))
        }
    }

    function stopPoint() {
        audioNotes.stopNotes()
    }

    function previousPoint() {
        currentPoint -= step;
        if (currentPoint < 0)
            currentPoint = 0;
        curveMovingPoint.setPoint(myfunction, currentPoint)
        audioNotes.setNote(myfunction, currentPoint, parameters.minFreq, parameters.maxFreq, parameters.useNotes)
    }

    function nextPoint() {
        currentPoint += step;
        if (currentPoint >= myfunction.lineSize())
            currentPoint = myfunction.lineSize() - 1
        curveMovingPoint.setPoint(myfunction, currentPoint)
        audioNotes.setNote(myfunction, currentPoint, parameters.minFreq, parameters.maxFreq, parameters.useNotes)
    }

    function incStep() {
        step *= 2
        step = Math.round(step)
        if (step > 100)
            step = 100
    }

    function decStep() {
        step /= 2
        step = Math.round(step)
        if (step < 1)
            step = 1
    }

    GraphCanvas {
        id: graphCanvas
        anchors.fill: parent
    }

    Curve {
        id: curve
        objectName: "curve"
        anchors.fill: parent
        visible: false
        layer.enabled: true
        layer.samples: 256
        color: parameters.lineColor
        lineWidth: parameters.lineWidth
    }

    DisplayView {
        id: displayView
        objectName: "displayView"
        anchors.fill: parent
        visible: true
        layer.enabled: true
        layer.samples: 256
        color: parameters.lineColor
        lineWidth: parameters.lineWidth
    }

    CurveMovingPoint {
        id: curveMovingPoint
        objectName: "curveMovingPoint"
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
                if (!parameters.exploreMode) {
                    stopAudio()
                    functionController.zoom(wheel.angleDelta.y)
                }
            }

            onPressedChanged: {
                if (!parameters.exploreMode) {
                    if (pressed) {
                        stopAudio()
                        functionController.startDrag(mouseX, mouseY)
                    }
                } else {
                    if (!pressed)
                        audioNotes.stopNotes()
                }
            }
            onPositionChanged: {
                if (!parameters.exploreMode) {
                    if (pressed) {
                        functionController.drag(mouseX, mouseY, width, height)
                    }
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
        //curve.draw(myfunction)
        //curve.visible = true
        functionController.updateView()
    }

    function clearCanvas() {
        //curve.clear()
    }

    function startMovingPoint() {
        //curveMovingPoint.drawPoint(myfunction, parameters.duration)
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

    function stopAudio() {
        //audio.stop()
        audioNotes.stopNotes()
        //graphRect.stopMovingPoint()
        controlsRect.startSoundButton.checked = true
    }
}
