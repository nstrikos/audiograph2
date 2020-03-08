import QtQuick 2.12
import QtQuick.Window 2.12

import QtQml.StateMachine 1.0 as DSM

Item {
    DSM.StateMachine {
        id: stateMachine
        initialState: initialState
        running: true
        DSM.State {
            id: initialState
            DSM.SignalTransition {
                targetState: evaluateState
                signal: window.evaluate
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
                signal: window.evaluate
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
                signal: playPressed
            }
            DSM.SignalTransition {
                targetState: pointState
                signal: explore
            }
            DSM.SignalTransition {
                targetState: pointState
                signal: interestingPoint
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
                signal: window.evaluate
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
                signal: playPressed
            }
            DSM.SignalTransition {
                targetState: pointState
                signal: explore
            }
            DSM.SignalTransition {
                targetState: pointState
                signal: interestingPoint
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
                functionController.firstPoint()
            }
        }
        DSM.State {
            id: pointState
            DSM.SignalTransition {
                targetState: evaluateState
                signal: evaluate
            }
            DSM.SignalTransition {
                targetState: playSoundState
                signal: playPressed
            }
            DSM.SignalTransition {
                targetState: exploreState
                signal: explore
            }
            DSM.SignalTransition {
                targetState: interestingPointState
                signal: interestingPoint
            }
            onEntered: {
                console.log("point state")
                functionController.stopAudio()
                functionController.firstPoint()
            }
        }
        DSM.State {
            id: exploreState
            DSM.SignalTransition {
                targetState: evaluateState
                signal: evaluate
            }
            DSM.SignalTransition {
                targetState: playSoundState
                signal: playPressed
            }
            DSM.SignalTransition {
                targetState: interestingPointState
                signal: interestingPoint
            }
            onEntered: {
                console.log("explore state")
                functionController.stopAudio()
            }
        }
        DSM.State {
            id: interestingPointState
            DSM.SignalTransition {
                targetState: evaluateState
                signal: evaluate
            }
            DSM.SignalTransition {
                targetState: playSoundState
                signal: playPressed
            }
            DSM.SignalTransition {
                targetState: exploreState
                signal: explore
            }
            onEntered: {
                console.log("interesting point state")
                functionController.stopAudio()
            }
        }
    }
}