import QtQuick 2.0
import Sailfish.Silica 1.0
import FilesModel 1.0
Page {
    id: secondPage
    // The effective value will be restricted by ApplicationWindow.allowedOrientations
    allowedOrientations: Orientation.Landscape
    // orientation: Orientation.Landscape
    SilicaListView {
        id: listView
        model: sharedfmodel.getFileList()
        anchors.fill: parent
        header: PageHeader {
            title: qsTr("located files(Limit: 1000): " ) + sharedfmodel.getsMyCounter()
        }
        delegate: ListItem {
            id: listEntry
            //contentHeight:Theme.fontSizeSmall * 1.4
            Label {
                width: parent.width - Theme.fontSizeSmall * 2
                wrapMode: Text.WrapAnywhere
                x: Theme.horizontalPageMargin
                // modelData ist qml definition
                text:  index + ": " + modelData  //qsTr("Item") + " " + index
                color: listEntry.highlighted ? Theme.highlightColor : Theme.primaryColor
            }
            /*   onClicked: {
                sharedfmodel.swap2top(index)
                console.log("Clicked " + index)
                //update listView Ansatz mit BeginInsertRows unfug da performance inrelevat
                listView.model = sharedfmodel.getFileList()
                //listView.forceLayout()// funktioniert nicht
            }*/
            menu: ContextMenu {
                //you should prefer to use xdg-open /usr/share/applications/some-application.desktop to start applications properly.
                //if designing UI you can use Qt.openUrlExternally("/usr/share/applications/some-application.desktop")
                MenuItem {
                    //   implicitHeight: Theme.fontSizeExtraSmall * 1.2
                    text: "OPEN FILE" // + modelData //listView.currentItem.text

                    onClicked: {
                        //listEntry.remorseAction("opening", function() {
                        //Qt.openUrlExternally("file://" + modelData)
                        sharedfmodel.execXdgOpen(modelData);
                        //QDesktopServices::openUrl(QUrl("http://developer.nokia.com"));
                        // })
                    }
                }
                MenuItem {
                    text: "OPEN DIR in File Browser" // + modelData //listView.currentItem.text
                    onClicked: {
                        sharedfmodel.startFileBrowser(modelData)
                    }
                }
                //in QML and QDesktopServices::openUrl("/usr/share/applications/some-application.desktop") in Qt.
                MenuItem {
                    // implicitHeight: Theme.fontSizeExtraSmall * 1.2
                    text: "move to top "
                    onClicked: {
                        sharedfmodel.swap2top(index)
                        listView.model = sharedfmodel.getFileList()
                        //                       listView.positionViewAtIndex(index)
                    }
                }
                MenuItem {
                    //   implicitHeight: Theme.fontSizeExtraSmall * 1.2
                    text: "remove from list"

                    onClicked: {
                        listEntry.remorseAction("Deleting", function() {
                            sharedfmodel.remove(index)
                            listView.model = sharedfmodel.getFileList()
                            //      listView.positionViewAtIndex(index)
                        })
                    }
                }

            }
            VerticalScrollDecorator {}
            //HorizontalScrollDecorator {}
        }
    }
}
//VerticalScrollDecorator {}




