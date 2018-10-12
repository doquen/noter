#include "ssh.h"
#include <QtConcurrent/QtConcurrent>
#include <QThreadPool>
#include <QDebug>
#include <QThread>
#include <QProcess>

Ssh::Ssh(QObject *parent) : QObject(parent)
{

    port = 22;
    rcvBuffer = new QByteArray();
    setOpened(false);
    reading = false;
    session = ssh_new();
    fileToParse = new QFile("parse");
    //    int rc;
    //    ssh_options_set(session,SSH_OPTIONS_HOST,"localhost");
    //    ssh_options_set(session, SSH_OPTIONS_USER, "pablo" );
    //    ssh_options_set(session,SSH_OPTIONS_PORT,&port);
    //    ssh_connect(session);
    //    rc = ssh_userauth_password(session, NULL, "153486");
    //    channel = ssh_channel_new(session);
    //    rc = ssh_channel_open_session(channel);
    //    rc = ssh_channel_request_pty(channel);
    //    rc = ssh_channel_change_pty_size(channel, 80, 24);
    //    rc = ssh_channel_request_shell(channel);
}

Ssh::~Ssh(){
    if(ssh_channel_is_open(channel)){
        ssh_channel_close(channel);
        ssh_channel_send_eof(channel);
        ssh_channel_free(channel);
        setOpened(false);
    }
}

void Ssh::setOpened(bool o){
    if (o != m_opened){
        m_opened = o;
        openedChanged();
    }
}

bool Ssh::opened(){
    return m_opened;
}

void Ssh::close(){
//    if(ssh_channel_is_open(channel)){
//        ssh_channel_close(channel);
//        ssh_channel_send_eof(channel);
//        ssh_channel_free(channel);
//        setOpened(false);
//        session = ssh_new();
//    }
}

void Ssh::open(){
    ssh_connect(session);
    ssh_userauth_password(session, nullptr, password.toStdString().c_str());
    channel = ssh_channel_new(session);
    ssh_channel_open_session(channel);
    ssh_channel_request_pty(channel);
    ssh_channel_change_pty_size(channel, 80, 24);
    ssh_channel_request_shell(channel);
    setOpened(true);
    QtConcurrent::run(this,&Ssh::recieveLoop);
}

void Ssh::setPassword(QString pass){
    password = pass;
}

QList<int> Ssh::getData(){
    QString parsed;
    QList<int> ret;
    reading = true;
    for (int i=0; i<rcvBuffer->size(); i++) ret.append(static_cast<unsigned char>(rcvBuffer->at(i)));
    parsed = QString(parseVT100(rcvBuffer));
    rcvBuffer->clear();
    reading = false;
    return ret;
}

QString Ssh::parseVT100(QByteArray *text){
    QProcess p;
    QString parsed;
    p.start("echo "+QString(text->data())+" | vt100.py");
    p.waitForFinished(-1);
    parsed = p.readAllStandardOutput();
    QFile::remove("parse");
    return parsed;
}
void Ssh::recieveLoop(){
    char buffer[256];
    int nbytes;
    while(ssh_channel_is_open(channel) &&
          !ssh_channel_is_eof(channel)){
        while(reading)
            QThread::usleep(50000);
        QThread::usleep(50000);
        nbytes = ssh_channel_read_nonblocking(channel, buffer, sizeof(buffer), 0);
        if (nbytes < 0){
            qDebug() << "error";
        }
        if (nbytes > 0){
            rcvBuffer->append(buffer,256);
            readyRead();
        }
    }
}

bool Ssh::isOpen(){
    return ssh_channel_is_open(channel);
}

void Ssh::writeData(const QString &s){
    QByteArray data;
    data.append(s);
    ssh_channel_write(channel,data.data(),static_cast<uint32_t>(data.length()));
}

void Ssh::paramSet( QString param, QString value){
    const void * p = value.toStdString().c_str();
    close();
    if (param == "host")
        ssh_options_set(session,SSH_OPTIONS_HOST,p);
    else if (param == "user")
        ssh_options_set(session,SSH_OPTIONS_USER,p);
    else if (param == "port")
        ssh_options_set(session, SSH_OPTIONS_PORT_STR, p);
}
