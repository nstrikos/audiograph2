#include "functioncontroller.h"
#include <QDebug>

FunctionController::FunctionController(Curve &curve, QObject *parent) :
    m_curve(curve),
    QObject(parent)
{
    connect(&m_model, SIGNAL(update()), this, SLOT(updateDisplayView()));
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
    qDebug() << "update display view";
    m_curve.draw(&m_model);
}
