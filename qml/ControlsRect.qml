import QtQuick 2.12
import QtQuick.Controls 2.12

Rectangle {
    id: controlsRect
    anchors.rightMargin: window.width / 4

    property bool active: true
    color : !parameters.invertTheme ? "white" : "black"
    property color fontColor: parameters.invertTheme ? "white" : "black"
    property color bgColor: !parameters.invertTheme ? "white" : "black"
    property color lightColor: parameters.invertTheme ? "yellow" : "blue"
    property bool invertTheme: parameters.invertTheme

    property alias startSoundButton: startSoundButton

    onInvertThemeChanged: {
        fontColor: parameters.invertTheme ? "white" : "black"
        bgColor = !parameters.invertTheme ? "white" : "black"
        lightColor = parameters.invertTheme ? "yellow" : "blue"
    }



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
        } // else if (event.key === Qt.Key_Control) {
        //            pointsInterest.previousPoint()
        //        } else if (event.key === Qt.Key_Alt) {
        //            pointsInterest.nextPoint()
        //        }
    }

    ControlsTitleBar {
        id: controlsTitleBar
    }

    Flickable {
        id: flickable
        width: parent.width
        anchors.top: controlsTitleBar.bottom
        anchors.topMargin: 40
        anchors.bottom: parent.bottom
        contentHeight: 500
        clip: true

        onContentYChanged: {
            ensureVisible(textInput)
            ensureVisible(textInput2)
            ensureVisible(textInput3)
            ensureVisible(textInput4)
            ensureVisible(textInput5)
        }

        function ensureVisible(item) {
            var ypos = item.mapToItem(contentItem, 0, 0).y
            var ext = item.height + ypos
            if ( ypos < contentY // begins before
                    || ypos > contentY + height // begins after
                    || ext < contentY // ends before
                    || ext > contentY + height) { // ends after
                //            // don't exceed bounds
                //            //contentY = Math.max(0, Math.min(ypos - height + item.height, contentHeight - height))
                console.log(item.id, "not visible")
                item.enabled = false
            } else {
                console.log(item.id, "visible")
                item.enabled = true
            }
        }

        Item {
            id: controlsMainRect
            width: parent.width
            anchors.topMargin: 20
            anchors.top: parent.top

            Label {
                id: label1
                text: (parent.width > 0) ? "f(x) : " : ""
                anchors.left: parent.left
                anchors.leftMargin: 5
                width: 50
                color: fontColor
            }

            TextField {
                id: textInput
                anchors.left: label1.right
                anchors.leftMargin: 10
                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.verticalCenter: label1.verticalCenter
                placeholderText: (parent.width > 0) ? "Function expression" : ""
                height: 50
                selectByMouse: true
                color: fontColor

                background: Rectangle {
                    id: backRect
                    color: controlsRect.color
                    border.color: {
                        if (textInput.activeFocus) {
                            if (invertTheme)
                                return "yellow"
                            else
                                return "blue"
                        } else {
                            return "light gray"
                        }
                    }
                    border.width: textInput.activeFocus ? 2 : 1
                }

                onTextChanged: {
                    textInput2.text = "-10"
                    textInput3.text = "10"
                    textInput4.text = "-10"
                    textInput5.text = "10"
                    calculate()
                }
                Accessible.name: qsTr("Set expression")
            }

            Label {
                id: label2
                text: (parent.width > 0) ? "min X : " : ""
                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.top: textInput.bottom
                anchors.topMargin: 40
                width: 50
                color: fontColor
            }

            TextField {
                id: textInput2
                anchors.left: label2.right
                anchors.leftMargin: 10
                anchors.verticalCenter: label2.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 10
                placeholderText: (parent.width > 0) ? "minimum X" : ""
                height: 50
                selectByMouse: true
                onFocusChanged: ensureVisible(textInput2)
                color: fontColor
                background: Rectangle {
                    id: backRect2
                    color: controlsRect.color
                    border.color: {
                        if (textInput2.activeFocus) {
                            if (invertTheme)
                                return "yellow"
                            else
                                return "blue"
                        } else {
                            return "light gray"
                        }
                    }
                    border.width: textInput2.activeFocus ? 2 : 1
                }
                onTextChanged: {
                    if (active)
                        calculate()
                }
                Accessible.name: qsTr("Set minimum x")
            }

            Label {
                id: label3
                text: (parent.width > 0) ? "max X : " : ""
                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.top: textInput2.bottom
                anchors.topMargin: 40
                width: 50
                color: fontColor
            }

            TextField {
                id: textInput3
                anchors.left: label3.right
                anchors.leftMargin: 10
                anchors.verticalCenter: label3.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 10
                placeholderText: (parent.width > 0) ? "maximum X" : ""
                height: 50
                selectByMouse: true
                onFocusChanged: ensureVisible(textInput3)
                color: fontColor
                background: Rectangle {
                    id: backRect3
                    color: controlsRect.color
                    border.color: {
                        if (textInput3.activeFocus) {
                            if (invertTheme)
                                return "yellow"
                            else
                                return "blue"
                        } else {
                            return "light gray"
                        }
                    }
                    border.width: textInput3.activeFocus ? 2 : 1
                }
                onTextChanged: {
                    if (active)
                        calculate()
                }
                Accessible.name: qsTr("Set maximum x")
            }

            Label {
                id: label4
                text: (parent.width > 0) ? "min Y : " : ""
                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.top: textInput3.bottom
                anchors.topMargin: 40
                width: 50
                color: fontColor
            }

            TextField {
                id: textInput4
                anchors.left: label4.right
                anchors.leftMargin: 10
                anchors.verticalCenter: label4.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 10
                placeholderText: (parent.width > 0) ? "minimum Y" : ""
                height: 50
                selectByMouse: true
                onFocusChanged: ensureVisible(textInput4)
                color: fontColor
                background: Rectangle {
                    id: backRect4
                    color: controlsRect.color
                    border.color: {
                        if (textInput4.activeFocus) {
                            if (invertTheme)
                                return "yellow"
                            else
                                return "blue"
                        } else {
                            return "light gray"
                        }
                    }
                    border.width: textInput4.activeFocus ? 2 : 1
                }
                onTextChanged: {
                    if (active)
                        calculate()
                }
                Accessible.name: qsTr("Set minimum Y")
            }

            Label {
                id: label5
                text: (parent.width > 0) ? "max Y : " : ""
                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.top: textInput4.bottom
                anchors.topMargin: 40
                width: 50
                color: fontColor
            }

            TextField {
                id: textInput5
                anchors.left: label5.right
                anchors.leftMargin: 10
                anchors.verticalCenter: label5.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 10
                placeholderText: (parent.width > 0) ? "maximum Y" : ""
                height: 50
                selectByMouse: true
                onFocusChanged: ensureVisible(textInput5)
                color: fontColor
                background: Rectangle {
                    id: backRect5
                    color: controlsRect.color
                    border.color: {
                        if (textInput5.activeFocus) {
                            if (invertTheme)
                                return "yellow"
                            else
                                return "blue"
                        } else {
                            return "light gray"
                        }
                    }
                    border.width: textInput5.activeFocus ? 2 : 1
                }
                onTextChanged: {
                    if (active)
                        calculate()
                }
                Accessible.name: qsTr("Set maximum Y")
            }

            FocusScope {
                id: startButtonFocusScope
                height: 50
                anchors.top: label5.bottom
                anchors.topMargin: 50
                anchors.left: label5.right
                anchors.leftMargin: 10
                anchors.right: parent.right
                anchors.rightMargin: 10
                activeFocusOnTab: true
                Accessible.name: qsTr("Start sound button")
                Keys.onSpacePressed: startSoundButton.checked = ! startSoundButton.checked
                Keys.onEnterPressed: startSoundButton.checked = ! startSoundButton.checked
                Keys.onReturnPressed: startSoundButton.checked = ! startSoundButton.checked

                Rectangle {
                    id: startSoundButton
                    anchors.fill: parent
                    color: bgColor
                    border.color: startButtonFocusScope.activeFocus ? lightColor : "light gray"
                    border.width: startButtonFocusScope.activeFocus ? 2 : 1
                    property bool checked: true
                    Text {
                        text: startSoundButton.checked ? qsTr("Start sound") : qsTr("Stop sound")
                        anchors.centerIn: parent
                        font.pointSize: 16
                        color: fontColor
                    }

                    MouseArea {
                        anchors.fill: parent
                        onPressed: {
                            startSoundButtonClicked()
                        }
                    }
                    onCheckedChanged: {
                        //parameters.showAxes = checked
                        //graphRect.graphCanvas.updateCanvas()
                    }
                }
            }
        }
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

    //    function startPinch() {
    //        stopAudio()
    //        functionController.startPinch()
    //    }

    //    function handlePinch(scale) {
    //        functionController.pinch(scale)
    //    }

    //    function pinchFinished() {
    //        if (textInput.text !== "") {
    //            active = true
    //        }
    //    }

    function calculate () {
        stopAudio()
        functionController.displayFunction(textInput.text,
                                           textInput2.text,
                                           textInput3.text,
                                           textInput4.text,
                                           textInput5.text)
    }

    function startSoundButtonClicked() {
        if (startSoundButton.checked)
            startAudio()
        else
            stopAudio()
    }

    function startAudio() {
        if (functionController.validExpression()) {
            functionController.audio()
            startSoundButton.checked = false
        }

    }

    function stopAudio() {
        functionController.stopAudio()
        graphRect.stopMovingPoint()
        startSoundButton.checked = true
    }
}
