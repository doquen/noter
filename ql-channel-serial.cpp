#include "ql-channel-serial.hpp"
#include <QThread>
#include <QDebug>

QlChannelSerial::QlChannelSerial() : QlChannel() {
    port_ = new QSerialPort();
    open_ = false;
    params_ << "baud" << "bauds" << "bits" << "parity" << "stops" << "flow";
    l = new QList<int>;
    connect(port_,SIGNAL(readyRead()),this,SLOT(readBytesSlot()));
}

QlChannelSerial::QlChannelSerial(QObject* parent) : QlChannel(parent) {
    port_ = new QSerialPort();
    open_ = false;
    params_ << "baud" << "bauds" << "bits" << "parity" << "stops" << "flow";
    l = new QList<int>;
    connect(port_,SIGNAL(readyRead()),this,SLOT(readyBytesSlot()));
}

QStringList QlChannelSerial::channels() {
    QList<QSerialPortInfo> pil = QSerialPortInfo::availablePorts();
    QStringList psl = QStringList();
    for (int i=0; i<pil.size(); i++){ psl.append( pil[i].portName() ); }
    return psl;
}

QStringList QlChannelSerial::channelInfo(QString port_name) {
    QList <QSerialPortInfo> infos = QSerialPortInfo::availablePorts();
    QStringList list;
    for (const QSerialPortInfo &info : infos) {

        if (port_name == info.portName()){
            list << (!info.description().isEmpty() ? info.description() : "")
                 << (!info.manufacturer().isEmpty() ? info.manufacturer() : "")
                 << (!info.serialNumber().isEmpty() ? info.serialNumber() : "")
                 << info.systemLocation()
                 << (info.vendorIdentifier() ? QString::number(info.vendorIdentifier(), 16) : "")
                 << (info.productIdentifier() ? QString::number(info.productIdentifier(), 16) : "");
            break;
        }
    }
    return list;
}

bool QlChannelSerial::open(const QString &name) {
    close();
    port_->setPortName(name);
    open_ = port_->open(QIODevice::ReadWrite);
    if (open_) name_ = name; else name_ = QString::fromLatin1("");
    connected(open_);
    return open_;
}

void QlChannelSerial::close() {
    if (isOpen()){
        port_->close();
        open_ = false;
        connected(open_);
    }
}

bool QlChannelSerial::isOpen() { return open_; }

QString QlChannelSerial::name() { return name_; }

QString QlChannelSerial::param(const QString &name) {
    if (!isOpen()) return QString::fromLatin1("");

    if (name == "baud") return QString::number(port_->baudRate());

    else if (name == "bits") return QString::number(port_->dataBits());

    else if (name == "parity") return QString::fromLatin1(
                (port_->parity() == QSerialPort::NoParity)    ? "n" :
                                                                (port_->parity() == QSerialPort::EvenParity)  ? "e" :
                                                                                                                (port_->parity() == QSerialPort::OddParity)   ? "o" :
                                                                                                                                                                (port_->parity() == QSerialPort::SpaceParity) ? "s" :
                                                                                                                                                                                                                (port_->parity() == QSerialPort::MarkParity)  ? "m" : "u"
                                                                                                                                                                                                                                                                );

    else if (name == "stops") return QString::number(port_->stopBits());

    else if (name == "flow") return QString::number(port_->flowControl());
    else return QString::fromLatin1("");
}

bool QlChannelSerial::paramSet(const QString &name, const QString &value) {
    if (!isOpen()) return false;

    if (name == "baud")        return port_->setBaudRate(value.toInt());
    else if (name == "bits")   return port_->setDataBits((QSerialPort::DataBits)value.toInt());
    else if (name == "parity") return port_->setParity(
                value.startsWith("n") ? QSerialPort::NoParity :
                                        value.startsWith("e") ? QSerialPort::EvenParity :
                                                                value.startsWith("o") ? QSerialPort::OddParity :
                                                                                        value.startsWith("s") ? QSerialPort::SpaceParity :
                                                                                                                value.startsWith("m") ? QSerialPort::MarkParity :
                                                                                                                                        QSerialPort::UnknownParity
                                                                                                                                        );
    else if (name == "stops") return port_->setStopBits((QSerialPort::StopBits)value.toInt());
    else if (name == "flow") return port_->setFlowControl(
                value.startsWith("n") ? QSerialPort::NoFlowControl : value.startsWith("r") ? QSerialPort::HardwareControl : QSerialPort::SoftwareControl);
    else return false;
}

QList<int> QlChannelSerial::readBytes() {
    QList<int> *l = new QList<int>();
    if (isOpen() && port_->bytesAvailable()){
        do {
            QByteArray buf = port_->readAll();
            for (int i=0; i<buf.size(); i++) l->append((unsigned char)buf.at(i));
            //QThread::sleep(5);
        } while(port_->waitForReadyRead(10));
    }
    return *l;
}

void QlChannelSerial::readBytesSlot() {
    if (isOpen() && port_->bytesAvailable()){
        do {
            QByteArray buf = port_->readAll();
            for (int i=0; i<buf.size(); i++) l->append((unsigned char)buf.at(i));
            //QThread::sleep(5);
        } while(port_->waitForReadyRead(10));
    }
    readyReadSignal();
}

QList<int> QlChannelSerial::getl(){
    return *l;
}

void QlChannelSerial::dell(){
    l->clear();
}

QString QlChannelSerial::readText(){
    QString s;
    if (isOpen() && port_->bytesAvailable()){
        do{
            QByteArray buf = port_->readAll();
            s = s+ QString(buf);
        }while(port_->waitForReadyRead(10));
    }
    return s;
}

QString QlChannelSerial::bytes2String(QList<int> bytes){
    QString s;
    foreach (int b, bytes)
        s = s + QString((unsigned char)b);
    return s;
}

qint64 QlChannelSerial::writeBytes(const QList<int> &l) {
    qint64 r;
    if (isOpen()){
        if (!l.size()) return true;
        out_->resize(l.size());
        for (int i=0; i<l.size(); i++) out_->data()[i] = l[i];
        r = port_->write(*out_);
        return r;
    }
    return false;
}

bool QlChannelSerial::writeString(const QString &s) {
    if (isOpen()){
        return port_->write(s.toLocal8Bit()) > 0;
    }
    return false;
}

qint64 QlChannelSerial::bytesAvailable(){
    return port_->bytesAvailable();
}

void QlChannelSerial::waitms(long ms){
    QThread::msleep(ms);
}
