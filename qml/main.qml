import QtQuick 2.12
import QtQuick.Window 2.12

import QtQml.StateMachine 1.0 as DSM

import "ControlsRect"
import "GraphRect"
import "SettingsRect"

Window {
    id: window
    visible: true

    //on android setting width and height results in
    //not showing correctly the application
    width: Qt.platform.os === "android" ? 320 : Screen.width
    height: Qt.platform.os === "android" ? 350 : Screen.height
    minimumWidth: 320
    minimumHeight: 320
    title: qsTr("Audiographs")

    property bool anchorToLeft: undefined

    signal evaluate()
    signal playPressed()
    signal newGraph()
    signal error()
    signal stopAudio()
    signal explore()
    signal interestingPoint()

    ControlsRect {
        id: controlsRect
    }

    ControlsButton {
        id: controlsButton
    }

    GraphRect {
        id: graphRect
    }

    SettingsButton {
        id: settingsButton
    }

    SettingsRect {
        id: settingsRect
    }

    AnchorChangeState {
        id: anchorChangeState
    }

    Component.onCompleted: {
        setAnchor()
        if (anchorToLeft)
            anchorChangeState.state = 'state1'
        else
            anchorChangeState.state = 'state4'
    }

    onWidthChanged: setAnchor()
    onHeightChanged: setAnchor()

    function setAnchor() {
        if (width >= height)
            anchorToLeft = true
        else
            anchorToLeft = false
    }
    onAnchorToLeftChanged: anchorChangeState.anchorChanged()

    function setColor() {
        controlsRect.color = !parameters.invertTheme ? "white" : "black"
        controlsRect.fontColor = parameters.invertTheme ? "white" : "black"
    }

    Connections {
        target: functionController
        onUpdateFinished: newGraph()
        onNewInputValues: controlsRect.newInputValues(minX, maxX, minY, maxY)
        onMovingPointFinished: stopAudio()
        onError: error()
    }

    StateMachine {
    }
}
