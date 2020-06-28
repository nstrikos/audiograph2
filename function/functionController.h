#ifndef FUNCTIONCONTROLLER_H
#define FUNCTIONCONTROLLER_H

#include <QObject>
#include "functionModel.h"
#include "functionDisplayView.h"
#include "functionPointView.h"
#include "audio.h"
#include "audionotes.h"
#include "parameters.h"
#include "dragHandler.h"
#include "functionZoomer.h"
#include "pinchHandler.h"
#include "pointInterest.h"
#include "currentPoint.h"
#include "texttospeech.h"

class FunctionController : public QObject
{
    Q_OBJECT

public:
    explicit FunctionController(QObject *parent = nullptr);
    ~FunctionController();

    void setView(FunctionDisplayView *view);
    void setPointView(FunctionPointView *pointView);

    Q_INVOKABLE void displayFunction(QString expression,
                                     QString minX,
                                     QString maxX,
                                     QString minY,
                                     QString maxY);

    Q_INVOKABLE void viewDimensionsChanged();

    Q_INVOKABLE void zoom(double delta);
    Q_INVOKABLE void startDrag(int x, int y);
    Q_INVOKABLE void drag(int diffX, int diffY, int width, int height);
    Q_INVOKABLE void startPinch();
    Q_INVOKABLE void pinch(double scale);

    Q_INVOKABLE void audio();
    Q_INVOKABLE void stopAudio();

    Q_INVOKABLE void nextPoint();
    Q_INVOKABLE void previousPoint();
    Q_INVOKABLE void mousePoint(int point);

    Q_INVOKABLE void nextPointInterest();
    Q_INVOKABLE void previousPointInterest();
    Q_INVOKABLE void nextPointInterestFast();
    Q_INVOKABLE void previousPointInterestFast();


    Q_INVOKABLE void incStep();
    Q_INVOKABLE void decStep();

    Q_INVOKABLE void sayXCoordinate();
    Q_INVOKABLE void sayYCoordinate();
    Q_INVOKABLE void nextPointY();
    Q_INVOKABLE void previousPointY();

    Q_INVOKABLE void firstPoint();
    Q_INVOKABLE void endPoint();

    Q_INVOKABLE void stopInterestingPoint();

    Q_INVOKABLE bool validExpression();

    Q_INVOKABLE double minX();
    Q_INVOKABLE double maxX();
    Q_INVOKABLE double minY();
    Q_INVOKABLE double maxY();

    Q_INVOKABLE QString getError();

signals:
    void updateFinished();
    void error();
    void newInputValues(double minX, double maxX, double minY, double maxY);
    void movingPointFinished();

private slots:
    void updateDisplayView();
    void clearDisplayView();

private:
    void startAudio();
    void startNotes();
    void setPoint(int point);

    //These are defined outside of the class
    FunctionDisplayView *m_view;
    FunctionPointView *m_pointView;
    Parameters *m_parameters;

    //These classes are internal
    FunctionModel *m_model;
    Audio *m_audio;
    AudioNotes *m_audioNotes;
    FunctionZoomer *m_zoomer;
    DragHandler *m_dragHandler;
    PinchHandler *m_pinchHandler;
    PointsInterest *m_pointsInterest;
    CurrentPoint *m_currentPoint;
    TextToSpeech *m_textToSpeech;
};

#endif // FUNCTIONCONTROLLER_H

