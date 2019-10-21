import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Rectangle {
    id: graphRect
    z: 10
    color: "white"

    layer.enabled: true
    layer.samples: 256

    property var graphCanvas: graphCanvas

    GraphCanvas {
        id: graphCanvas
        anchors.fill: parent
    }
}
