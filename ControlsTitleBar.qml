import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Rectangle {
    id: controlsTitleBar
    width: parent.width
    height: 35
    color: "black"
    z: 10000
    
    Label {
        text: (parent.width > 0) ? "Function parameters" : ""
        //font.family: Flat.FlatStyle.fontFamily
        font.pixelSize: 18
//        renderType: Text.QtRendering
        renderType: Text.NativeRendering
        font.hintingPreference: Font.PreferFullHinting
        color: "white"
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
