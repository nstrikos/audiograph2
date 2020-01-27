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

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_DisableHighDpiScaling);

    QGuiApplication app(argc, argv);
    qmlRegisterType<Curve>("Curve", 1, 0, "Curve");
    qmlRegisterType<CurveMovingPoint>("CurveMovingPoint", 1, 0, "CurveMovingPoint");

    Function myfunction;
    Parameters parameters;
    Audio audio;
    AudioNotes audioNotes;
    TextToSpeech textToSpeech(parameters);

    qRegisterMetaType<Function*>("Function*");

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("myfunction", &myfunction);
    engine.rootContext()->setContextProperty("parameters", &parameters);
    engine.rootContext()->setContextProperty("audio", &audio);
    engine.rootContext()->setContextProperty("audioNotes", &audioNotes);
    engine.rootContext()->setContextProperty("textToSpeech", &textToSpeech);

    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    QObject *rootObject = engine.rootObjects().first();
    QObject *qmlObject = rootObject->findChild<QObject*>("curveMovingPoint");
    CurveMovingPoint *item = static_cast<CurveMovingPoint*>(qmlObject);
    PointsInterest pointsInterest(myfunction, audioNotes, *item, parameters);
    engine.rootContext()->setContextProperty("pointsInterest", &pointsInterest);

    return app.exec();
}
