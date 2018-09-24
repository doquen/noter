#ifndef SSH_H
#define SSH_H

#include <QObject>
#include <libssh/libsshpp.hpp>

class Ssh : public QObject
{
    Q_OBJECT
public:
    explicit Ssh(QObject *parent = nullptr);
    ~Ssh();

signals:

public slots:
    void recieveLoop();
    Q_INVOKABLE virtual void writeData(const QString &s);

private:
    QByteArray *rcvBuffer;
    ssh_channel channel;
    ssh_session session;
    int port;
};

#endif // SSH_H
