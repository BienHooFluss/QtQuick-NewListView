import QtQuick 2.14
import QtQuick.Controls 2.15

Rectangle {
    id: icon
    required property Item dragParent

    property int visualIndex: 0
    signal deleteItem()
    signal startDrag()

    width: 72
    height: 72
    anchors {
        horizontalCenter: parent.horizontalCenter
        verticalCenter: parent.verticalCenter
    }
    radius: 3

    Text {
        anchors.centerIn: parent
        color: "white"
        text: parent.visualIndex
    }

    Button {
        width: 30
        height: 10
        anchors {
            right: parent.right
            rightMargin: 10
            top: parent.top
            topMargin: 10
        }
        Text {
            font.pixelSize: 10
            color: "black"
            text: "删除"
            font.weight: Font.Normal
            anchors.centerIn: parent
        }
        onClicked: {
            deleteItem()
        }
    }

    DragHandler {
        id: dragHandler
    }

    Drag.active: dragHandler.active
    Drag.source: icon
    Drag.hotSpot.x: 36
    Drag.hotSpot.y: 36

    states: [
        State {
            when: dragHandler.active
            ParentChange {
                target: icon
                parent: icon.dragParent
            }

            AnchorChanges {
                target: icon
                anchors.horizontalCenter: undefined
                anchors.verticalCenter: undefined
            }
        }
    ]
}
