#include <QDesktopServices>
#include <QApplication>
#include <QDeclarativeView>
#include <QDeclarativeEngine>
#include <QDeclarativeContext>
#include <QDebug>
#include <QDir>
#ifdef HAS_BOOSTER
#include <applauncherd/MDeclarativeCache>
#endif

#ifdef HAS_BOOSTER
Q_DECL_EXPORT
#endif

#include "account-provider-model.h"
#include "account-model.h"
#include "process-caller.h"

//libaccounts-ui
#include <AccountsUI/AccountsManagerSingleton>


Q_DECL_EXPORT int main(int argc, char *argv[])
{

    QApplication *application;
    QDeclarativeView *view;

#ifdef HAS_BOOSTER
    application = MDeclarativeCache::qApplication(argc, argv);
    view = MDeclarativeCache::qDeclarativeView();
#else
    qWarning() << Q_FUNC_INFO << "Warning! Running without booster. This may be a bit slower.";
    QApplication stackApp(argc, argv);
    QDeclarativeView stackView;
    application = &stackApp;
    view = &stackView;
#endif


    AccountModel *accountModel = new AccountModel(application);
    AccountProviderModel *providerModel = new AccountProviderModel(application);
    QObject::connect(view->engine(), SIGNAL(quit()), application, SLOT(quit()));
    view->rootContext()->setContextProperty("accountModel", accountModel);
    view->rootContext()->setContextProperty("accountsproviderModel", providerModel);
    //TODO: check where else it cant be done
    ProcessCaller pCaller;
    view->rootContext()->setContextProperty("processCaller", &pCaller);


    if (QFile::exists("main.qml"))
        view->setSource(QUrl::fromLocalFile("main.qml"));
    else
        view->setSource(QUrl("qrc:/qml/main.qml"));

    Accounts::Manager *manager = AccountsUI::AccountsManager::instance();
    QObject::connect(manager, SIGNAL(accountCreated(Accounts::AccountId)),
                     view->rootObject(), SLOT(accountCreated()));
    view->setAttribute(Qt::WA_OpaquePaintEvent);
    view->setAttribute(Qt::WA_NoSystemBackground);
    view->viewport()->setAttribute(Qt::WA_OpaquePaintEvent);
    view->viewport()->setAttribute(Qt::WA_NoSystemBackground);
    view->setResizeMode(QDeclarativeView::SizeRootObjectToView);

//    view->rootContext()->setContextProperty("systemAvatarDirectory", QDesktopServices::storageLocation(QDesktopServices::PicturesLocation));
    view->rootContext()->setContextProperty("DocumentsLocation", QDesktopServices::storageLocation(QDesktopServices::DocumentsLocation));
    view->showFullScreen();

    return application->exec();
}
