import QtQuick 2.12

FocusScope {
    id: settingsButton
    width: 50
    height: 50
    z: 100
    anchors.leftMargin: window.width / 8 - width
    activeFocusOnTab: true
    onActiveFocusChanged: {
        if (activeFocus) {
            borderRect.border.color = "blue"
            borderRect.opacity = 0.5
        }
        else {
            borderRect.border.color = "white"
            borderRect.opacity = 0.0
        }
    }
    Keys.onSpacePressed: anchorChangeState.settingsButtonPressed()
    Keys.onEnterPressed: anchorChangeState.settingsButtonPressed()
    Keys.onReturnPressed: anchorChangeState.settingsButtonPressed()

    Keys.onPressed: {
        if (event.key === Qt.Key_F2) {
            controlsRect.startSoundButtonClicked()
            event.accepted = true;
        } else if (event.key === Qt.Key_F8) {
            console.log("F8 pressed")
        }
    }

    Rectangle {
        id: borderRect
        anchors.fill: parent
        opacity: 0.0
    }
    
    SettingsIcon {
        anchors.fill: parent
    }
    
    MouseArea {
        anchors.fill: parent
        onPressed: anchorChangeState.settingsButtonPressed()
    }
}
