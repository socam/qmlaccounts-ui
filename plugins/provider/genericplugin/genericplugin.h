#ifndef GENERICPLUGIN_H
#define GENERICPLUGIN_H

#include <QObject>
#include "AccountsUI/ProviderPluginProcess"

class GenericPlugin: public AccountsUI::ProviderPluginProcess
{
    Q_OBJECT

public:
    GenericPlugin(int &argc, char **argv);
};


#endif // GENERICPLUGIN_H
