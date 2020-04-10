import QtQuick 2.12
import QtQuick.Controls 2.12

import "../BeautityRect"

Rectangle {
    id: controlsRect
    anchors.rightMargin: window.width / 4

    property bool active: true
    color : !parameters.invertTheme ? "white" : "black"
    property color fontColor: parameters.invertTheme ? "white" : "black"
    property color bgColor: !parameters.invertTheme ? "white" : "black"
    property color lightColor: parameters.invertTheme ? "yellow" : "blue"
    property bool invertTheme: parameters.invertTheme

    property alias startSoundButton: controlRectFlickable.startSoundButton

    property alias textInput: controlRectFlickable.textInput
    property alias textInput2: controlRectFlickable.textInput2
    property alias textInput3: controlRectFlickable.textInput3
    property alias textInput4: controlRectFlickable.textInput4
    property alias textInput5: controlRectFlickable.textInput5


    onInvertThemeChanged: {
        fontColor: parameters.invertTheme ? "white" : "black"
        bgColor = !parameters.invertTheme ? "white" : "black"
        lightColor = parameters.invertTheme ? "yellow" : "blue"
    }

    focus: true
    Keys.onPressed: {
        if (event.key === Qt.Key_F2) {
            if (functionController.validExpression())
                window.playPressed()
            else
                textToSpeech.speak(functionController.getError())
            event.accepted = true;
        } else if (event.key === Qt.Key_F3) {
            window.stopAudio()
            functionController.sayXCoordinate()
        } else if (event.key === Qt.Key_F4) {
            window.stopAudio()
            functionController.sayYCoordinate()
        } else if ((event.key === Qt.Key_F7) && (event.modifiers & Qt.ShiftModifier)) {
            window.interestingPoint()
            functionController.previousPointInterestFast()
        } else if (event.key === Qt.Key_F7) {
            window.interestingPoint()
            functionController.previousPointInterest()
        } else if ((event.key === Qt.Key_F8) && (event.modifiers & Qt.ShiftModifier)) {
            window.interestingPoint()
            functionController.nextPointInterestFast()
        } else if (event.key === Qt.Key_F8) {
            window.interestingPoint()
            functionController.nextPointInterest()
        } else if (event.key === Qt.Key_F9) {
            window.explore()
            functionController.previousPoint()
        } else if (event.key === Qt.Key_F10) {
            window.explore()
            functionController.nextPoint()
        } else if (event.key === Qt.Key_F11) {
            functionController.decStep()
        } else if (event.key === Qt.Key_F12) {
            functionController.incStep()
        } else if (event.key === Qt.Key_PageUp) {
            console.log("got here")
            functionController.firstPoint()
        }
    }

    ControlsTitleBar {
        id: controlsTitleBar
    }

    ControlRectFlickable {
        id: controlRectFlickable
    }

    BeautifyRect {
    }

    function newInputValues(minX, maxX, minY, maxY) {
        active = false
        textInput2.text = minX
        textInput3.text = maxX
        textInput4.text = minY
        textInput5.text = maxY
        active = true
    }
}
