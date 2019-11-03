#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "function.h"
#include "curve.h"
#include "parameters.h"


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    qmlRegisterType<Curve>("Curve", 1, 0, "Curve");



    Function function;
    Parameters parameters;
    qRegisterMetaType<Function*>("Function*");

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("myfunction", &function);
    engine.rootContext()->setContextProperty("parameters", &parameters);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
