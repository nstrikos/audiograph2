#ifndef CURVE_H
#define CURVE_H

#include <QtQuick/QQuickItem>
#include "curveinterface.h"

class Curve : public QQuickItem, public CurveInterface
{
    Q_OBJECT

    Q_PROPERTY(QColor color READ color WRITE setColor)
    Q_PROPERTY(int lineWidth READ lineWidth WRITE setLineWidth)

public:
    Curve(QQuickItem *parent = 0);
    ~Curve();

    Q_INVOKABLE void draw(FunctionModel *model);
    void setColor(const QColor &color);
    QColor color() const;

    int lineWidth() const;
    void setLineWidth(int lineWidth);
    Q_INVOKABLE void clear();

private:
    QSGNode *updatePaintNode(QSGNode *, UpdatePaintNodeData *);
    QColor m_color;
    QColor m_newColor;
    int m_lineWidth;
};

#endif // CURVE_H
