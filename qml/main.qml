import QtQuick 2.12
import QtQuick.Window 2.12

import QtQml.StateMachine 1.0 as DSM

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

    signal newGraph()
    signal error()
    signal stopAudio()

    Item {
        anchors.fill: parent
        focus: true
        Keys.onPressed: {
            if (event.key === Qt.Key_F2) {
                startSoundButtonClicked()
                event.accepted = true;
            } else if (event.key === Qt.Key_F11) {
                graphRect.decStep()
            } else if (event.key === Qt.Key_F12) {
                graphRect.incStep()
            } else if (event.key === Qt.Key_F7) {
                graphRect.moveBackward()
            } else if (event.key === Qt.Key_F8) {
                graphRect.moveForward()
            } else if (event.key === Qt.Key_F9) {
                graphRect.previousPoint()
            } else if (event.key === Qt.Key_F10) {
                graphRect.nextPoint()
            } else if (event.key === Qt.Key_F4) {
                graphRect.sayXCoordinate()
            } else if (event.key === Qt.Key_F5) {
                graphRect.sayYCoordinate()
            }
        }
    }

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

    function setAnchor() {
        controlsRect.stopAudio()
        if (width >= height)
            anchorToLeft = true
        else
            anchorToLeft = false
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
    onAnchorToLeftChanged: anchorChangeState.anchorChanged()

    function setColor() {
        controlsRect.color = !parameters.invertTheme ? "white" : "black"
        controlsRect.fontColor = parameters.invertTheme ? "white" : "black"
    }

    Connections {
        target: functionController
        onUpdateFinished: {
            newGraph()
        }
        onNewInputValues: {
            controlsRect.newInputValues(minX, maxX, minY, maxY)
        }
        onMovingPointFinished: {
            stopAudio()
        }
        onError: error()
    }

    //    Connections {
    //        target: graphRect.curveMovingPoint
    //        onFinished: controlsRect.stopAudio()
    //    }

    DSM.StateMachine {
        id: stateMachine
        initialState: initialState
        running: true
        DSM.State {
            id: initialState
            DSM.SignalTransition {
                targetState: evaluateState
                signal: controlsRect.evaluate
            }
            onEntered: {
                console.log("initial state")
                controlsRect.startSoundButton.enabled = false
            }
        }
        DSM.State {
            id: evaluateState
            DSM.SignalTransition {
                targetState: initialState
                signal: error
            }
            DSM.SignalTransition {
                targetState: graphReadyState
                signal: newGraph
            }
            onEntered: {
                console.log("evaluate state")
                functionController.displayFunction(controlsRect.textInput.text,
                                                   controlsRect.textInput2.text,
                                                   controlsRect.textInput3.text,
                                                   controlsRect.textInput4.text,
                                                   controlsRect.textInput5.text)
                controlsRect.startSoundButton.enabled = false
            }
        }
        DSM.State {
            id: graphReadyState
            DSM.SignalTransition {
                targetState: evaluateState
                signal: controlsRect.evaluate
            }
            DSM.SignalTransition {
                targetState: initialState
                signal: error
            }
            DSM.SignalTransition {
                targetState: graphReadyState
                signal: newGraph
            }
            DSM.SignalTransition {
                targetState: playSoundState
                signal: controlsRect.startSoundButton.clicked
            }
            onEntered: {
                console.log("graph ready state")
                controlsRect.startSoundButton.enabled = true
                controlsRect.startSoundButton.text = qsTr("Start sound")
                graphRect.updateCanvas()
            }
        }

        DSM.State {
            id: playSoundState
            DSM.SignalTransition {
                targetState: evaluateState
                signal: controlsRect.evaluate
            }
            DSM.SignalTransition {
                targetState: initialState
                signal: error
            }
            DSM.SignalTransition {
                targetState: graphReadyState
                signal: stopAudio
            }
            DSM.SignalTransition {
                targetState: graphReadyState
                signal: controlsRect.startSoundButton.clicked
            }
            onEntered: {
                console.log("play sound state")
                controlsRect.startSoundButton.enabled = true
                controlsRect.startSoundButton.text = qsTr("Stop sound")
                functionController.audio()
            }
            onExited: {
                controlsRect.startSoundButton.text = qsTr("Start sound")
                functionController.stopAudio()
            }
        }
    }
}
