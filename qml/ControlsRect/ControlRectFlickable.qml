import QtQuick 2.12
import QtQuick.Controls 2.12

import "../BeautityRect"

Flickable {
    id: controlRectFlickable
    width: parent.width
    anchors.top: controlsTitleBar.bottom
    anchors.topMargin: 40
    anchors.bottom: parent.bottom
    contentHeight: 500
    clip: true

    property alias textInput: textInput
    property alias textInput2: textInput2
    property alias textInput3: textInput3
    property alias textInput4: textInput4
    property alias textInput5: textInput5
    property alias startSoundButton: startButtonFocusScope.startSoundButton
    
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
        
        CustomTextInput {
            id: textInput
            anchors.left: label1.right
            anchors.verticalCenter: label1.verticalCenter
            placeholderText: (parent.width > 0) ? "Function expression" : ""
            onFocusChanged: ensureVisible(textInput)
            Accessible.name: qsTr("Function expression")
            onTextChanged: {
                controlsRect.active = false
                textInput2.text = "-10"
                textInput3.text = "10"
                textInput4.text = "-10"
                textInput5.text = "10"
                window.evaluate()
                controlsRect.active = true
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
            color: fontColor
        }
        
        CustomTextInput {
            id: textInput2
            onTextChanged: {
                if (controlsRect.active)
                    evaluate()
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
            color: fontColor
        }
        
        CustomTextInput {
            id: textInput3
            anchors.left: label3.right
            anchors.verticalCenter: label3.verticalCenter
            placeholderText: (parent.width > 0) ? "maximum X" : ""
            onFocusChanged: ensureVisible(textInput3)
            Accessible.name: qsTr("Set maximum x")
            onTextChanged: {
                if (controlsRect.active)
                    evaluate()
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
            color: fontColor
        }
        
        CustomTextInput {
            id: textInput4
            anchors.left: label4.right
            anchors.verticalCenter: label4.verticalCenter
            placeholderText: (parent.width > 0) ? "minimum Y" : ""
            onFocusChanged: ensureVisible(textInput4)
            Accessible.name: qsTr("Set minimum Y")
            onTextChanged: {
                if (controlsRect.active)
                    evaluate()
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
            color: fontColor
        }
        
        CustomTextInput {
            id: textInput5
            anchors.left: label5.right
            anchors.verticalCenter: label5.verticalCenter
            placeholderText: (parent.width > 0) ? "maximum Y" : ""
            onFocusChanged: ensureVisible(textInput5)
            Accessible.name: qsTr("Set maximum Y")
            onTextChanged: {
                if (controlsRect.active)
                    evaluate()
            }
        }
        
        StartButtonFocusScope {
            id: startButtonFocusScope
        }
    }
}
