#ifndef FUNCTIONLINEVIEW_H
#define FUNCTIONLINEVIEW_H

#include <QtQuick/QQuickItem>
#include "currentPoint.h"
#include <QTimer>
#include <QtQuick/qsgflatcolormaterial.h>

class FunctionLineView : public QQuickItem
{
    Q_OBJECT

    Q_PROPERTY(QColor color READ color WRITE setColor)
    Q_PROPERTY(int size READ size WRITE setSize)

public:
    FunctionLineView(QQuickItem *parent = 0);
    ~FunctionLineView();
    void setCurrentPoint(CurrentPoint *point);

    QColor color() const;
    void setColor(const QColor &color);

    int size() const;
    void setSize(int size);

private:
    QSGNode *updatePaintNode(QSGNode *, UpdatePaintNodeData *);

    double m_X;
    double m_Y;
    QTimer m_timer;
    QColor m_color;
    int m_size;
    CurrentPoint *m_currentPoint;
    QSGFlatColorMaterial *m_material;
};



#endif // FUNCTIONLINEVIEW_H
