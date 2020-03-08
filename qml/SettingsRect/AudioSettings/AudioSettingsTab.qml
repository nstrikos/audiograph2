import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.3

Rectangle {
    color: bgColor

    property bool invertTheme: parameters.invertTheme

    property color fontColor:  parameters.invertTheme ? "white" : "black"
    property color lightColor: parameters.invertTheme ? "yellow" : "blue"

    onInvertThemeChanged: {
        fontColor = parameters.invertTheme ? "white" : "black"
        bgColor = !parameters.invertTheme ? "white" : "black"
        lightColor = parameters.invertTheme ? "yellow" : "blue"
    }

    property color bgColor: !parameters.invertTheme ? "white" : "black"

    Flickable {
        anchors.fill: parent
        contentHeight: 500
        clip: true
        Label1 {
            id: label1
        }
        DurationSpinbox {
            id: durationSpinbox
        }
        Label2 {
            id: label2
        }
        MinFreqSpinbox {
            id: minFreqSpinbox
        }
        Label3 {
            id: label3
        }
        MaxFreqSpinbox {
            id: maxFreqSpinbox
        }
        Label4 {
            id: label4
        }
        UseNotesFocusScope {
            id: useNotesFocusScope
        }
        Label5 {
            id: label5
        }
        ExploreModeFocusScope {
            id: exploreModeFocusScope
        }
        ResetButton {
            id: resetButton
        }
    }
}
