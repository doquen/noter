#include "ssh.h"
#include <QtConcurrent/QtConcurrent>
#include <QThreadPool>
#include <QDebug>
#include <QThread>

Ssh::Ssh(QObject *parent) : QObject(parent)
{
    int rc;
    port = 22;
    rcvBuffer = new QByteArray();
    session = ssh_new();
    ssh_options_set(session,SSH_OPTIONS_HOST,"localhost");
    ssh_options_set(session, SSH_OPTIONS_USER, "pablo" );
    ssh_options_set(session,SSH_OPTIONS_PORT,&port);
    ssh_connect(session);
    rc = ssh_userauth_password(session, NULL, "153486");
    channel = ssh_channel_new(session);
    rc = ssh_channel_open_session(channel);
    rc = ssh_channel_request_pty(channel);
    rc = ssh_channel_change_pty_size(channel, 80, 24);
    rc = ssh_channel_request_shell(channel);
    QtConcurrent::run(this,&Ssh::recieveLoop);
}

Ssh::~Ssh(){
    ssh_channel_close(channel);
    ssh_channel_send_eof(channel);
    ssh_channel_free(channel);
}

void Ssh::recieveLoop(){
    char buffer[256];
    int nbytes;
    while(ssh_channel_is_open(channel) &&
          !ssh_channel_is_eof(channel)){
        QThread::usleep(50000);
        nbytes = ssh_channel_read_nonblocking(channel, buffer, sizeof(buffer), 0);
        if (nbytes < 0){ qDebug() << "error";}
        if (nbytes > 0){
            rcvBuffer->append(buffer,256);
            qDebug() << *rcvBuffer;
            rcvBuffer->clear();
        }
    }
}

void Ssh::writeData(const QString &s){
    char buffer[256];
    buffer[0]='l';buffer[1]='s';buffer[2]='\n';
    ssh_channel_write(channel,buffer,3);
}
