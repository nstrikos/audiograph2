import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Item {
    id: controlsButton
    anchors.rightMargin: window.width / 2 - controlsRect.width - width
    z: 100
    width: 50
    height: 50
    
    SettingsIcon {
        anchors.fill: parent
    }
    
    MouseArea {
        anchors.fill: parent
        onPressed: anchorChangeState.controlsButtonPressed()
    }
}
