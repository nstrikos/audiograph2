#include "dragHandler.h"
#include "functionModel.h"

DragHandler::DragHandler()
{

}

void DragHandler::startDrag(FunctionModel &model, int x, int y)
{
    if (!model.validExpression())
        return;

    m_dragX = x;
    m_dragY = y;
    m_minX = model.minX();
    m_maxX = model.maxX();
    m_minY = model.minY();
    m_maxY = model.maxY();
}

void DragHandler::drag(FunctionModel &model, int diffX, int diffY, int width, int height)
{
    if (!model.validExpression())
        return;

    double distanceX = m_maxX - m_minX;

    int power = -floor(log10(distanceX)) + 2;
    double ten = pow(10, power);

    diffX = diffX - m_dragX;
    diffY = diffY - m_dragY;
    double diffXDouble = (double)((m_maxX - m_minX)) / (double)width * diffX;
    double diffYDouble = (double)((m_maxY - m_minY)) / (double)height * diffY;

    double minX, maxX, minY, maxY;

    if (power > 0) {
        minX = round( (m_minX - diffXDouble) * ten) / ten;
        maxX = round( (m_maxX - diffXDouble) * ten) / ten;
        minY = round( (m_minY + diffYDouble) * ten) / ten;
        maxY = round( (m_maxY + diffYDouble) * ten) / ten;
    } else {
        minX = round(m_minX - diffXDouble);
        maxX = round(m_maxX - diffXDouble);
        minY = round(m_minY + diffYDouble);
        maxY = round(m_maxY + diffYDouble);
    }

    model.calculate(model.expression(),
                    minX,
                    maxX,
                    minY,
                    maxY);
    emit newInputValues(minX, maxX, minY, maxY);
}
