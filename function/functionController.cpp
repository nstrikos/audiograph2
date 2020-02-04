#include "functionController.h"

FunctionController::FunctionController(QObject *parent) : QObject(parent)
{
    m_view = nullptr;
    m_model = nullptr;
    m_dragHandler = nullptr;
    m_zoomer = nullptr;
    m_pinchHandler = nullptr;
    m_audio = nullptr;
}

FunctionController::~FunctionController()
{
    //    delete m_zoomer;
    //    delete m_pinchHandler;
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
}

void FunctionController::updateView()
{
    if (m_view == nullptr)
        return;
    m_view->updateView();
}

void FunctionController::updateDisplayView()
{
    if (m_view != nullptr)
        m_view->draw(m_model);
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

void FunctionController::zoom(double delta)
{
    if (m_model == nullptr)
        return;

    if (m_zoomer == nullptr) {
        m_zoomer = new FunctionZoomer();
        connect(m_zoomer, SIGNAL(newInputValues(double,double,double,double)), this, SIGNAL(newInputValues(double,double,double,double)));
    }
    m_zoomer->zoom(*m_model, delta);
}

void FunctionController::startDrag(int x, int y)
{
    if (m_model == nullptr)
        return;

    if (m_dragHandler == nullptr) {
        m_dragHandler = new DragHandler();
        connect(m_dragHandler, SIGNAL(newInputValues(double,double,double,double)), this, SIGNAL(newInputValues(double,double,double,double)));
    }

    m_dragHandler->startDrag(*m_model, x, y);
}

void FunctionController::drag(int diffX, int diffY, int width, int height)
{
    if (m_model == nullptr)
        return;

    m_dragHandler->drag(*m_model, diffX, diffY, width, height);
}

void FunctionController::startPinch()
{
    if (m_model == nullptr)
        return;

    if (m_pinchHandler == nullptr) {
        m_pinchHandler = new PinchHandler();
        connect(m_pinchHandler, SIGNAL(newInputValues(double,double,double,double)), this, SIGNAL(newInputValues(double,double,double,double)));
    }

    m_pinchHandler->startPinch(*m_model);
}

void FunctionController::pinch(double scale)
{
    if (m_model == nullptr)
        return;

    m_pinchHandler->pinch(*m_model, scale);
}

void FunctionController::startAudio()
{
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
    if (m_audio != nullptr)
        m_audio->stop();
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
