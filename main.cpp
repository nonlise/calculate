#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include <QFontDatabase>

#include "src/core/Calculator.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    qint32 fontId = QFontDatabase::addApplicationFont(":/fonts/OpenSansSemibold.otf");
    QStringList fontList = QFontDatabase::applicationFontFamilies(fontId);
    QString family = fontList.first();
    QGuiApplication::setFont(QFont(family));

    QQmlApplicationEngine engine;

    Calculator* calculator = new Calculator(&app);

    engine.rootContext()->setContextProperty("calculator", calculator);

    qmlRegisterSingletonType(QUrl("qrc:/qt/qml/untitled/src/ui/components/Constants.qml"), "Constants", 1, 0, "Constants");

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    engine.loadFromModule("untitled", "Main");

    return app.exec();
}
