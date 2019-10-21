import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Styles.Flat 1.0 as Flat


Rectangle {
    id: controlsRect
    anchors.rightMargin: window.width / 4

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
//                onTextChanged: {
//                    expression = text
//                    textInput2.text = "-10"
//                    textInput3.text = "10"
//                    textInput4.text = "-5"
//                    textInput5.text = "5"
//                    textInput6.text = "1"
//                    calculate()
//                }
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
//                onTextChanged: {
//                    if (active)
//                        calculate()
//                }
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
//                onTextChanged: {
////                    maxX = text
//                    if (active)
//                        calculate()
//                }
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
//                onTextChanged: {
//                    if (active)
//                        calculate()
//                }
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
//                onTextChanged: {
//                    if (active)
//                        calculate()
//                }
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
}
