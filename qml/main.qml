import QtQuick 2.12
import QtQuick.Window 2.12

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

//    property bool anchorToLeft: undefined

    Item {
        id: myItem
        states: [
            State {
                name: "state1"
                AnchorChanges {
                    target: controlsRect
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.right: parent.horizontalCenter
                }
                AnchorChanges {
                    target: graphRect
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.left: controlsRect.right//parent.horizontalCenter//controlsRect.right
                    anchors.right: parent.right
                }
                AnchorChanges {
                    target: settingsRect
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.left: parent.right
                    anchors.right: parent.right
                }

                AnchorChanges {
                    target: controlsButton
                    anchors.top: parent.top
                    anchors.right: parent.horizontalCenter
                }

                AnchorChanges {
                    target: settingsButton
                    anchors.top: parent.top
                    anchors.right: graphRect.right
                }

                PropertyChanges {
                    target: controlsRect
                    anchors.rightMargin: window.width / 4
                }

                PropertyChanges {
                    target: settingsRect
                    anchors.leftMargin: 0
                }

                //                PropertyChanges {
                //                    target: settingsRect
                //                    width: 0
                //                }
                //                PropertyChanges {
                //                    target: controlsRect
                //                    width: window.width / 3
                //                }
                //                PropertyChanges {
                //                    target: graphRect
                //                    width: window.width * 2/3
                //                }
            },
            State {
                name: "state2"

                AnchorChanges {
                    target: controlsRect
                    anchors.left: parent.left
                    anchors.right: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                }

                AnchorChanges {
                    target: graphRect
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                }

                AnchorChanges {
                    target: settingsRect
                    anchors.left: parent.right
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                }

                AnchorChanges {
                    target: controlsButton
                    anchors.left: graphRect.left
                    anchors.top: parent.top
                }

                AnchorChanges {
                    target: settingsButton
                    anchors.right: graphRect.right
                    anchors.top: parent.top
                }

                PropertyChanges {
                    target: controlsRect
                    anchors.rightMargin: 0
                }

                PropertyChanges {
                    target: settingsRect
                    anchors.leftMargin: 0
                }
            },
            State {
                name: "state3"

                AnchorChanges {
                    target: controlsRect
                    anchors.left: parent.left
                    anchors.right: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                }

                //                PropertyChanges {
                //                    target: graphRect
                //                    width: window.width * 2 / 3
                //                }

                AnchorChanges {
                    target: settingsRect
                    anchors.left: parent.horizontalCenter//graphRect.right
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                }

                AnchorChanges {
                    target: controlsButton
                    anchors.left: graphRect.left
                    anchors.top: parent.top
                }

                AnchorChanges {
                    target: settingsButton
                    //anchors.right: graphRect.right
                    anchors.left: parent.horizontalCenter
                    anchors.top: parent.top
                }

                PropertyChanges {
                    target: controlsRect
                    anchors.rightMargin: 0
                }

                AnchorChanges {
                    target: graphRect
                    anchors.left: parent.left
                    anchors.right: settingsRect.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    //                    anchors.right: parent.horizontalCenter
                }
            },
            State {
                name: "state4"

                AnchorChanges {
                    target: graphRect
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.verticalCenter
                }

                AnchorChanges {
                    target: controlsRect
                    anchors.top: graphRect.bottom
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                }

                AnchorChanges {
                    target: settingsRect
                    anchors.top: parent.top
                    anchors.bottom: graphRect.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                }

                PropertyChanges {
                    target: settingsRect
                    height: 0
                }

                PropertyChanges {
                    target: controlsRect
                    anchors.rightMargin: 0
                }

                PropertyChanges {
                    target: controlsButton
                    anchors.rightMargin: 0
                }

                PropertyChanges {
                    target: settingsRect
                    anchors.leftMargin: 0
                }

                AnchorChanges {
                    target: controlsButton
                    anchors.bottom: graphRect.bottom
                    anchors.right: graphRect.right
                }

                AnchorChanges {
                    target: settingsButton
                    anchors.top: graphRect.top
                    anchors.right: graphRect.right
                }
            },
            State {
                name: "state5"

                AnchorChanges {
                    target: graphRect
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                }

                AnchorChanges {
                    target: controlsRect
                    anchors.top: graphRect.bottom
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                }

                AnchorChanges {
                    target: settingsRect
                    anchors.top: parent.top
                    anchors.bottom: graphRect.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                }

                PropertyChanges {
                    target: settingsRect
                    height: 0
                }

                PropertyChanges {
                    target: controlsRect
                    anchors.rightMargin: 0
                }

                PropertyChanges {
                    target: controlsButton
                    anchors.rightMargin: 0
                }

                PropertyChanges {
                    target: settingsRect
                    anchors.leftMargin: 0
                }

                AnchorChanges {
                    target: controlsButton
                    anchors.bottom: graphRect.bottom
                    anchors.right: graphRect.right
                }

                AnchorChanges {
                    target: settingsButton
                    anchors.top: graphRect.top
                    anchors.right: graphRect.right
                }
            },
            State {
                name: "state6"

                AnchorChanges {
                    target: settingsRect
                    anchors.top: parent.top
                    anchors.bottom: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.right: parent.right
                }

                AnchorChanges {
                    target: graphRect
                    anchors.top: settingsRect.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                }

                AnchorChanges {
                    target: controlsRect
                    anchors.top: graphRect.bottom
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                }

                AnchorChanges {
                    target: controlsButton
                    anchors.bottom: graphRect.bottom
                    anchors.right: graphRect.right
                }

                AnchorChanges {
                    target: settingsButton
                    anchors.top: graphRect.top
                    anchors.right: graphRect.right
                }

                AnchorChanges {
                    target: modeButton
                    anchors.top: graphRect.top
                    anchors.right: settingsButton.left
                }

                AnchorChanges {
                    target: modeButton2
                    anchors.top: graphRect.top
                    anchors.right: modeButton.left
                }

                AnchorChanges {
                    target: modeButton3
                    anchors.top: graphRect.top
                    anchors.right: modeButton2.left
                }

                PropertyChanges {
                    target: controlsRect
                    anchors.rightMargin: 0
                }

                PropertyChanges {
                    target: controlsButton
                    anchors.rightMargin: 0
                }

                PropertyChanges {
                    target: settingsRect
                    anchors.leftMargin: 0
                }
            }
        ]
    }

    property bool anchorToLeft: undefined

    onAnchorToLeftChanged: {
        //        clearAnchors()
        if (anchorToLeft == false) {
            if (myItem.state == 'state1')
                myItem.state = 'state4'
            else if (myItem.state == 'state2')
                myItem.state = 'state5'
            else if (myItem.state == 'state3')
                myItem.state = 'state6'
        } else if (anchorToLeft == true) {
            if (myItem.state == 'state4')
                myItem.state = 'state1'
            else if (myItem.state == 'state5')
                myItem.state = 'state2'
            else if (myItem.state == 'state6')
                myItem.state = 'state3'
        }
    }

    onWidthChanged: setAnchor()
    onHeightChanged: setAnchor()

//    function setAnchor() {

//        if (width >= height)
//            anchorToLeft = true
//        else
//            anchorToLeft = false
//    }

    function clearAnchors() {
        controlsRect.anchors.top = undefined
        controlsRect.anchors.bottom = undefined
        controlsRect.anchors.left = undefined
        controlsRect.anchors.right = undefined
        graphRect.anchors.top = undefined
        graphRect.anchors.bottom = undefined
        graphRect.anchors.left = undefined
        graphRect.anchors.right = undefined
        settingsRect.anchors.top = undefined
        settingsRect.anchors.bottom = undefined
        settingsRect.anchors.left = undefined
        settingsRect.anchors.right = undefined
        controlsButton.anchors.top = undefined
        controlsButton.anchors.bottom = undefined
        controlsButton.anchors.left = undefined
        controlsButton.anchors.right = undefined
        settingsButton.anchors.top = undefined
        settingsButton.anchors.bottom = undefined
        settingsButton.anchors.left = undefined
        settingsButton.anchors.right = undefined
    }

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

//    AnchorChangeState {
//        id: anchorChangeState
//    }

    function setAnchor() {
        controlsRect.stopAudio()
        if (width >= height)
            anchorToLeft = true
        else
            anchorToLeft = false
    }

//    Component.onCompleted: {
//        setAnchor()
//        if (anchorToLeft)
//            anchorChangeState.state = 'state1'
//        else
//            anchorChangeState.state = 'state4'
//    }

    Component.onCompleted: {
        setAnchor()
        if (anchorToLeft)
            myItem.state = 'state1'
        else
            myItem.state = 'state4'
    }

//    onWidthChanged: setAnchor()
//    onHeightChanged: setAnchor()
//    onAnchorToLeftChanged: anchorChangeState.anchorChanged()

    GraphParameters {
        id: graphParameters
    }

    function setColor() {
        controlsRect.color = !parameters.invertTheme ? "white" : "black"
        controlsRect.fontColor = parameters.invertTheme ? "white" : "black"
    }

    Connections {
        target: functionController
        onUpdateFinished: {
            //We need graphParameters for displaying the grid
            //console.log("Update function: ", myfunction.expression())
            //            graphParameters.minX = functionController.minX();
            //            graphParameters.maxX = functionController.maxX();
            //            graphParameters.minY = functionController.minY();
            //            graphParameters.maxY = functionController.maxY();
            graphRect.updateCanvas()
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
    }

    Connections {
        target: graphRect.curveMovingPoint
        onFinished: controlsRect.stopAudio()
    }
}
