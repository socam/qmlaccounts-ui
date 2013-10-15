#include "genericplugin.h"

#include <QDebug>

GenericPlugin::GenericPlugin(int &argc, char **argv):
    ProviderPluginProcess(argc, argv)
{
}

int main(int argc, char **argv)
{
    GenericPlugin *plugin = new GenericPlugin(argc, argv);

    int ret = plugin->exec();

    delete plugin;
    return ret;
}
