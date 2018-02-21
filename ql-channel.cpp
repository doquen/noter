#include "ql-channel.hpp"

QlChannel::QlChannel() : QObject() { name_ = QString(""); params_ = QStringList(); out_ = new QByteArray(); }
QlChannel::QlChannel(QObject* parent) : QObject(parent) { name_ = QString(""); params_ = QStringList(); out_ = new QByteArray(); }

QStringList QlChannel::channels() { return QStringList(); }

Q_INVOKABLE bool QlChannel::open(const QString &name) { return false; }
Q_INVOKABLE bool QlChannel::isOpen() { return false; }
Q_INVOKABLE void QlChannel::close() { }
Q_INVOKABLE QString QlChannel::name() { return QString(""); }

Q_INVOKABLE QStringList QlChannel::params() { return params_; }
Q_INVOKABLE QString QlChannel::param(const QString &name) { return QString(""); }
Q_INVOKABLE bool QlChannel::paramSet(const QString &name, const QString &value) { return false; }

Q_INVOKABLE QList<int> QlChannel::readBytes() { return QList<int>(); }
Q_INVOKABLE qint64 QlChannel::writeBytes(const QList<int> &b) { return false; }

Q_INVOKABLE bool QlChannel::writeString(const QString &s) { return false; }

