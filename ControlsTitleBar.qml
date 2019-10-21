import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Styles.Flat 1.0 as Flat

Rectangle {
    id: controlsTitleBar
    width: parent.width
    height: 35 * Flat.FlatStyle.scaleFactor
    color: Flat.FlatStyle.defaultTextColor
    z: 10000
    
    Label {
        text: (parent.width > 0) ? "Function parameters" : ""
        font.family: Flat.FlatStyle.fontFamily
        font.pixelSize: Math.round(12 * Flat.FlatStyle.scaleFactor)
//        renderType: Text.QtRendering
        renderType: Text.NativeRendering
        font.hintingPreference: Font.PreferFullHinting
        color: "white"
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
