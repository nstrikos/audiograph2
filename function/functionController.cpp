#include "functionController.h"

FunctionController::FunctionController(QObject *parent) : QObject(parent)
{
    m_model = new FunctionModel();
    connect(m_model, SIGNAL(update()), this, SLOT(updateDisplayView()));
    connect(m_model, SIGNAL(error()), this, SLOT(clearDisplayView()));

    m_zoomer = new FunctionZoomer();
    connect(m_zoomer, SIGNAL(newInputValues(double,double,double,double)), this, SIGNAL(newInputValues(double,double,double,double)));

    m_dragHandler = new DragHandler();
    connect(m_dragHandler, SIGNAL(newInputValues(double,double,double,double)), this, SIGNAL(newInputValues(double,double,double,double)));

    m_pinchHandler = new PinchHandler();
    connect(m_pinchHandler, SIGNAL(newInputValues(double,double,double,double)), this, SIGNAL(newInputValues(double,double,double,double)));

    m_audio = new Audio();
    m_audioNotes = new AudioNotes();
    m_textToSpeech = new TextToSpeech();

    m_pointsInterest = new PointsInterest(*m_textToSpeech);
    m_pointsInterest->setModel(m_model);

    m_currentPoint = new CurrentPoint();
    m_currentPoint->setModel(m_model);
    connect(m_currentPoint, SIGNAL(movingPointFinished()), this, SIGNAL(movingPointFinished()));

    m_parameters = &Parameters::getInstance();

    m_view = nullptr;
    m_pointView = nullptr;
}

FunctionController::~FunctionController()
{
    delete m_model;
    delete m_zoomer;
    delete m_dragHandler;
    delete m_pinchHandler;
    delete m_audio;
    delete m_audioNotes;

    delete m_pointsInterest;
    delete m_currentPoint;
    delete m_textToSpeech;
}

void FunctionController::setPointView(FunctionPointView *pointView)
{
    m_pointView = pointView;
    m_currentPoint->setWidth(m_pointView->width());
    m_currentPoint->setHeight(m_pointView->height());
    m_pointView->setCurrentPoint(m_currentPoint);
}

void FunctionController::setView(FunctionDisplayView *view)
{
    m_view = view;
}

void FunctionController::displayFunction(QString expression,
                                         QString minX,
                                         QString maxX,
                                         QString minY,
                                         QString maxY)
{
    m_model->calculate(expression, minX, maxX, minY, maxY);
    m_currentPoint->reset();
}

void FunctionController::updateDisplayView()
{
    if (m_view == nullptr)
        return;

    m_view->draw(m_model);

    emit updateFinished();
}

void FunctionController::clearDisplayView()
{
    if (m_view == nullptr)
        return;
    m_view->clear();

    emit error();
}

void FunctionController::viewDimensionsChanged()
{
    if (m_view == nullptr)
        return;
    if (m_pointView == nullptr)
        return;

    m_view->updateView();
    m_currentPoint->update(m_pointView->width(), m_pointView->height());
}

void FunctionController::zoom(double delta)
{
    m_currentPoint->reset();
    m_zoomer->zoom(*m_model, delta);
}

void FunctionController::startDrag(int x, int y)
{
    m_currentPoint->reset();
    m_dragHandler->startDrag(*m_model, x, y);
}

void FunctionController::drag(int diffX, int diffY, int width, int height)
{
    m_dragHandler->drag(*m_model, diffX, diffY, width, height);
}

void FunctionController::startPinch()
{
    m_currentPoint->reset();
    m_pinchHandler->startPinch(*m_model);
}

void FunctionController::pinch(double scale)
{
    m_pinchHandler->pinch(*m_model, scale);
}

void FunctionController::audio()
{
    if (m_parameters->useNotes())
        startNotes();
    else
        startAudio();

    m_currentPoint->startMoving(m_parameters->duration());
}

void FunctionController::startNotes()
{
    m_audioNotes->startNotes(m_model,
                             m_parameters->maxFreq(),
                             m_parameters->minFreq(),
                             m_parameters->duration());
}

void FunctionController::startAudio()
{
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
    m_audio->stop();
    m_audioNotes->stopNotes();
    m_currentPoint->stop();
}

void FunctionController::previousPoint()
{
    m_currentPoint->previousPoint();
    m_audioNotes->setNote(m_model,
                          m_currentPoint->point(),
                          m_parameters->minFreq(),
                          m_parameters->maxFreq(),
                          m_parameters->useNotes());
}

void FunctionController::nextPoint()
{
    m_currentPoint->nextPoint();
    m_audioNotes->setNote(m_model,
                          m_currentPoint->point(),
                          m_parameters->minFreq(),
                          m_parameters->maxFreq(),
                          m_parameters->useNotes());
}

void FunctionController::mousePoint(int point)
{
    m_currentPoint->setMouseX(point);
    m_audioNotes->setNote(m_model,
                          point,
                          static_cast<int>(m_pointView->width()),
                          m_parameters->minFreq(),
                          m_parameters->maxFreq(),
                          m_parameters->useNotes());
}

void FunctionController::firstPoint()
{
    stopAudio();
    m_currentPoint->reset();
}

void FunctionController::incStep()
{
    m_currentPoint->incStep();

    double realStep = (double) m_currentPoint->step() / m_model->lineSize() * (m_model->maxX() - m_model->minX());
    m_textToSpeech->speak(tr("Step is ") + ":" + QString::number(realStep));
}

void FunctionController::decStep()
{
    m_currentPoint->decStep();

    double realStep = (double) m_currentPoint->step() / m_model->lineSize() * (m_model->maxX() - m_model->minX());
    m_textToSpeech->speak(tr("Step is ") + ":" + QString::number(realStep));
}

void FunctionController::nextPointInterest()
{
    if (m_pointView == nullptr)
        return;

    m_pointsInterest->nextPoint(m_audioNotes, m_currentPoint, m_pointView);
}

void FunctionController::previousPointInterest()
{
    if (m_pointView == nullptr)
        return;

    m_pointsInterest->previousPoint(m_audioNotes, m_currentPoint, m_pointView);
}

void FunctionController::nextPointInterestFast()
{
    if (m_pointView == nullptr)
        return;

    m_pointsInterest->nextPointFast(m_currentPoint, m_pointView);
    sayYCoordinate();
}

void FunctionController::previousPointInterestFast()
{
    if (m_pointView == nullptr)
        return;

    m_pointsInterest->previousPointFast(m_currentPoint, m_pointView);
    sayYCoordinate();
}

void FunctionController::sayXCoordinate()
{
    if (m_currentPoint == nullptr)
        return;
    if (m_model == nullptr)
        return;
    if (m_model->lineSize() == 0)
        return;

    if (m_pointsInterest != nullptr) {
        m_pointsInterest->stop();
//        disconnect(m_audioNotes, SIGNAL(finished()), this, SLOT(audioNotesFinished()));
    }

    double x = m_model->x(m_currentPoint->point());

    x = round( x * 100.0) / 100;
    m_textToSpeech->speak(QString::number(x));
}

void FunctionController::sayYCoordinate()
{
    if (m_currentPoint == nullptr)
        return;
    if (m_model == nullptr)
        return;
    if (m_model->lineSize() == 0)
        return;

    if (m_pointsInterest != nullptr) {
        m_pointsInterest->stop();
//        disconnect(m_audioNotes, SIGNAL(finished()), this, SLOT(audioNotesFinished()));
    }

    if (m_model->isValid(m_currentPoint->point())) {
        double y = m_model->y(m_currentPoint->point());

        y = round( y * 100.0) / 100;

        m_textToSpeech->speak(QString::number(y));
    } else {
        m_textToSpeech->speak(tr("Not defined"));
    }
}

void FunctionController::nextPointY()
{
    m_currentPoint->nextPoint();
    sayYCoordinate();
}

void FunctionController::previousPointY()
{
    m_currentPoint->previousPoint();
    sayYCoordinate();
}

void FunctionController::stopInterestingPoint()
{
    m_pointsInterest->stop();
}

bool FunctionController::validExpression()
{
    return m_model->validExpression();
}

double FunctionController::minX()
{
    if (m_model->lineSize() > 0)
        return m_model->minX();
    else
        return -10;
}

double FunctionController::maxX()
{
    if (m_model->lineSize() > 0)
        return m_model->maxX();
    else
        return 10;
}

double FunctionController::minY()
{
    if (m_model->lineSize() > 0)
        return m_model->minY();
    else
        return -10;
}

double FunctionController::maxY()
{
    if (m_model->lineSize() > 0)
        return m_model->maxY();
    else
        return 10;
}

QString FunctionController::getError()
{
    if (m_model != nullptr)
        return m_model->getError();
    else
        return (tr("Empty expression"));
}
