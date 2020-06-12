import QtQuick 2.12
import QtQuick.Controls 2.12

FocusScope {
    id: focus5
    anchors.left: startButtonFocusScope.left
    anchors.top: focus3.bottom
    anchors.topMargin: 15
    height: 50
    anchors.right: startButtonFocusScope.horizontalCenter
    anchors.rightMargin: 15
    activeFocusOnTab: true
    Accessible.name: qsTr("Previous point of interest")
    
    Rectangle {
        id: rect5
        anchors.fill: parent
        color: bgColor
        border.color: focus5.activeFocus ? lightColor : "light gray"
        border.width: focus5.activeFocus ? 2 : 1
        property bool checked: true
        property var text: "Previous point\n of interest"
        
        signal clicked()
        
        Text {
            id: text
            text: rect5.text
            anchors.centerIn: parent
            font.pointSize: 12
            color: fontColor
        }
        
        MouseArea {
            anchors.fill: parent
            onPressed: {
                window.interestingPoint()
                functionController.previousPointInterest()
            }
        }
    }
}
