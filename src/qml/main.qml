import QtQuick 1.1
import com.nokia.meego 1.0

PageStackWindow {
    id: app
    showToolBar: true;

    initialPage: AccountsPage{}
    function accountCreated(){app.pageStack.pop();}

    ToolBar {
        anchors.bottom: parent.bottom
    }
}
