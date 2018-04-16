#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QIcon>

#include "ql-channel-serial.hpp"
int main(int argc, char *argv[])
{
#if defined(Q_OS_WIN)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);
    qmlRegisterType<QlChannelSerial>("QlChannelSerial",1,0,"QlChannelSerial");
    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
