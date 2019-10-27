import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Rectangle {
    id: controlsRect
    anchors.rightMargin: window.width / 4

    property bool active: true

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

        Item {
            id: controlsMainRect
            width: parent.width

            Label {
                id: label1
                text: (parent.width > 0) ? "f(x) : " : ""
                anchors.left: parent.left
                anchors.leftMargin: 5
                width: 50
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
                onTextChanged: {
                    //                    expression = text
                    textInput2.text = "-10"
                    textInput3.text = "10"
                    textInput4.text = "-5"
                    textInput5.text = "5"
                    calculate()
                }
            }

            Label {
                id: label2
                text: (parent.width > 0) ? "min X : " : ""
                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.top: textInput.bottom
                anchors.topMargin: 40
                width: 50
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
                //                property bool active: true
                onTextChanged: {
                    if (active)
                        calculate()
                }
            }

            Label {
                id: label3
                text: (parent.width > 0) ? "max X : " : ""
                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.top: textInput2.bottom
                anchors.topMargin: 40
                width: 50
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
                //                property bool active: true
                onTextChanged: {
                    ////                    maxX = text
                    if (active)
                        calculate()
                }
            }

            Label {
                id: label4
                text: (parent.width > 0) ? "min Y : " : ""
                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.top: textInput3.bottom
                anchors.topMargin: 40
                width: 50
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
                //                property bool active: true
                onTextChanged: {
                    if (active)
                        calculate()
                }
            }

            Label {
                id: label5
                text: (parent.width > 0) ? "max Y : " : ""
                anchors.left: parent.left
                anchors.leftMargin: 5
                anchors.top: textInput4.bottom
                anchors.topMargin: 40
                width: 50
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
                //                property bool active: true
                onTextChanged: {
                    if (active)
                        calculate()
                }
            }

            //            Label {
            //                id: label6
            //                text: (parent.width > 0) ? "Points : " : ""
            //                anchors.left: parent.left
            //                anchors.leftMargin: 5
            //                anchors.top: textInput5.bottom
            //                anchors.topMargin: 40
            //                width: 50
            //            }

            //            TextField {
            //                id: textInput6
            //                anchors.left: label4.right
            //                anchors.leftMargin: 10
            //                anchors.verticalCenter: label6.verticalCenter
            //                anchors.right: parent.right
            //                anchors.rightMargin: 10
            //                placeholderText: (parent.width > 0) ? "number of points" : ""
            //                height: 50
            //                selectByMouse: true
            ////                onTextChanged: calculate()
            ////                KeyNavigation.tab: graphRect
            //            }
        }
    }

    BeautifyRect {
    }

    function handleZoom(angleDelta) {
        var minX = Number(textInput2.text)
        var maxX = Number(textInput3.text)
        var minY = Number(textInput4.text)
        var maxY = Number(textInput5.text)

        var distanceX = maxX - minX
        var centerX = (maxX + minX) / 2

        var pow = -Math.floor(Math.log10(distanceX)) + 1
        var ten = Math.pow(10, pow)

        var distanceY = maxY - minY
        var centerY = (maxY + minY) / 2

        if (angleDelta < 0) {
            distanceX = distanceX * 1.1
            distanceY = distanceY * 1.1
        } else {
            distanceX = distanceX * 0.9
            distanceY = distanceY * 0.9
        }

        minX = centerX - distanceX / 2
        maxX = centerX + distanceX / 2
        minY = centerY - distanceY / 2
        maxY = centerY + distanceY / 2

        minX = Math.round(minX * ten) / ten
        maxX = Math.round(maxX * ten) / ten
        minY = Math.round(minY * ten) / ten
        maxY = Math.round(maxY * ten) / ten

        active = false

        textInput2.text = minX
        textInput3.text = maxX
        textInput4.text = minY
        textInput5.text = maxY
        calculate()

        active = true
    }

    property var minX
    property var maxX
    property var minY
    property var maxY
    property var x0
    property var y0

    function startDrag(x, y) {
        x0 = x
        y0 = y
        minX = Number(textInput2.text)
        maxX = Number(textInput3.text)
        minY = Number(textInput4.text)
        maxY = Number(textInput5.text)
    }

    function handleDrag(diffX, diffY) {
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

    function startPinch() {
        minX = Number(textInput2.text)
        maxX = Number(textInput3.text)
        minY = Number(textInput4.text)
        maxY = Number(textInput5.text)
        active = false
    }

    function handlePinch(scale) {
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

        textInput2.text = Math.round(n_minX * ten) / ten
        textInput3.text = Math.round(n_maxX * ten) / ten
        textInput4.text = Math.round(n_minY * ten) / ten
        textInput5.text = Math.round(n_maxY * ten) / ten
        calculate()
    }

    function pinchFinished() {
        active = true
    }

    function calculate () {
        myfunction.calculate(textInput.text,
                             textInput2.text,
                             textInput3.text,
                             textInput4.text,
                             textInput5.text,
                             graphRect.width,
                             graphRect.height)
    }
}
