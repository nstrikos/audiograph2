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
        } else if (event.key === Qt.Key_F8) {
            console.log("F8 pressed")
        }
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
                    textInput4.text = "-5"
                    textInput5.text = "5"
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

    function handleZoom(angleDelta) {
        stopAudio()
        if (textInput.text !== "") {
            //First we perform zoom
            //Then we round parameters to display them
            //Displayed parameters do not correspond to
            //actual parameters used to calculate function
            myfunction.zoom(angleDelta)

            var minX = myfunction.minX()
            var maxX = myfunction.maxX()
            var minY = myfunction.minY()
            var maxY = myfunction.maxY()
            var distance = maxX - minX
            var pow = -Math.floor(Math.log10(distance)) + 1
            var ten = Math.pow(10, pow)

            if (pow > 0) {
                minX = minX.toFixed(pow)
                maxX = maxX.toFixed(pow)
            }
            else {
                minX = minX.toFixed(0)
                maxX = maxX.toFixed(0)
            }

            distance = maxY - minY
            pow = -Math.floor(Math.log10(distance)) + 1
            ten = Math.pow(10, pow)
            if (pow > 0) {
                minY = minY.toFixed(pow)
                maxY = maxY.toFixed(pow)
            }
            else {
                minY = minY.toFixed(0)
                maxY = maxY.toFixed(0)
            }

            active = false
            textInput2.text = minX
            textInput3.text = maxX
            textInput4.text = minY
            textInput5.text = maxY
            active = true
        }
    }

    property var minX
    property var maxX
    property var minY
    property var maxY
    property var x0
    property var y0

    function startDrag(x, y) {
        stopAudio()
        if (textInput.text !== "") {
            x0 = x
            y0 = y
            minX = Number(textInput2.text)
            maxX = Number(textInput3.text)
            minY = Number(textInput4.text)
            maxY = Number(textInput5.text)
        }
    }

    function handleDrag(diffX, diffY) {
        if (textInput.text !== "") {
            active = false

            var distanceX = maxX - minX

            var pow = -Math.floor(Math.log10(distanceX)) + 2
            var ten = Math.pow(10, pow)

            diffX = diffX - x0
            diffY = diffY - y0
            diffX = (maxX - minX) / graphRect.width * diffX
            diffY = (maxY - minY) / graphRect.height * diffY

            textInput2.text = Math.round( (minX - diffX) * ten) / ten
            textInput3.text = Math.round( (maxX - diffX) * ten) / ten
            textInput4.text = Math.round( (minY + diffY) * ten) / ten
            textInput5.text = Math.round( (maxY + diffY) * ten) / ten
            calculate()

            active = true
        }
    }

    function startPinch() {
        stopAudio()
        if (textInput.text !== "") {
            minX = Number(textInput2.text)
            maxX = Number(textInput3.text)
            minY = Number(textInput4.text)
            maxY = Number(textInput5.text)
            active = false
        }
    }

    function handlePinch(scale) {
        if (textInput.text !== "") {
            scale = 1 / scale

            var distanceX = maxX - minX
            var centerX = (maxX + minX) / 2

            var pow = -Math.floor(Math.log10(distanceX)) + 2
            var ten = Math.pow(10, pow)

            var distanceY = maxY - minY
            var centerY = (maxY + minY) / 2


            distanceX = distanceX * scale
            distanceY = distanceY * scale

            var n_minX = centerX - distanceX / 2
            var n_maxX = centerX + distanceX / 2
            var n_minY = centerY - distanceY / 2
            var n_maxY = centerY + distanceY / 2

            active = false

            myfunction.calculate(textInput.text,
                                 n_minX,
                                 n_maxX,
                                 n_minY,
                                 n_maxY,
                                 graphRect.width,
                                 graphRect.height)

            textInput2.text = Math.round(n_minX * ten) / ten
            textInput3.text = Math.round(n_maxX * ten) / ten
            textInput4.text = Math.round(n_minY * ten) / ten
            textInput5.text = Math.round(n_maxY * ten) / ten
        }
    }

    function pinchFinished() {
        if (textInput.text !== "") {
            active = true
        }
    }

    function calculate () {
        stopAudio()
        myfunction.calculate(textInput.text,
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
        if (myfunction.validExpression()) {
            if (parameters.useNotes) {
                audioNotes.startNotes(myfunction,
                                      parameters.minFreq,
                                      parameters.maxFreq,
                                      parameters.duration)
            } else {
                audio.start(textInput.text,
                            textInput2.text,
                            textInput3.text,
                            textInput4.text,
                            textInput5.text,
                            parameters.duration,
                            parameters.minFreq,
                            parameters.maxFreq)
            }

            graphRect.startMovingPoint()
            startSoundButton.checked = false
        }
    }

    function stopAudio() {
        audio.stop()
        audioNotes.stopNotes()
        graphRect.stopMovingPoint()
        startSoundButton.checked = true
    }
}
