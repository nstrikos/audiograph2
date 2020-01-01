#include "curvemovingpoint.h"
#include "curve.h"
#include <QtQuick/qsgnode.h>
#include <QtQuick/qsgflatcolormaterial.h>
#include <cmath>

CurveMovingPoint::CurveMovingPoint(QQuickItem *parent)
    : QQuickItem(parent)
{
    setFlag(ItemHasContents, true);

    timer.setTimerType(Qt::PreciseTimer);
    timer.setInterval(50);
    connect(&timer, SIGNAL(timeout()), this, SLOT(timerExpired()));
    m_X = -20;
    m_Y = -20;
    m_newColor = m_color;
}

CurveMovingPoint::~CurveMovingPoint()
{
    qDebug() << "Curve moving point destructor called";
}

void CurveMovingPoint::drawPoint(Function *function, int duration)
{
    m_function = function;
    if (m_function->lineSize() > 0) {
        m_duration = duration * 1000;
        m_timeElapsed = 0;
        calcCoords(this->width(), this->height());
        timer.start();
    }
}

QSGNode *CurveMovingPoint::updatePaintNode(QSGNode *oldNode, UpdatePaintNodeData *)
{
    QSGGeometryNode *node = nullptr;
    QSGGeometry *geometry = nullptr;

    if (!oldNode) {
        node = new QSGGeometryNode;

        geometry = new QSGGeometry(QSGGeometry::defaultAttributes_Point2D(), POINT_SEGMENTS);
        geometry->setLineWidth(LINE_WIDTH);
        geometry->setDrawingMode(QSGGeometry::DrawTriangleFan);
        node->setGeometry(geometry);
        node->setFlag(QSGNode::OwnsGeometry);
        QSGFlatColorMaterial *material = new QSGFlatColorMaterial;
        material->setColor(m_color);
        node->setMaterial(material);
        node->setFlag(QSGNode::OwnsMaterial);

    } else {
        node = static_cast<QSGGeometryNode *>(oldNode);
        geometry = node->geometry();
        geometry->allocate(POINT_SEGMENTS);
        if (m_newColor != m_color) {
            QSGFlatColorMaterial *material = new QSGFlatColorMaterial;
            material->setColor(m_color);
            node->setMaterial(material);
            node->setFlag(QSGNode::OwnsMaterial);
            node->markDirty(QSGNode::DirtyMaterial);
        }
    }

    QSGGeometry::Point2D *lineVertices = geometry->vertexDataAsPoint2D();

    int r = m_size;
    for(int ii = 0; ii < POINT_SEGMENTS; ii++) {
        float theta = 2.0f * 3.1415926f * float(ii) / float(POINT_SEGMENTS);//get the current angle

        float x = r * cos(theta);
        float y = r * sin(theta);

        lineVertices[ii].set(x + m_X, y + m_Y);//output vertex
    }

    node->markDirty(QSGNode::DirtyGeometry);
    m_newColor = m_color;
    return node;
}

int CurveMovingPoint::size() const
{
    return m_size;
}

void CurveMovingPoint::setSize(int size)
{
    m_size = size;
}

QColor CurveMovingPoint::color() const
{
    return m_color;
}

void CurveMovingPoint::setColor(const QColor &color)
{
    m_color = color;
    qDebug() << m_color;
}

void CurveMovingPoint::timerExpired()
{
    m_timeElapsed += timer.interval();
    if (m_timeElapsed >= m_duration) {
        stopPoint();
        emit finished();
        return;
    }

    double cx = (double) m_timeElapsed / m_duration;
    int x = round(cx * LINE_POINTS);
    if (x >= LINE_POINTS)
        x = LINE_POINTS - 1;
    if (x < 0)
        x = 0;

    m_X = m_points.at(x).x;
    m_Y = m_points.at(x).y;

    update();
}

double CurveMovingPoint::slowPoint() const
{
    return m_slowPoint;
}

void CurveMovingPoint::setSlowPoint(double slowPoint)
{
    m_slowPoint = slowPoint;
    if (m_slowPoint)
        timer.setInterval(250);
    else
        timer.setInterval(50);
}

void CurveMovingPoint::setMouseX(Function *function, int mouseX)
{
    m_function = function;
    m_mouseX = mouseX;

    if (m_mouseX < 0)
        m_mouseX = 0;
    if (m_mouseX > this->width())
        m_mouseX = this->width();

    int i = round((m_mouseX / this->width()) * LINE_POINTS);
    if (i < 0)
        i = 0;
    if (i >= LINE_POINTS)
        i = LINE_POINTS - 1;

    int size = m_function->lineSize();
    double xStart = m_function->x(0);
    double xEnd = m_function->x(size - 1);
    double minY = m_function->minY();
    double maxY = m_function->maxY();
    double x =  ( this->width() / (xEnd - xStart) * (m_function->x(i) - xStart) );
    double y = ( this->height() / (maxY - minY) * (m_function->y(i) - minY) );

    y = this->height() - y;

    m_X = x;
    m_Y = y;
    update();
}

void CurveMovingPoint::setPoint(Function *function, int point)
{
    m_function = function;
    m_point = point;

    if (m_point < 0)
        m_point = 0;
    if (m_point >= LINE_POINTS)
        m_point = LINE_POINTS - 1;

    int size = m_function->lineSize();
    double xStart = m_function->x(0);
    double xEnd = m_function->x(size - 1);
    double minY = m_function->minY();
    double maxY = m_function->maxY();
    double x =  ( this->width() / (xEnd - xStart) * (m_function->x(m_point) - xStart) );
    double y = ( this->height() / (maxY - minY) * (m_function->y(m_point) - minY) );

    y = this->height() - y;

    m_X = x;
    m_Y = y;
    update();
}

void CurveMovingPoint::clearMouse()
{
    stopPoint();
}

void CurveMovingPoint::stopPoint()
{
    timer.stop();
    m_X = -20;
    m_Y = -20;
    update();
}
