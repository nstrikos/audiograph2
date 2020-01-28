#ifndef FUNCTIONCONTROLLER_H
#define FUNCTIONCONTROLLER_H

#include <QObject>
#include "functionmodel.h"
#include "curve.h"

class FunctionController : public QObject
{
    Q_OBJECT
public:
    explicit FunctionController(Curve &curve, QObject *parent = nullptr);
    Q_INVOKABLE void displayFunction(QString expression,
                                     QString minX,
                                     QString maxX,
                                     QString minY,
                                     QString maxY);

private slots:
    void updateDisplayView();

private:
    FunctionModel m_model;
    Curve &m_curve;
};

#endif // FUNCTIONCONTROLLER_H
