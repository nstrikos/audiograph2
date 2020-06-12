import QtQuick 2.12
import QtQuick.Controls 2.12

FocusScope {
    id: focus9
    anchors.left: startButtonFocusScope.left
    anchors.top: focus7.bottom
    anchors.topMargin: 15
    height: 50
    anchors.right: startButtonFocusScope.horizontalCenter
    anchors.rightMargin: 15
    
    activeFocusOnTab: true
    Accessible.name: qsTr("Previous point sound only")
    
    Rectangle {
        id: rect9
        anchors.fill: parent
        color: bgColor
        border.color: focus9.activeFocus ? lightColor : "light gray"
        border.width: focus9.activeFocus ? 2 : 1
        property bool checked: true
        property var text: "Previous point\n sound only"
        
        signal clicked()
        
        Text {
            id: text
            text: rect9.text
            anchors.centerIn: parent
            font.pointSize: 12
            color: fontColor
        }
        
        MouseArea {
            anchors.fill: parent
            onPressed: {
                window.explore()
                functionController.previousPoint()
            }
        }
    }
}
