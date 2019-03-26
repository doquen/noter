#include <QGuiApplication>
#include <QApplication>
#include <QQmlApplicationEngine>
#include <QFileInfo>
#include <QTranslator>
#include <QIcon>
#include <QDebug>

#include "ql-channel-serial.hpp"

int main(int argc, char *argv[])
{
#if defined(Q_OS_WIN)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QString locale = QLocale::system().name().split("_").at(0);
    QTranslator translator;
    translator.load("NoTer_"+locale);

    QGuiApplication app(argc, argv);
    app.installTranslator(&translator);

    QFileInfo fi(app.applicationDirPath() + "/../share/icons/hicolor/256x256/apps/NoTer.png");
    QApplication::setWindowIcon(QIcon(fi.absoluteFilePath()));
    qmlRegisterType<QlChannelSerial>("QlChannelSerial",1,0,"QlChannelSerial");
    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;
    return app.exec();
}
