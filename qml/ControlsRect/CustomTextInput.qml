import QtQuick 2.12
import QtQuick.Controls 2.12

import "../BeautityRect"

TextField {
    id: root
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
            if (root.activeFocus) {
                if (invertTheme)
                    return "yellow"
                else
                    return "blue"
            } else {
                return "light gray"
            }
        }
        border.width: root.activeFocus ? 2 : 1
    }    
    
    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.RightButton
        hoverEnabled: true
        
        property int selectStart
        property int selectEnd
        property int curPos
        
        onClicked: {
            selectStart = root.selectionStart;
            selectEnd = root.selectionEnd;
            curPos = root.cursorPosition;
            contextMenu.x = mouse.x;
            contextMenu.y = mouse.y;
            contextMenu.open();
            root.cursorPosition = curPos;
            root.select(selectStart,selectEnd);
        }
        onPressAndHold: {
            if (mouse.source === Qt.MouseEventNotSynthesized) {
                selectStart = root.selectionStart;
                selectEnd = root.selectionEnd;
                curPos = root.cursorPosition;
                contextMenu.x = mouse.x;
                contextMenu.y = mouse.y;
                contextMenu.open();
                root.cursorPosition = curPos;
                root.select(selectStart,selectEnd);
            }
        }
        
        onEntered: cursorShape = Qt.IBeamCursor
        
        Menu {
            id: contextMenu
            MenuItem {
                text: "Cut"
                onTriggered: {
                    root.cut()
                }
            }
            MenuItem {
                text: "Copy"
                onTriggered: {
                    root.copy()
                }
            }
            MenuItem {
                text: "Paste"
                onTriggered: {
                    root.paste()
                }
            }
        }
    }
    
    onTextChanged: {
        active = false
        textInput2.text = "-10"
        textInput3.text = "10"
        textInput4.text = "-10"
        textInput5.text = "10"
        evaluate()
        active = true
    }

    Accessible.name: qsTr("Set expression")
}
