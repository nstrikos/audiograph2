#ifndef CURVEINTERFACE_H
#define CURVEINTERFACE_H

#include <QColor>
//#include "function.h"
#include "function/functionmodel.h"
#include "point.h"
#include <QVector>

class CurveInterface
{

public:
    CurveInterface();
    ~CurveInterface();

protected:
    //Function *m_function;
    QVector<Point> m_points;
    void calcCoords(int width, int height);
    FunctionModel *m_model;
};

#endif // CURVEINTERFACE_H
