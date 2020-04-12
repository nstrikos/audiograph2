import QtQuick 2.12
import QtQuick.Window 2.12
import Qt.labs.settings 1.1

import QtQml.StateMachine 1.0 as DSM

import "ControlsRect"
import "GraphRect"
import "SettingsRect"

Connections {
    target: functionController
    onUpdateFinished: newGraph()
    onNewInputValues: controlsRect.newInputValues(minX, maxX, minY, maxY)
    onMovingPointFinished: stopAudio()
    onError: error()
}
