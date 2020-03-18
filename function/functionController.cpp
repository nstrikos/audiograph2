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
    connect(m_currentPoint, SIGNAL(movingPointFinished()), this, SIGNAL(movingPointFinished()));
    m_textToSpeech = nullptr;
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
    if (m_model == nullptr) {
        m_model = new FunctionModel();
        connect(m_model, SIGNAL(update()), this, SLOT(updateDisplayView()));
        connect(m_model, SIGNAL(error(QString)), this, SLOT(clearDisplayView()));
        connect(m_model, SIGNAL(error(QString)), this, SIGNAL(error()));
        connect(m_model, SIGNAL(newInputValues(double, double, double, double)), this, SIGNAL(newInputValues(double,double,double,double)));
    }
    m_model->calculate(expression, minX, maxX, minY, maxY);
    m_currentPoint->reset();
}

void FunctionController::updateView()
{
    if (m_view == nullptr)
        return;
    if (m_model == nullptr)
        return;

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

void FunctionController::audioNotesFinished()
{
    if (m_audioNotes != nullptr)
        disconnect(m_audioNotes, SIGNAL(finished()), this, SLOT(audioNotesFinished()));
    QString label = m_pointsInterest->currentPointLabel();
    m_textToSpeech->speak(label);
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
    m_pointView->setCurrentPoint(m_currentPoint);
}

void FunctionController::zoom(double delta)
{
    m_currentPoint->reset();
    if (m_model == nullptr)
        return;

    if (m_zoomer == nullptr) {
        m_zoomer = new FunctionZoomer();
        connect(m_zoomer, SIGNAL(newInputValues(double,double,double,double)), this, SIGNAL(newInputValues(double,double,double,double)));
    }
    //stopAudio();
    m_zoomer->zoom(*m_model, delta);
}

void FunctionController::startDrag(int x, int y)
{
    m_currentPoint->reset();

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
    m_currentPoint->reset();

    if (m_model == nullptr)
        return;

    m_dragHandler->drag(*m_model, diffX, diffY, width, height);
}

void FunctionController::startPinch()
{
    if (m_pointsInterest != nullptr) {
        m_pointsInterest->stop();
        disconnect(m_audioNotes, SIGNAL(finished()), this, SLOT(audioNotesFinished()));
    }

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
    if (m_pointsInterest != nullptr) {
        m_pointsInterest->stop();
        disconnect(m_audioNotes, SIGNAL(finished()), this, SLOT(audioNotesFinished()));
    }

    if (m_model == nullptr)
        return;

    m_pinchHandler->pinch(*m_model, scale);
}

void FunctionController::previousPoint()
{
    if (m_pointView == nullptr)
        return;
    if (m_model == nullptr)
        return;
    if (m_model->lineSize() == 0)
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
    if (m_pointView == nullptr)
        return;
    if (m_model == nullptr)
        return;
    if (m_model->lineSize() == 0)
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

void FunctionController::mousePoint(int point)
{
    if (m_pointView == nullptr)
        return;
    if (m_model == nullptr)
        return;
    if (m_model->lineSize() == 0)
        return;
    if (m_parameters == nullptr)
        return;
    if (m_audioNotes == nullptr)
        m_audioNotes = new AudioNotes();

    m_currentPoint->setMouseX(m_model, m_pointView->width(), m_pointView->height(), point);
    m_audioNotes->setNote(m_model,
                          point,
                          static_cast<int>(m_pointView->width()),
                          m_parameters->minFreq(),
                          m_parameters->maxFreq(),
                          m_parameters->useNotes());
}

void FunctionController::nextPointInterest()
{
    if (m_model->lineSize() == 0)
        return;

    if (m_pointsInterest == nullptr) {
        m_pointsInterest = new PointsInterest();
    }

    if (m_audioNotes == nullptr) {
        m_audioNotes = new AudioNotes();
    }

    connect(m_audioNotes, SIGNAL(finished()), this, SLOT(audioNotesFinished()));
    m_pointsInterest->nextPoint(m_audioNotes, m_currentPoint, m_pointView, m_parameters);
}

void FunctionController::previousPointInterest()
{
    if (m_model->lineSize() == 0)
        return;

    if (m_pointsInterest == nullptr) {
        m_pointsInterest = new PointsInterest();
    }

    if (m_audioNotes == nullptr) {
        m_audioNotes = new AudioNotes();
    }

    connect(m_audioNotes, SIGNAL(finished()), this, SLOT(audioNotesFinished()));
    m_pointsInterest->previousPoint(m_audioNotes, m_currentPoint, m_pointView, m_parameters);
}

void FunctionController::incStep()
{
    if (m_currentPoint == nullptr)
        return;
    if (m_textToSpeech == nullptr)
        return;
    if (m_model == nullptr)
        return;

    m_currentPoint->incStep();

    if (m_pointsInterest != nullptr) {
        m_pointsInterest->stop();
        disconnect(m_audioNotes, SIGNAL(finished()), this, SLOT(audioNotesFinished()));
    }

    double realStep = (double) m_currentPoint->step() / m_model->lineSize() * (m_model->maxX() - m_model->minX());
    m_textToSpeech->speak(tr("Step is ") + ":" + QString::number(realStep));
}

void FunctionController::decStep()
{
    if (m_currentPoint == nullptr)
        return;
    if (m_textToSpeech == nullptr)
        return;
    if (m_model == nullptr)
        return;

    m_currentPoint->decStep();

    if (m_pointsInterest != nullptr) {
        m_pointsInterest->stop();
        disconnect(m_audioNotes, SIGNAL(finished()), this, SLOT(audioNotesFinished()));
    }

    double realStep = (double) m_currentPoint->step() / m_model->lineSize() * (m_model->maxX() - m_model->minX());
    m_textToSpeech->speak(tr("Step is ") + ":" + QString::number(realStep));
}

void FunctionController::sayXCoordinate()
{
    if (m_currentPoint == nullptr)
        return;
    if (m_textToSpeech == nullptr)
        return;
    if (m_model == nullptr)
        return;

    if (m_pointsInterest != nullptr) {
        m_pointsInterest->stop();
        disconnect(m_audioNotes, SIGNAL(finished()), this, SLOT(audioNotesFinished()));
    }

    double x = m_model->x(m_currentPoint->point());

    x = round( x * 100.0) / 100;
    m_textToSpeech->speak(QString::number(x));
}

void FunctionController::sayYCoordinate()
{
    if (m_currentPoint == nullptr)
        return;
    if (m_textToSpeech == nullptr)
        return;
    if (m_model == nullptr)
        return;

    if (m_pointsInterest != nullptr) {
        m_pointsInterest->stop();
        disconnect(m_audioNotes, SIGNAL(finished()), this, SLOT(audioNotesFinished()));
    }

    if (m_model->isValid(m_currentPoint->point())) {
        double y = m_model->y(m_currentPoint->point());

        y = round( y * 100.0) / 100;

        m_textToSpeech->speak(QString::number(y));
    } else {
        m_textToSpeech->speak(tr("Not defined"));
    }
}

void FunctionController::firstPoint()
{
    stopAudio();
    m_currentPoint->reset();
}


void FunctionController::audio()
{
    if (m_pointsInterest != nullptr) {
        m_pointsInterest->stop();

        if (m_audioNotes != nullptr)
            disconnect(m_audioNotes, SIGNAL(finished()), this, SLOT(audioNotesFinished()));
    }

    if (m_model->validExpression()) {
        if (m_parameters->useNotes()) {
            startNotes();
        } else {
            startAudio();
        }

        m_currentPoint->startMoving(m_model,
                                    m_pointView->width(),
                                    m_pointView->height(),
                                    m_parameters->duration());
    }
}

void FunctionController::startAudio()
{
    if (m_pointsInterest != nullptr) {
        m_pointsInterest->stop();
        if (m_audioNotes != nullptr)
            disconnect(m_audioNotes, SIGNAL(finished()), this, SLOT(audioNotesFinished()));
    }

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
    if (m_pointsInterest != nullptr) {
        m_pointsInterest->stop();
        if (m_audioNotes != nullptr)
            disconnect(m_audioNotes, SIGNAL(finished()), this, SLOT(audioNotesFinished()));
    }

    if (m_audio != nullptr)
        m_audio->stop();
    if (m_audioNotes != nullptr)
        m_audioNotes->stopNotes();

    m_currentPoint->stop();
}

void FunctionController::stopInterestingPoint()
{
    if (m_pointsInterest != nullptr) {
        m_pointsInterest->stop();
        if (m_audioNotes != nullptr)
            disconnect(m_audioNotes, SIGNAL(finished()), this, SLOT(audioNotesFinished()));
    }
}

bool FunctionController::validExpression()
{
    if (m_model != nullptr)
        return m_model->validExpression();
    else
        return false;
}

void FunctionController::startNotes()
{
    if (m_audioNotes == nullptr)
        m_audioNotes = new AudioNotes();

    if (m_pointsInterest != nullptr) {
        m_pointsInterest->stop();
        if (m_audioNotes != nullptr)
            disconnect(m_audioNotes, SIGNAL(finished()), this, SLOT(audioNotesFinished()));
    }

    m_audioNotes->startNotes(m_model,
                             m_parameters->maxFreq(),
                             m_parameters->minFreq(),
                             m_parameters->duration());
}

void FunctionController::setTextToSpeech(TextToSpeech *textToSpeech)
{
    m_textToSpeech = textToSpeech;
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
