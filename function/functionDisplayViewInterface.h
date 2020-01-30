#ifndef FUNCTIONDISPLAYVIEWINTERFACE_H
#define FUNCTIONDISPLAYVIEWINTERFACE_H

#include <QVector>
#include "functionModel.h"

class FunctionDisplayViewInterface
{
public:
    FunctionDisplayViewInterface();
    ~FunctionDisplayViewInterface();

protected:
    QVector<Point> m_points;
    void calcCoords(int width, int height);
    FunctionModel *m_model;
};

#endif // FUNCTIONDISPLAYVIEWINTERFACE_H
