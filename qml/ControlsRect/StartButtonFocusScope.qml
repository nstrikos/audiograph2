import QtQuick 2.12
import QtQuick.Controls 2.12

FocusScope {
    id: startButtonFocusScope

    property alias startSoundButton: startSoundButton

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
        property var text: "Start sound"
        enabled: false
        
        signal clicked()
        
        Text {
            id: text
            text: startSoundButton.text
            anchors.centerIn: parent
            font.pointSize: 16
            color: fontColor
        }
        
        MouseArea {
            anchors.fill: parent
            onPressed: {
                window.playPressed()
            }
        }
    }
}