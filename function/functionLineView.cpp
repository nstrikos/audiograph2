#include "functionLineView.h"

#include <QtQuick/qsgnode.h>
#include "constants.h"

FunctionLineView::FunctionLineView(QQuickItem *parent)
    : QQuickItem(parent)
{
    setFlag(ItemHasContents, true);

    m_timer.setInterval(50);
    connect(&m_timer, SIGNAL(timeout()), this, SLOT(update()));
    m_timer.start();
}

FunctionLineView::~FunctionLineView()
{

}

void FunctionLineView::setCurrentPoint(CurrentPoint *point)
{
    m_currentPoint = point;
}

QSGNode *FunctionLineView::updatePaintNode(QSGNode *oldNode, UpdatePaintNodeData *)
{
    QSGGeometryNode *node = nullptr;
    QSGGeometry *geometry = nullptr;

    if (!oldNode) {
        node = new QSGGeometryNode;

        geometry = new QSGGeometry(QSGGeometry::defaultAttributes_Point2D(), 2);
        geometry->setDrawingMode(QSGGeometry::DrawLines);
        geometry->setLineWidth(m_size);
        node->setGeometry(geometry);
        node->setFlag(QSGNode::OwnsGeometry);
        m_material = new QSGFlatColorMaterial;
        m_material->setColor(m_color);
        node->setMaterial(m_material);
        node->setFlag(QSGNode::OwnsMaterial);
    } else {
        node = static_cast<QSGGeometryNode *>(oldNode);
        geometry = node->geometry();
        geometry->allocate(2);
        geometry->setLineWidth(m_size);
        m_material->setColor(m_color);
        node->setMaterial(m_material);
        node->setFlag(QSGNode::OwnsMaterial);
    }

    QSGGeometry::Point2D *lineVertices = geometry->vertexDataAsPoint2D();


    if (m_currentPoint != nullptr && m_currentPoint->X() != 0 ) {
        lineVertices[0].set(m_currentPoint->X(), 0);//output vertex
        lineVertices[1].set(m_currentPoint->X(), this->height());
    }
    else {
        lineVertices[0].set(-20, -20);
        lineVertices[1].set(-20, -20);
    }

    node->markDirty(QSGNode::DirtyGeometry);
    node->markDirty(QSGNode::DirtyMaterial);
    return node;
}

int FunctionLineView::size() const
{
    return m_size;
}

void FunctionLineView::setSize(int size)
{
    m_size = size / 4;
}

QColor FunctionLineView::color() const
{
    return m_color;
}

void FunctionLineView::setColor(const QColor &color)
{
    m_color = color;
}
