import QtQuick 2.15
import QtQuick.Window 2.2
import QtQuick.Controls 2.15
import QtQml.Models 2.15

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")
    property  var colorList: ["red","blue","yellow","purple","green","pink"]
    property var currentIndex: 0
    property var currentItem_y: 0
    property var currentVisualIndex: 0
    property var moveNum: 0
    ListModel {
        id: xxModel
        ListElement {
            color: "red"
        }
        ListElement {
            color: "blue"
        }
        ListElement {
            color: "yellow"
        }
        ListElement {
            color: "purple"
        }
        ListElement {
            color: "green"
        }
        ListElement {
            color: "pink"
        }
    }

    ListModel {
        id: otherModel
//        ListElement {
//            color: "red"
//        }
//        ListElement {
//            color: "yellow"
//        }
        ListElement {
            color: "blue"
        }
        ListElement {
            color: "green"
        }
        ListElement {
            color: "pink"
        }
        ListElement {
            color: "pink"
        }
        ListElement {
            color: "black"
        }
        ListElement {
            color: "purple"
        }
    }

    Button {
        anchors {
            left: parent.left
            leftMargin: 30
            top: parent.top
            topMargin: 30
        }

        Text {
            id: name
            text: qsTr("添加")
            font.pixelSize: 10
            color: "black"
            anchors.centerIn: parent
        }

        onClicked: {
            var max = colorModel.count
            var num = parseInt(Math.random()*max,10)
            console.log("num = ",num)
            colorModel.insert(2,{color: "blue"})
        }
    }

    Button {
        anchors {
            left: parent.left
            leftMargin: 30
            top: parent.top
            topMargin: 90
        }

        Text {
            text: qsTr("刷新数据")
            font.pixelSize: 10
            color: "black"
            anchors.centerIn: parent
        }

//        onClicked: {
////            otherListView.visible = !otherListView.visible
////            colorListView.visible = !colorListView.visible
//            colorListView.visible = false
//            otherListView.visible = true
//            console.log("colorListView.visible:",colorListView.visible)
//            console.log("otherListView.visible:",otherListView.visible)
////            xxModel.clear()
////            colorListView.model = otherModel
//        }
    }


    Timer {
        id: timer
        interval: 500
        running: false
        repeat: true
        onTriggered: {
            moveNum ++
            root.positionViewAtIndex(currentVisualIndex - 7 + moveNum, ListView.Beginning)
        }
    }

    ListView {
        id: otherListView
        visible: false
        width: 200
        height: 60 * 6
        anchors.centerIn: parent
        model: otherModel
        add: Transition {
             NumberAnimation { properties: "x"; from:500; duration: 500 }
        }
        addDisplaced: Transition {
             NumberAnimation { properties: "x,y"; duration: 500 }
         }
        removeDisplaced: Transition {
             NumberAnimation { properties: "x,y"; duration: 500 }
         }
        remove: Transition {
             ParallelAnimation {
                 NumberAnimation { property: "opacity"; to: 0; duration: 500 }
                 NumberAnimation { properties: "x"; to: -800; duration: 500 }
             }
        }
        populate: Transition {
             NumberAnimation { property: "opacity"; from: 0; to: 1; duration: 1000 }
             NumberAnimation { properties: "x,y";duration: 1000 }
         }
        delegate: Rectangle {
            width: 200
            height: 60
            color: xxModel.get(index).color
            Button {
                width: 30
                height: 30
                onClicked: {
                    console.log("....")
                    currentIndex = index
                    xxModel.remove(currentIndex,1)
                    console.log("send remove signal...")
                }
                anchors.centerIn: parent
            }
            Text {
                text: qsTr("删除")
                font.pixelSize: 10
                color: "black"
                anchors.centerIn: parent
            }
        }
    }

    ListView {
        id: root//colorListView
        visible: true
        width: 200
        height: 60 * 10
        anchors.centerIn: parent
        add: Transition {
             NumberAnimation { properties: "x"; from:500; duration: 500 }
        }
        addDisplaced: Transition {
             NumberAnimation { properties: "x,y"; duration: 500 }
         }
        removeDisplaced: Transition {
             NumberAnimation { properties: "x,y"; duration: 500 }
         }
        remove: Transition {
             ParallelAnimation {
                 NumberAnimation { property: "opacity"; to: 0; duration: 500 }
                 NumberAnimation {properties: "x"; to: -800; duration: 500 }
             }
        }
        move: Transition {
             NumberAnimation { properties: "x,y"; duration: 300 }
//             ScriptAction {
//                 script: {
//                     console.log("y,")
//                     if (currentItem_y > 80 * 7)
//                     {
//                        root.contentX = currentVisualIndex * 80
//                     }
//                 }
//             }
        }
        moveDisplaced: Transition {
             NumberAnimation { properties: "x,y"; duration: 500 }
         }
        populate: Transition {
             NumberAnimation { property: "opacity"; from: 0; to: 1; duration: 1000 }
             NumberAnimation { properties: "x,y";duration: 500 }
         }
        model: DelegateModel {
    //! [0]
            id: visualModel
            model: ListModel {
                id: colorModel
                ListElement { color: "blue" }
                ListElement { color: "green" }
                ListElement { color: "red" }
                ListElement { color: "yellow" }
                ListElement { color: "orange" }
                ListElement { color: "purple" }
                ListElement { color: "cyan" }
                ListElement { color: "magenta" }
                ListElement { color: "chartreuse" }
                ListElement { color: "aquamarine" }
                ListElement { color: "indigo" }
                ListElement { color: "black" }
                ListElement { color: "lightsteelblue" }
                ListElement { color: "violet" }
                ListElement { color: "grey" }
                ListElement { color: "springgreen" }
                ListElement { color: "salmon" }
                ListElement { color: "blanchedalmond" }
                ListElement { color: "forestgreen" }
                ListElement { color: "pink" }
                ListElement { color: "navy" }
                ListElement { color: "goldenrod" }
                ListElement { color: "crimson" }
                ListElement { color: "teal" }
            }
    //! [1]
            delegate: DropArea {
                id: delegateRoot
                required property color color;

                width: 80; height: 80

                onEntered: function(drag) {
                    console.log("enter....")
                    visualModel.items.move((drag.source as Icon).visualIndex, icon.visualIndex)
                }

                onExited: {
                    console.log("................")
                    timer.running = false
                    moveNum = 0
                    console.log("stop drag.................................................")
                    console.log("(drag.source as Icon).visualIndex:",(drag.source as Icon).visualIndex)
//                    visualModel.items.move((drag.source as Icon).visualIndex, icon.visualIndex)
                }

                onPositionChanged: function(drag) {
                    console.log("startDrag...")
                    timer.running = true
                    currentVisualIndex = Drag.source.visualIndex
                    console.log("currentVisualIndex:",currentVisualIndex)
//                    if (currentItem_y > 80 * 7)
//                    {
//                        root.contentX = currentVisualIndex * 80
//                    }
                }

                property int visualIndex: DelegateModel.itemsIndex

                Icon {
                    id: icon
                    dragParent: root
                    visualIndex: delegateRoot.visualIndex
                    color: delegateRoot.color
                    onDeleteItem: {
                        colorModel.remove(visualIndex)
                    }
                }
            }
    //! [1]
        }
    }
}
