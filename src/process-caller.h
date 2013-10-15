#ifndef PROCESSCALLER_H
#define PROCESSCALLER_H

#include <QObject>

#include <Accounts/Provider>
#include <Accounts/Account>

class ProcessCaller : public QObject
{
    Q_OBJECT
public:
    ProcessCaller();
    ~ProcessCaller();
    Q_INVOKABLE void createAccount(Accounts::Provider provider);
    Q_INVOKABLE void editAccount(Accounts::Account *account);
};

#endif // PROCESSCALLER_H
