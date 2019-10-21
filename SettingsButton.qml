import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Item {
    id: settingsButton
    width: 50
    height: 50
    z: 100
    anchors.leftMargin: window.width / 8 - width
    
    SettingsIcon {
        anchors.fill: parent
    }
    
    MouseArea {
        anchors.fill: parent
        onPressed: anchorChangeState.settingsButtonPressed()
    }
}
