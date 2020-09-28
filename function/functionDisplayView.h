#ifndef FUNCTIONDISPLAYVIEW_H
#define FUNCTIONDISPLAYVIEW_H


#include <QtQuick/QQuickItem>
#include "functionDisplayViewInterface.h"

class FunctionDisplayView : public QQuickItem, public FunctionDisplayViewInterface
{
    Q_OBJECT

    Q_PROPERTY(QColor color READ color WRITE setColor)
    Q_PROPERTY(int lineWidth READ lineWidth WRITE setLineWidth)

public:
    FunctionDisplayView(QQuickItem *parent = nullptr);
    ~FunctionDisplayView () override;

    void updateView();

    void draw(FunctionModel *model);
    void drawDerivative(FunctionModel *model);
    void clear();

    void setColor(const QColor &color);
    QColor color() const;

    int lineWidth() const;
    void setLineWidth(int lineWidth);

private:
    QSGNode *updatePaintNode(QSGNode *, UpdatePaintNodeData *) override;
    QColor m_color;
    QColor m_newColor;
    int m_lineWidth;
    int m_factor;
};

#endif // FUNCTIONDISPLAYVIEW_H
