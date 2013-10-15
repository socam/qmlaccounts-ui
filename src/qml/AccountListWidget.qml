/*
 * Copyright (C) 2011-2012 Robin Burchell <robin+mer@viroteck.net>
 *
 * You may use this file under the terms of the BSD license as follows:
 *
 * "Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * * Redistributions of source code must retain the above copyright
 * notice, this list of conditions and the following disclaimer.
 * * Redistributions in binary form must reproduce the above copyright
 * notice, this list of conditions and the following disclaimer in
 * the documentation and/or other materials provided with the
 * distribution.
 * * Neither the name of Nemo Mobile nor the names of its contributors
 * may be used to endorse or promote products derived from this
 * software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
 */

import QtQuick 1.1
import com.nokia.meego 1.0

ListView {
    id: groupedViewPortrait
    signal addNewAccount
    width: parent.width; height: parent.height
    model: accountModel
    delegate: Item {
        width: parent.width; height: 85
        property variant myModel: model

        function callPluginProcess(){
            /* Passing the account object being clicked */
            processCaller.editAccount(groupedViewPortrait.currentItem.myModel.account);
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
                        source: "image://theme/"+accountIcon
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
                        text: accountName
                        verticalAlignment: Text.AlignVCenter
                    }
                }
            }
            onClicked: {
                groupedViewPortrait.currentIndex = index;
                callPluginProcess();
            }
        }
    }


    cacheBuffer: height
    section.property: "sectionBucket"
    section.criteria: ViewSection.FirstCharacter
    section.delegate: Component {
        Rectangle {
            width: parent.width
            height: childrenRect.height
            color: "lightsteelblue"

            Text {
                anchors.right: parent.right
                anchors.rightMargin: UiConstants.DefaultMargin
                text: section
                font.bold: true
            }
        }
    }

    Label {
        // TODO: it would be nice if this was only instantiated
        // when needed, and destroyed after
        id: emptyListView
        visible: parent.count == 0
        anchors.centerIn: parent
        text: qsTr("You haven't added any accounts yet.")

        Button {
            id: button
            text: qsTr("Add an account")

            anchors {
                top: parent.bottom;
                topMargin: UiConstants.DefaultMargin;
                horizontalCenter: parent.horizontalCenter;
            }
            onClicked: {
                groupedViewPortrait.addNewAccount();
            }
        }
    }

    SectionScroller {
        listView: parent
    }

    ScrollDecorator {
        flickableItem: parent
    }
}
