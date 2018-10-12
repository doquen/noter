#ifndef SSH_H
#define SSH_H

#include <QObject>
#include <libssh/libsshpp.hpp>
#include <QFile>

class Ssh : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool opened READ opened WRITE setOpened NOTIFY openedChanged)
public:
    explicit Ssh(QObject *parent = nullptr);
    ~Ssh();

signals:
    void readyRead();
    void openedChanged();
public slots:
    void recieveLoop();
    Q_INVOKABLE virtual void writeData(const QString &s);
    Q_INVOKABLE virtual void paramSet(QString param, QString value);
    Q_INVOKABLE virtual bool isOpen();
    Q_INVOKABLE virtual void open();
    Q_INVOKABLE virtual void close();
    Q_INVOKABLE virtual QList<int> getData();
    Q_INVOKABLE virtual void setPassword(QString pass);
    Q_INVOKABLE virtual QString parseVT100(QByteArray *text);
    void setOpened(bool o);
    bool opened();

private:
    QFile *fileToParse;
    QByteArray *rcvBuffer;
    ssh_channel channel;
    ssh_session session;
    QString password;
    bool reading;
    bool m_opened;
    int port;
};

#endif // SSH_H
