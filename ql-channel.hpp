#ifndef QL_CHANNEL_H
    #define QL_CHANNEL_H

#include <QObject>
#include <QString>
#include <QStringList>
#include <QList>
#include <QVariant>

class QlChannel : public QObject {
    Q_OBJECT

    public:
        QlChannel();
        QlChannel(QObject* parent);

        Q_INVOKABLE virtual QStringList channels();

        Q_INVOKABLE virtual bool open(const QString &name);
        Q_INVOKABLE virtual void close();
        Q_INVOKABLE virtual bool isOpen();
        Q_INVOKABLE virtual QString name();

        Q_INVOKABLE virtual QStringList params();
        Q_INVOKABLE virtual QString param(const QString &name);
        Q_INVOKABLE virtual bool paramSet(const QString &name, const QString &value);

        Q_INVOKABLE virtual QList<int> readBytes();
        Q_INVOKABLE virtual qint64 writeBytes(const QList<int> &b);

        Q_INVOKABLE virtual bool writeString(const QString &s);

	protected:
		QString     name_;
		QStringList params_;
		QByteArray  *out_;
	
	private:
};

#endif

