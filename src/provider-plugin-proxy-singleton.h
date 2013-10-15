#ifndef PROVIDERPLUGINPROXYSINGLETON_H
#define PROVIDERPLUGINPROXYSINGLETON_H

#include <AccountsUI/ProviderPluginProxy>

class ProviderPluginProxySingleton: public AccountsUI::ProviderPluginProxy
{
    Q_OBJECT

public:
    static ProviderPluginProxySingleton *instance();
    virtual ~ProviderPluginProxySingleton();

private :
    ProviderPluginProxySingleton(QObject *parent = 0);
};

#endif // PROVIDERPLUGINPROXYSINGLETON_H
