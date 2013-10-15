#include "provider-plugin-proxy-singleton.h"

#include <QDebug>

QScopedPointer<ProviderPluginProxySingleton> m_instance;

ProviderPluginProxySingleton::ProviderPluginProxySingleton(QObject *parent):
    ProviderPluginProxy(parent)
{
    qDebug()<< Q_FUNC_INFO;
}

ProviderPluginProxySingleton::~ProviderPluginProxySingleton()
{
    qDebug()<< Q_FUNC_INFO;
}

ProviderPluginProxySingleton *ProviderPluginProxySingleton::instance()
{
    qDebug() << Q_FUNC_INFO;
    if (m_instance.isNull()) {
        QScopedPointer<ProviderPluginProxySingleton> instance(new ProviderPluginProxySingleton());
        m_instance.swap(instance);
        return m_instance.data();
    }
    return m_instance.data();
}


