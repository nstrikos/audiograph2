import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    id: window
    visible: true

    //on android setting width and height results in
    //not showing correctly the application
    width: Qt.platform.os === "android" ? 320 : Screen.width
    height: Qt.platform.os === "android" ? 350 : Screen.height
    minimumWidth: 320
    minimumHeight: 320
    title: qsTr("Audiographs")

    property bool anchorToLeft: undefined

    Item {
        anchors.fill: parent
        focus: true
        Keys.onPressed: {
            if (event.key === Qt.Key_F2) {
                controlsRect.startSoundButtonClicked()
                event.accepted = true;
            }
        }
    }

    ControlsRect {
        id: controlsRect
    }

    ControlsButton {
        id: controlsButton
    }

    GraphRect {
        id: graphRect
    }

    SettingsButton {
        id: settingsButton
    }

    SettingsRect {
        id: settingsRect
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

    GraphParameters {
        id: graphParameters
    }

    Connections {
        target: myfunction
        onUpdate: {
            //We need graphParameters for displaying the grid
            graphParameters.minX = myfunction.minX();
            graphParameters.maxX = myfunction.maxX();
            graphParameters.minY = myfunction.minY();
            graphParameters.maxY = myfunction.maxY();
            graphRect.updateCanvas()
        }
        onError: console.log(err)
    }
}
