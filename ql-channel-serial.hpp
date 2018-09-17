#ifndef QL_CHANNEL_SERIAL_H
    #define QL_CHANNEL__SERIAL_H

#include <QtSerialPort/QSerialPort>
#include <QtSerialPort/QSerialPortInfo>
#include <QIODevice>
#include <QString>
#include <QDebug>
#include "ql-channel.hpp"

class QlChannelSerial : public QlChannel {
    Q_OBJECT

    public:
        QlChannelSerial();
        QlChannelSerial(QObject* parent);

        Q_INVOKABLE virtual QStringList channels();
        Q_INVOKABLE QStringList channelInfo(QString port_name);

        Q_INVOKABLE virtual bool open(const QString &name);
        Q_INVOKABLE virtual void close();
        Q_INVOKABLE virtual bool isOpen();
        Q_INVOKABLE virtual QString name();
        Q_INVOKABLE virtual QList<int> readBytes();
        Q_INVOKABLE virtual QString param(const QString &name);
        Q_INVOKABLE virtual bool paramSet(const QString &name, const QString &value);
        Q_INVOKABLE virtual QList<int> getl();
        Q_INVOKABLE virtual void dell();

        Q_INVOKABLE virtual QString readText();
        Q_INVOKABLE virtual QString bytes2String(QList<int> bytes);
        Q_INVOKABLE virtual qint64 writeBytes(const QList<int> &b);

        Q_INVOKABLE virtual bool writeString(const QString &s);

        Q_INVOKABLE virtual qint64 bytesAvailable();

        Q_INVOKABLE virtual void waitms(long ms);
private slots:
        void readBytesSlot();
private:
         QList<int> *l;
	protected:
		QSerialPort *port_;
		bool open_;
signals:
        void readyRead();
        void readyReadSignal();
        void connected(bool conn);
};

#endif

