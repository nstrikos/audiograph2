import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Window {
    id: window
    visible: true
    width: Screen.width
    height: Screen.height
    title: qsTr("Audiographs")

    property bool anchorToLeft: undefined

    ControlsRect {
        id: controlsRect
    }

    GraphRect {
        id: graphRect
    }

    Rectangle {
        id: settingsRect
        anchors.leftMargin: window.width / 8
        color: "yellow"
    }

    ControlsButton {
        id: controlsButton
    }

    SettingsButton {
        id: settingsButton
    }

    AnchorChangeState {
        id: anchorChangeState
    }

    function setAnchor() {
        if (width >= height)
            anchorToLeft = true
        else
            anchorToLeft = false
    }

    Component.onCompleted: {
        setAnchor()
        if (anchorToLeft)
            anchorChangeState.state = 'state1'
        else
            anchorChangeState.state = 'state4'
    }

    onWidthChanged: setAnchor()
    onHeightChanged: setAnchor()
    onAnchorToLeftChanged: anchorChangeState.anchorChanged()
}
