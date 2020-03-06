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
            graphRect.updateCanvas()
            controlsRect.stopAudio()
        }
        //        onError: {
        //            console.log("Error: ", err, myfunction.expression())
        //            graphParameters.minX = -10;
        //            graphParameters.maxX = 10;
        //            graphParameters.minY = -10;
        //            graphParameters.maxY = 10;
        //graphRect.clearCanvas()
        //            graphRect.updateCanvas();
        //        }
        onNewInputValues: {
            controlsRect.newInputValues(minX, maxX, minY, maxY)
        }
        onMovingPointFinished: {
            controlsRect.stopAudio()
        }
    }

    //    Connections {
    //        target: graphRect.curveMovingPoint
    //        onFinished: controlsRect.stopAudio()
    //    }

    DSM.StateMachine {
        id: stateMachine
        initialState: state1
        running: true
        DSM.State {
            id: state1
            DSM.SignalTransition {
                targetState: state2
                signal: controlsRect.startSoundButton.clicked
            }
            DSM.SignalTransition {
                targetState: state2
                signal: controlsRect.f2Pressed
            }
            onEntered: {
                console.log("state1")
                controlsRect.startSoundButton.text = qsTr("Start sound")
            }
        }
        DSM.State {
            id: state2
            DSM.SignalTransition {
                targetState: state1
                signal: controlsRect.startSoundButton.clicked//button.clicked
            }
            DSM.SignalTransition {
                targetState: state1
                signal: controlsRect.f2Pressed
            }
            onEntered: {
                console.log("state2")
                controlsRect.startSoundButton.text = qsTr("Stop sound")
            }
        }
    }
}
