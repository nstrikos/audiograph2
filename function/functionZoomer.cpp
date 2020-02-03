#include "functionZoomer.h"
#include "functionModel.h"

FunctionZoomer::FunctionZoomer(QObject *parent) : QObject(parent)
{

}

void FunctionZoomer::zoom(FunctionModel &model, double delta)
{
    double factor;
    if (delta < 0)
        factor = 1.1;
    else
        factor = 0.9;

    if (model.expression() != "")
        performZoom(model, factor);
}

void FunctionZoomer::performZoom(FunctionModel &model, double factor)
{
    double minX = model.minX();//m_minX;
    double maxX = model.maxX();//m_maxX;
    double minY = model.minY();//m_minY;
    double maxY = model.maxY();//m_maxY;

    double distanceX = maxX - minX;
    double centerX = (maxX + minX) / 2;

    double distanceY = maxY - minY;
    double centerY = (maxY + minY) / 2;

    distanceX = distanceX * factor;
    distanceY = distanceY * factor;

    if ( (abs(distanceX) > 0.00001) && (abs(distanceY) > 0.00001) ) {
        double x0 = centerX - distanceX / 2;
        double x1 = centerX + distanceX / 2;
        double y0 = centerY - distanceY / 2;
        double y1 = centerY + distanceY / 2;
        model.calculate(model.expression(),
                        QString::number(x0),
                        QString::number(x1),
                        QString::number(y0),
                        QString::number((y1)));//calculatePoints();
    }

    double distance = maxX - minX;
    double power = -floor(log10(distance)) + 1;
    double ten = pow(10, power);

    if (power > 0) {
        minX = round(minX * ten) / ten;
        maxX = round(maxX * ten) / ten;
    }
    else {
        minX = round(minX);
        maxX = round(maxX);
    }

    distance = maxY - minY;
    power = -floor(log10(distance)) + 1;
    ten = pow(10, power);
    if (power > 0) {
        minY = round(minY * ten) / ten;
        maxY = round(maxY * ten) / ten;
    }
    else {
        minY = round(minY);//minY.toFixed(0);
        maxY = round(maxY);//maxY.toFixed(0);
    }

    emit newInputValues(minX, maxX, minY, maxY);
}
