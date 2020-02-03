#include "pinchHandler.h"

#include "functionModel.h"

PinchHandler::PinchHandler(QObject *parent) : QObject(parent)
{

}

void PinchHandler::startPinch(FunctionModel &model)
{
    if (model.expression() != "") {
        m_minX = model.minX();
        m_maxX = model.maxX();
        m_minY = model.minY();
        m_maxY = model.maxY();
    }
}

void PinchHandler::pinch(FunctionModel &model, double scale)
{
    scale = 1 / scale;

    double distanceX = m_maxX - m_minX;
    double centerX = (m_maxX + m_minX) / 2;

    int power = -floor(log10(distanceX)) + 2;
    double ten = pow(10, power);

    double distanceY = m_maxY - m_minY;
    double centerY = (m_maxY + m_minY) / 2;


    distanceX = distanceX * scale;
    distanceY = distanceY * scale;

    double minX = centerX - distanceX / 2;
    double maxX = centerX + distanceX / 2;
    double minY = centerY - distanceY / 2;
    double maxY = centerY + distanceY / 2;

    model.calculate(model.expression(),
                    minX,
                    maxX,
                    minY,
                    maxY);

    minX = round(minX * ten) / ten;
    maxX = round(maxX * ten) / ten;
    minY = round(minY * ten) / ten;
    maxY = round(maxY * ten) / ten;

    emit newInputValues(minX, maxX, minY, maxY);
}
