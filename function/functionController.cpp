#include "functionController.h"

FunctionController::FunctionController(QObject *parent) : QObject(parent)
{
    m_view = nullptr;
    connect(&m_model, SIGNAL(update()), this, SLOT(updateDisplayView()));
    connect(&m_model, SIGNAL(error(QString)), this, SLOT(clearDisplayView()));
    connect(&m_model, SIGNAL(error(QString)), this, SIGNAL(error()));
}

void FunctionController::displayFunction(QString expression,
                                         QString minX,
                                         QString maxX,
                                         QString minY,
                                         QString maxY)
{
    m_model.calculate(expression, minX, maxX, minY, maxY);
}

void FunctionController::updateDisplayView()
{
    if (m_view != nullptr)
        m_view->draw(&m_model);
    emit updateFinished();
}

void FunctionController::clearDisplayView()
{
    if (m_view != nullptr)
        m_view->clear();
}

void FunctionController::setDisplayView(FunctionDisplayView *view)
{
    m_view = view;
}

void FunctionController::zoom(double delta)
{
    m_model.zoom(delta);
}

double FunctionController::minX()
{
    return m_model.minX();
}

double FunctionController::maxX()
{
    return m_model.maxX();
}

double FunctionController::minY()
{
    return m_model.minY();
}

double FunctionController::maxY()
{
    return m_model.maxY();
}
