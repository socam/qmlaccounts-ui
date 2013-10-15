import QtQuick 1.1
import com.nokia.meego 1.0
import "constants.js" as Constants


Page {
    id: addAccountsPage
    PageHeader {
        id: header
        text: qsTr("Add New Account")
    }

    ListView {
        id: providerListView
        width: parent.width; height: parent.height
        anchors.top : header.bottom

        model: accountsproviderModel
        delegate: Item {
            width: parent.width; height: 85
            property variant myModel: model

            function callPluginProcess(){
                processCaller.createAccount(providerListView.currentItem.myModel.provider);
            }

            MouseArea {
                anchors.fill : parent
                Row{
                    width: parent.width
                    spacing: 50
                    Column {
                        Image {
                            id: imageItem
                            fillMode: Image.PreserveAspectFit
                            source: "image://theme/"+providerIcon
                        }
                    }
                    Column {
                        width: 380 //TODO: check why parent.width is not working
                        Label {
                            text: providerName
                            verticalAlignment: Text.AlignVCenter
                        }
                        Label {
                            width: parent.width;
                            font.pixelSize: 15
                            wrapMode: Text.WordWrap
                            text: providerDescription
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }
                onClicked: {
                    providerListView.currentIndex = index;
                    callPluginProcess(); }
            }
        }
    }

    tools:ToolBarLayout {
            anchors.bottom: parent.bottom
            visible: true

            ToolIcon {
                id: back
                iconId: "toolbar-back";
                onClicked: app.pageStack.pop()
            }
        }

}
