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
    void readyRead();
public slots:
    void recieveLoop();
    Q_INVOKABLE virtual void writeData(const QString &s);
    Q_INVOKABLE virtual void paramSet(QString param, QString value);
    Q_INVOKABLE virtual bool isOpen();
    Q_INVOKABLE virtual void open();
    Q_INVOKABLE virtual void close();
    Q_INVOKABLE virtual QList<int> getData();
    Q_INVOKABLE virtual void setPassword(QString pass);

private:
    QByteArray *rcvBuffer;
    ssh_channel channel;
    ssh_session session;
    QString password;
    bool reading;
    int port;
};

#endif // SSH_H
