#include "process-caller.h"
#include "provider-plugin-proxy-singleton.h"

#include <AccountsUI/ProviderPluginProxy>

#include <QDeclarativeView>
#include <QDebug>

ProcessCaller::ProcessCaller()
{}

ProcessCaller::~ProcessCaller()
{}

void ProcessCaller::createAccount(Accounts::Provider provider)
{
     AccountsUI::ProviderPluginProxy *pluginProcess = ProviderPluginProxySingleton::instance();
     if (!pluginProcess) {
         return;
     }
     qDebug("plugin exist");

     pluginProcess->createAccount(provider, QString());
}

void ProcessCaller::editAccount(Accounts::Account *account)
{
    AccountsUI::ProviderPluginProxy *pluginProcess = ProviderPluginProxySingleton::instance();
    if (!pluginProcess) {
        return;
    }
    pluginProcess->editAccount(account, QString());
}
