#include "functionPointView.h"

#include <QtQuick/qsgnode.h>
#include <QtQuick/qsgflatcolormaterial.h>
#include <cmath>
#include "constants.h"

FunctionPointView::FunctionPointView(QQuickItem *parent)
    : QQuickItem(parent)
{
    setFlag(ItemHasContents, true);

//    timer.setTimerType(Qt::PreciseTimer);
    timer.setInterval(50);
    connect(&timer, SIGNAL(timeout()), this, SLOT(timerExpired()));
    m_X = -20;
    m_Y = -20;
    m_newColor = m_color;

    timer2.setInterval(50);
    connect(&timer2, SIGNAL(timeout()), this, SLOT(update()));
    timer2.start();
}

FunctionPointView::~FunctionPointView()
{

}

void FunctionPointView::drawPoint(FunctionModel *model, int duration)
{
//    m_function = function;
    m_model = model;
    if (m_model->lineSize() > 0) {
        m_duration = duration * 1000;
        m_timeElapsed = 0;
        calcCoords(static_cast<int>(this->width()), static_cast<int>(this->height()));
        timer.start();
    }
}

QSGNode *FunctionPointView::updatePaintNode(QSGNode *oldNode, UpdatePaintNodeData *)
{
    QSGGeometryNode *node = nullptr;
    QSGGeometry *geometry = nullptr;

    if (!oldNode) {
        node = new QSGGeometryNode;

        geometry = new QSGGeometry(QSGGeometry::defaultAttributes_Point2D(), POINT_SEGMENTS);
//        geometry->setLineWidth(2);
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
//        if (m_newColor != m_color) {
//            QSGFlatColorMaterial *material = new QSGFlatColorMaterial;
//            material->setColor(m_color);
//            node->setMaterial(material);
//            node->setFlag(QSGNode::OwnsMaterial);
//            node->markDirty(QSGNode::DirtyMaterial);
//        }
    }

    QSGGeometry::Point2D *lineVertices = geometry->vertexDataAsPoint2D();

    int r = m_size;
    for(int ii = 0; ii < POINT_SEGMENTS; ii++) {
        float theta = 2.0f * 3.1415926f * float(ii) / float(POINT_SEGMENTS);//get the current angle

        float x = r * cos(theta);
        float y = r * sin(theta);

        lineVertices[ii].set(x + m_X, y + m_Y);//output vertex
    }
//    lineVertices[0].set(m_X, 0);
//    lineVertices[1].set(m_X, height());

    node->markDirty(QSGNode::DirtyGeometry);
    m_newColor = m_color;
    return node;
}

int FunctionPointView::size() const
{
    return m_size;
}

void FunctionPointView::setSize(int size)
{
    m_size = size;
}

QColor FunctionPointView::color() const
{
    return m_color;
}

void FunctionPointView::setColor(const QColor &color)
{
    m_color = color;
}

void FunctionPointView::timerExpired()
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

//    update();
}

double FunctionPointView::slowPoint() const
{
    return m_slowPoint;
}

void FunctionPointView::setSlowPoint(double slowPoint)
{
    m_slowPoint = slowPoint;
    if (m_slowPoint)
        timer.setInterval(250);
    else
        timer.setInterval(50);
}

void FunctionPointView::setMouseX(FunctionModel *model, int mouseX)
{
    //m_function = function;
    m_model = model;
    m_mouseX = mouseX;

    if (m_mouseX < 0)
        m_mouseX = 0;
    if (m_mouseX > this->width())
        m_mouseX = static_cast<int>(this->width());

    int i = round((m_mouseX / this->width()) * LINE_POINTS);
    if (i < 0)
        i = 0;
    if (i >= LINE_POINTS)
        i = LINE_POINTS - 1;

    int size = m_model->lineSize();
    double xStart = m_model->x(0);
    double xEnd = m_model->x(size - 1);
    double minY = m_model->minY();
    double maxY = m_model->maxY();
    double x =  ( this->width() / (xEnd - xStart) * (m_model->x(i) - xStart) );
    double y = ( this->height() / (maxY - minY) * (m_model->y(i) - minY) );

    y = this->height() - y;

    m_X = x;
    m_Y = y;
//    update();
}

void FunctionPointView::setPoint(FunctionModel *model, int point)
{
    //m_function = function;
    m_model = model;
    m_point = point;

    if (m_point < 0)
        m_point = 0;
    if (m_point >= LINE_POINTS)
        m_point = LINE_POINTS - 1;

    int size = m_model->lineSize();
    double xStart = m_model->x(0);
    double xEnd = m_model->x(size - 1);
    double minY = m_model->minY();
    double maxY = m_model->maxY();
    double x =  ( this->width() / (xEnd - xStart) * (m_model->x(m_point) - xStart) );
    double y = ( this->height() / (maxY - minY) * (m_model->y(m_point) - minY) );

    y = this->height() - y;

    m_X = x;
    m_Y = y;
//    update();
}

void FunctionPointView::clearMouse()
{
    stopPoint();
}

void FunctionPointView::stopPoint()
{
    timer.stop();
    m_X = -20;
    m_Y = -20;
    update();
}
