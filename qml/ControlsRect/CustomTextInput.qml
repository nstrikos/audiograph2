import QtQuick 2.12
import QtQuick.Controls 2.12

import "../BeautityRect"

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
            evaluate()//calculate()
    }
    Accessible.name: qsTr("Set minimum x")
}
