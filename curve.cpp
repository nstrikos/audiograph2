#include "curve.h"

#include <QtQuick/qsgnode.h>
#include <QtQuick/qsgflatcolormaterial.h>

#include <cmath>

Curve::Curve(QQuickItem *parent)
    : QQuickItem(parent)
{
    setFlag(ItemHasContents, true);
    m_newColor = m_color;
    m_lineWidth = 10;
}

Curve::~Curve()
{
    qDebug() << "Curve destructor called";
}

void Curve::draw(Function *function)
{
    m_function = function;
    calcCoords(this->width(), this->height());
    update();
}

QSGNode *Curve::updatePaintNode(QSGNode *oldNode, UpdatePaintNodeData *)
{
    QSGGeometryNode *node = nullptr;
    QSGGeometry *geometry = nullptr;

#ifdef Q_OS_ANDROID
    QVector<QSGGeometryNode*> nodeVector;
    QVector<QSGGeometry*> geometryVector;
#endif

    if (!oldNode) {
        node = new QSGGeometryNode;

#ifndef Q_OS_ANDROID
        geometry = new QSGGeometry(QSGGeometry::defaultAttributes_Point2D(), LINE_POINTS);
#else
        geometry = new QSGGeometry(QSGGeometry::defaultAttributes_Point2D(), 1);
#endif

        geometry->setLineWidth(m_lineWidth);
        geometry->setDrawingMode(QSGGeometry::DrawPoints);
        node->setGeometry(geometry);
        node->setFlag(QSGNode::OwnsGeometry);
        QSGFlatColorMaterial *material = new QSGFlatColorMaterial;
        material->setColor(m_color);
        node->setMaterial(material);
        node->setFlag(QSGNode::OwnsMaterial);

#ifdef Q_OS_ANDROID
        for (int i = 0; i < LINE_POINTS; i++) {
            QSGGeometryNode *tmpNode = new QSGGeometryNode;
            QSGGeometry *tmpGeometry = new QSGGeometry(QSGGeometry::defaultAttributes_Point2D(), 16);
            tmpGeometry->setDrawingMode(QSGGeometry::DrawTriangleFan);
            tmpNode->setGeometry(tmpGeometry);
            QSGFlatColorMaterial *tmpMaterial = new QSGFlatColorMaterial;
            tmpMaterial->setColor(m_color);
            tmpNode->setMaterial(tmpMaterial);
            tmpNode->setFlag(QSGNode::OwnsMaterial);
            node->appendChildNode(tmpNode);
        }
#endif

    } else {
        node = static_cast<QSGGeometryNode *>(oldNode);
        geometry = node->geometry();
        geometry->setLineWidth(m_lineWidth);
        if (m_newColor != m_color) {
            QSGFlatColorMaterial *material = new QSGFlatColorMaterial;
            material->setColor(m_color);
            node->setMaterial(material);
            node->setFlag(QSGNode::OwnsMaterial);
            node->markDirty(QSGNode::DirtyMaterial);
        }
#ifndef Q_OS_ANDROID
        geometry->allocate(LINE_POINTS);
#else
        geometry->allocate(1);
#endif

#ifdef Q_OS_ANDROID
        for (int i = 0; i < LINE_POINTS; i++) {
            QSGGeometryNode *tmpNode = static_cast<QSGGeometryNode *>(oldNode->childAtIndex(i));
            nodeVector.append(tmpNode);
            QSGGeometry *tmpGeometry = tmpNode->geometry();
            tmpGeometry->allocate(POINT_SEGMENTS);
            tmpGeometry->setDrawingMode(QSGGeometry::DrawTriangleFan);
            geometryVector.append(tmpGeometry);
        }
#endif
    }

    QSGGeometry::Point2D *lineVertices = geometry->vertexDataAsPoint2D();

#ifndef Q_OS_ANDROID
    if (m_function != nullptr) {
        for (int i = 0; i < LINE_POINTS; i++)
            lineVertices[i].set(m_points[i].x, m_points[i].y);
    } else {
        for (int i = 0; i < LINE_POINTS; i++)
            lineVertices[i].set(-10, -10);
    }
#else
    lineVertices[0].set(-10, -10);
#endif

#ifdef Q_OS_ANDROID
    if (m_function != nullptr) {
        if (geometryVector.size() > 0) {
            if (m_points.size() > 0) {
                for (int i = 0; i < LINE_POINTS; i++) {
                    QSGGeometryNode *tmpNode = nodeVector.at(i);
                    QSGGeometry::Point2D *vertices = geometryVector.at(i)->vertexDataAsPoint2D();
                    if (m_newColor != m_color) {
                        QSGFlatColorMaterial *material = new QSGFlatColorMaterial;
                        material->setColor(m_color);
                        tmpNode->setMaterial(material);
                        tmpNode->setFlag(QSGNode::OwnsMaterial);
                        tmpNode->markDirty(QSGNode::DirtyMaterial);
                    }


                    int cx;
                    int cy;
                    cx = m_points[i].x;
                    cy = m_points[i].y;

                    int r = 5;
                    for(int ii = 0; ii < POINT_SEGMENTS; ii++) {
                        float theta = 2.0f * 3.1415926f * float(ii) / float(POINT_SEGMENTS);//get the current angle

                        float x = r * cos(theta);
                        float y = r * sin(theta);

                        vertices[ii].set(x + cx, y + cy);//output vertex
                    }
                    tmpNode->markDirty(QSGNode::DirtyGeometry);
                }
            }
        }
    }
#endif

    node->markDirty(QSGNode::DirtyGeometry);
    m_newColor = m_color;
    return node;
}

int Curve::lineWidth() const
{
    return m_lineWidth;
}

void Curve::setLineWidth(int lineWidth)
{
    m_lineWidth = lineWidth;
    update();
    qDebug() << lineWidth;
}

QColor Curve::color() const
{
    return m_color;
}

void Curve::setColor(const QColor &color)
{
    m_color = color;
    update();
}
