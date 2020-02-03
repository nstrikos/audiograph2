#ifndef FUNCTIONCONTROLLER_H
#define FUNCTIONCONTROLLER_H

#include <QObject>
#include "functionModel.h"
#include "functionDisplayView.h"
#include "audio.h"
#include "audionotes.h"
#include "parameters.h"
#include "dragHandler.h"
#include "functionZoomer.h"
#include "pinchHandler.h"

class FunctionController : public QObject
{
    Q_OBJECT

public:
    explicit FunctionController(QObject *parent = nullptr);
    ~FunctionController();
    Q_INVOKABLE void displayFunction(QString expression,
                                     QString minX,
                                     QString maxX,
                                     QString minY,
                                     QString maxY);

    void setDisplayView(FunctionDisplayView *view);

    Q_INVOKABLE void zoom(double delta);
    Q_INVOKABLE void startDrag(int x, int y);
    Q_INVOKABLE void drag(int diffX, int diffY, int width, int height);
    Q_INVOKABLE void startPinch();
    Q_INVOKABLE void pinch(double scale);

    Q_INVOKABLE void audio();
    Q_INVOKABLE void stopAudio();

    Q_INVOKABLE bool validExpression();

    void setParameters(Parameters *parameters);

signals:
    void updateFinished();
    void error();
    void newInputValues(double minX, double maxX, double minY, double maxY);

private slots:
    void updateDisplayView();
    void clearDisplayView();

private:
    void startAudio();
    void startNotes();

    FunctionModel *m_model;
    FunctionDisplayView *m_view;
    Audio *m_audio;
    AudioNotes *m_audioNotes;
    Parameters *m_parameters;

    FunctionZoomer *m_zoomer;
    DragHandler *m_dragHandler;
    PinchHandler *m_pinchHandler;
};

#endif // FUNCTIONCONTROLLER_H

