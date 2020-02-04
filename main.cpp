#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "function.h"
#include "curve.h"
#include "curvemovingpoint.h"
#include "parameters.h"
#include "audio.h"
#include "audionotes.h"
#include "texttospeech.h"
#include "pointsinterest.h"

#include "function/functionController.h"
#include "function/functionDisplayView.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    qmlRegisterType<Curve>("Curve", 1, 0, "Curve");
    qmlRegisterType<CurveMovingPoint>("CurveMovingPoint", 1, 0, "CurveMovingPoint");
    qmlRegisterType<FunctionDisplayView>("DisplayView", 1, 0, "DisplayView");

    //Function myfunction;
    FunctionController functionController;

    Parameters parameters;
    functionController.setParameters(&parameters);
    TextToSpeech textToSpeech(parameters);

//    qRegisterMetaType<Function*>("Function*");
//    qRegisterMetaType<FunctionController*>("FunctionController*");

    QQmlApplicationEngine engine;
    //engine.rootContext()->setContextProperty("myfunction", &myfunction);
    engine.rootContext()->setContextProperty("parameters", &parameters);
    engine.rootContext()->setContextProperty("textToSpeech", &textToSpeech);
    engine.rootContext()->setContextProperty("functionController", &functionController);

    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    QObject *rootObject = engine.rootObjects().first();
    QObject *qmlObject = rootObject->findChild<QObject*>("curveMovingPoint");
    QObject *qmlObject2 = rootObject->findChild<QObject*>("displayView");

    //CurveMovingPoint *item = static_cast<CurveMovingPoint*>(qmlObject);
    FunctionDisplayView *displayView = static_cast<FunctionDisplayView*>(qmlObject2);
    //PointsInterest pointsInterest(myfunction, audioNotes, *item, parameters);
    //engine.rootContext()->setContextProperty("pointsInterest", &pointsInterest);
//    engine.rootContext()->setContextProperty("pointsInterest", &pointsInterest);

    functionController.setDisplayView(displayView);

    return app.exec();
}
