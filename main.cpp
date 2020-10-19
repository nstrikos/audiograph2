#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "parameters.h"
#include "audio.h"
#include "audionotes.h"
#include "texttospeech.h"

#include "function/functionController.h"
#include "function/functionDisplayView.h"
#include "function/functionPointView.h"
#include "function/functionLineView.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    app.setOrganizationName("Nick Strikos");
    app.setOrganizationDomain("nstrikos@yahoo.gr");
    app.setApplicationName("audiographs");

    qmlRegisterType<FunctionDisplayView>("DisplayView", 1, 0, "DisplayView");
    qmlRegisterType<FunctionPointView>("PointView", 1, 0, "PointView");
    qmlRegisterType<FunctionPointView>("LineView", 1, 0, "LineView");

    Parameters *parameters = &Parameters::getInstance();
    FunctionController functionController;
    //    qRegisterMetaType<FunctionController*>("FunctionController*");

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("parameters", parameters);
    engine.rootContext()->setContextProperty("functionController", &functionController);

    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    QObject *rootObject = engine.rootObjects().first();
    QObject *qmlPointView = rootObject->findChild<QObject*>("pointView");
    QObject *qmlLineView = rootObject->findChild<QObject*>("lineView");

    QObject *qmlDisplayView = rootObject->findChild<QObject*>("displayView");
    QObject *qmlDerivativeView = rootObject->findChild<QObject*>("derivativeView");
    QObject *qmlDerivative2View = rootObject->findChild<QObject*>("derivative2View");

    FunctionPointView *pointView = static_cast<FunctionPointView*>(qmlPointView);
    FunctionLineView *lineView = static_cast<FunctionLineView*>(qmlLineView);

    FunctionDisplayView *displayView = static_cast<FunctionDisplayView*>(qmlDisplayView);
    FunctionDisplayView *derivativeView = static_cast<FunctionDisplayView*>(qmlDerivativeView);
    FunctionDisplayView *derivative2View = static_cast<FunctionDisplayView*>(qmlDerivative2View);

    functionController.setView(displayView);
    functionController.setPointView(pointView);
    functionController.setLineView(lineView);
    functionController.setDerivativeView(derivativeView);
    functionController.setDerivative2View(derivative2View);

    return app.exec();
}
