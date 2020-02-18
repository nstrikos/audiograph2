#include "functionController.h"

FunctionController::FunctionController(QObject *parent) : QObject(parent)
{
    m_view = nullptr;
    m_model = nullptr;
    m_dragHandler = nullptr;
    m_zoomer = nullptr;
    m_pinchHandler = nullptr;
    m_audio = nullptr;
    m_audioNotes = nullptr;
    m_pointView = nullptr;
    m_pointsInterest = nullptr;
    m_currentPoint = new CurrentPoint();
}

FunctionController::~FunctionController()
{
    if (m_model != nullptr)
        delete m_model;
    if (m_dragHandler != nullptr)
        delete m_dragHandler;
    if (m_zoomer != nullptr)
        delete m_zoomer;
    if (m_pinchHandler != nullptr)
        delete m_pinchHandler;
    if (m_audio != nullptr)
        delete m_audio;
    if (m_audioNotes != nullptr)
        delete m_audioNotes;
    if (m_pointsInterest != nullptr)
        delete m_pointsInterest;

    delete m_currentPoint;
}

void FunctionController::displayFunction(QString expression,
                                         QString minX,
                                         QString maxX,
                                         QString minY,
                                         QString maxY)
{
    stopAudio();

    if (m_pointsInterest != nullptr)
        m_pointsInterest->stop();

    if (m_model == nullptr) {
        m_model = new FunctionModel();
        connect(m_model, SIGNAL(update()), this, SLOT(updateDisplayView()));
        connect(m_model, SIGNAL(error(QString)), this, SLOT(clearDisplayView()));
        connect(m_model, SIGNAL(error(QString)), this, SIGNAL(error()));
        connect(m_model, SIGNAL(newInputValues(double, double, double, double)), this, SIGNAL(newInputValues(double,double,double,double)));
    }
    m_model->calculate(expression, minX, maxX, minY, maxY);
}

void FunctionController::updateView()
{
    if (m_view == nullptr)
        return;
    if (m_model == nullptr)
        return;
    stopAudio();

    if (m_pointsInterest != nullptr)
        m_pointsInterest->stop();

    m_view->updateView();
    m_currentPoint->update(m_model, m_pointView->width(), m_pointView->height());
}

void FunctionController::updateDisplayView()
{
    if (m_view != nullptr)
        m_view->draw(m_model);

    if (m_pointsInterest == nullptr)
        m_pointsInterest = new PointsInterest();

    m_pointsInterest->setModel(m_model);

    emit updateFinished();
}

void FunctionController::clearDisplayView()
{
    if (m_view != nullptr)
        m_view->clear();
}

void FunctionController::setParameters(Parameters *parameters)
{
    m_parameters = parameters;
}

void FunctionController::setDisplayView(FunctionDisplayView *view)
{
    m_view = view;
}

void FunctionController::setPointView(FunctionPointView *pointView)
{
    m_pointView = pointView;
    connect(m_pointView, SIGNAL(finished()), this, SIGNAL(movingPointFinished()));
    m_pointView->setCurrentPoint(m_currentPoint);
}

void FunctionController::zoom(double delta)
{
    if (m_pointsInterest != nullptr)
        m_pointsInterest->stop();

    if (m_model == nullptr)
        return;

    if (m_zoomer == nullptr) {
        m_zoomer = new FunctionZoomer();
        connect(m_zoomer, SIGNAL(newInputValues(double,double,double,double)), this, SIGNAL(newInputValues(double,double,double,double)));
    }
    stopAudio();
    m_zoomer->zoom(*m_model, delta);
}

void FunctionController::startDrag(int x, int y)
{
    if (m_pointsInterest != nullptr)
        m_pointsInterest->stop();

    if (m_model == nullptr)
        return;

    if (m_dragHandler == nullptr) {
        m_dragHandler = new DragHandler();
        connect(m_dragHandler, SIGNAL(newInputValues(double,double,double,double)), this, SIGNAL(newInputValues(double,double,double,double)));
    }

    stopAudio();

    m_dragHandler->startDrag(*m_model, x, y);
}

void FunctionController::drag(int diffX, int diffY, int width, int height)
{
    if (m_pointsInterest != nullptr)
        m_pointsInterest->stop();

    if (m_model == nullptr)
        return;

    m_dragHandler->drag(*m_model, diffX, diffY, width, height);
}

void FunctionController::startPinch()
{
    if (m_pointsInterest != nullptr)
        m_pointsInterest->stop();

    if (m_model == nullptr)
        return;

    if (m_pinchHandler == nullptr) {
        m_pinchHandler = new PinchHandler();
        connect(m_pinchHandler, SIGNAL(newInputValues(double,double,double,double)), this, SIGNAL(newInputValues(double,double,double,double)));
    }

    stopAudio();
    m_pinchHandler->startPinch(*m_model);
}

void FunctionController::pinch(double scale)
{
    if (m_pointsInterest != nullptr)
        m_pointsInterest->stop();

    if (m_model == nullptr)
        return;

    m_pinchHandler->pinch(*m_model, scale);
}

void FunctionController::previousPoint()
{
    stopAudio();
    if (m_pointsInterest != nullptr)
        m_pointsInterest->stop();

    if (m_pointView == nullptr)
        return;
    if (m_model == nullptr)
        return;
    if (m_parameters == nullptr)
        return;
    if (m_audioNotes == nullptr)
        m_audioNotes = new AudioNotes();

    m_currentPoint->previousPoint(m_model, m_pointView->width(), m_pointView->height());
    m_audioNotes->setNote(m_model,
                          m_currentPoint->point(),
                          m_parameters->minFreq(),
                          m_parameters->maxFreq(),
                          m_parameters->useNotes());
}

void FunctionController::nextPoint()
{
    stopAudio();
    if (m_pointsInterest != nullptr)
        m_pointsInterest->stop();

    if (m_pointView == nullptr)
        return;
    if (m_model == nullptr)
        return;
    if (m_parameters == nullptr)
        return;
    if (m_audioNotes == nullptr)
        m_audioNotes = new AudioNotes();

    m_currentPoint->nextPoint(m_model, m_pointView->width(), m_pointView->height());
    m_audioNotes->setNote(m_model,
                          m_currentPoint->point(),
                          m_parameters->minFreq(),
                          m_parameters->maxFreq(),
                          m_parameters->useNotes());
}

void FunctionController::setPoint(int point)
{
    stopAudio();
    if (m_pointsInterest != nullptr)
        m_pointsInterest->stop();

    int m_point = point;
    if (m_pointView == nullptr)
        return;
    if (m_model == nullptr)
        return;
    if (m_audioNotes == nullptr) {
        m_audioNotes = new AudioNotes();
    }

    if (point < 0)
        m_point = 0;
    if (point >= m_model->lineSize())
        m_point = m_model->lineSize() - 1;

    m_pointView->setPoint(m_model, m_point);
    m_audioNotes->setNote(m_model,
                          m_point,
                          m_parameters->minFreq(),
                          m_parameters->maxFreq(),
                          m_parameters->useNotes());
}

void FunctionController::mousePoint(int point)
{
    stopAudio();
    if (m_pointsInterest != nullptr)
        m_pointsInterest->stop();

    if (m_pointView == nullptr)
        return;
    if (m_model == nullptr)
        return;
    if (m_parameters == nullptr)
        return;
    if (m_audioNotes == nullptr)
        m_audioNotes = new AudioNotes();

    //m_pointView->setMouseX(m_model, point);
    m_currentPoint->setMouseX(m_model, m_pointView->width(), m_pointView->height(), point);
    m_audioNotes->setNote(m_model,
                          point,
                          static_cast<int>(m_pointView->width()),
                          m_parameters->minFreq(),
                          m_parameters->maxFreq(),
                          m_parameters->useNotes());
    qDebug() << point;

}

void FunctionController::nextPointInterest()
{
    if (m_pointsInterest == nullptr) {
        m_pointsInterest = new PointsInterest();
    }

    if (m_audioNotes == nullptr) {
        m_audioNotes = new AudioNotes();
    }

    m_pointsInterest->nextPoint(m_audioNotes, m_currentPoint, m_pointView, m_parameters);
}

void FunctionController::previousPointInterest()
{
    if (m_pointsInterest == nullptr) {
        m_pointsInterest = new PointsInterest();
    }

    if (m_audioNotes == nullptr) {
        m_audioNotes = new AudioNotes();
    }

    m_pointsInterest->previousPoint(m_audioNotes, m_currentPoint, m_pointView, m_parameters);
}

void FunctionController::audio()
{
    if (m_pointsInterest != nullptr)
        m_pointsInterest->stop();

    if (m_model->validExpression()) {
        if (m_parameters->useNotes()) {
            //                audioNotes.startNotes(myfunction,
            //                                      parameters.minFreq,
            //                                      parameters.maxFreq,
            //                                      parameters.duration)
            startNotes();
        } else {
            //                audio.start(textInput.text,
            //                            textInput2.text,
            //                            textInput3.text,
            //                            textInput4.text,
            //                            textInput5.text,
            //                            parameters.duration,
            //                            parameters.minFreq,
            //                            parameters.maxFreq)
            startAudio();
        }

        //graphRect.startMovingPoint()
        //        startSoundButton.checked = false
        //if (m_pointView != nullptr && m_model != nullptr && m_parameters != nullptr)
        //    m_pointView->drawPoint(m_model, m_parameters->duration());
        m_currentPoint->startMoving(m_model,
                                    m_pointView->width(),
                                    m_pointView->height(),
                                    m_parameters->duration());
    }
}

void FunctionController::startAudio()
{
    if (m_pointsInterest != nullptr)
        m_pointsInterest->stop();

    if (m_model == nullptr)
        return;

    if (m_audio == nullptr)
        m_audio = new Audio();

    m_audio->start(m_model->expression(),
                   m_model->minX(),
                   m_model->maxX(),
                   m_model->minY(),
                   m_model->maxX(),
                   m_parameters->duration(),
                   m_parameters->minFreq(),
                   m_parameters->maxFreq());
}

void FunctionController::stopAudio()
{
    if (m_pointsInterest != nullptr)
        m_pointsInterest->stop();

    if (m_audio != nullptr)
        m_audio->stop();
    if (m_audioNotes != nullptr)
        m_audioNotes->stopNotes();
    if (m_pointView != nullptr)
        m_pointView->stopPoint();
   m_currentPoint->stop();
}

bool FunctionController::validExpression()
{
    return m_model->validExpression();
}

void FunctionController::startNotes()
{
    if (m_audioNotes == nullptr)
        m_audioNotes = new AudioNotes();

    if (m_pointsInterest != nullptr)
        m_pointsInterest->stop();

    m_audioNotes->startNotes(m_model,
                             m_parameters->maxFreq(),
                             m_parameters->minFreq(),
                             m_parameters->duration());
}

double FunctionController::minX()
{
    if (m_model != nullptr)
        return m_model->minX();
    else
        return -10;
}

double FunctionController::maxX()
{
    if (m_model != nullptr)
        return m_model->maxX();
    else
        return 10;
}

double FunctionController::minY()
{
    if (m_model != nullptr)
        return m_model->minY();
    else
        return -10;
}

double FunctionController::maxY()
{
    if (m_model != nullptr)
        return m_model->maxY();
    else
        return 10;
}
