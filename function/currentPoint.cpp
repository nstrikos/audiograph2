#include "currentPoint.h"

#include "constants.h"

CurrentPoint::CurrentPoint()
{
    m_point = 0;
    m_X = -20;
    m_Y = -20;
    m_step = 10;
    timer.setTimerType(Qt::PreciseTimer);
    timer.setInterval(50);
    connect(&timer, SIGNAL(timeout()), this, SLOT(timerExpired()));
}

double CurrentPoint::X() const
{
    return m_X;
}

double CurrentPoint::Y() const
{
    return m_Y;
}

double CurrentPoint::point() const
{
    return m_point;
}

void CurrentPoint::setMouseX(FunctionModel *model, double width, double height, int mouseX)
{
    int m_mouseX = mouseX;

    if (m_mouseX < 0)
        m_mouseX = 0;
    if (m_mouseX > width)
        m_mouseX = static_cast<int>(width);

    int i = round((m_mouseX / width) * LINE_POINTS);
    if (i < 0)
        i = 0;
    if (i >= LINE_POINTS)
        i = LINE_POINTS - 1;

    m_point = i;

    int size = model->lineSize();
    double xStart = model->x(0);
    double xEnd = model->x(size - 1);
    double minY = model->minY();
    double maxY = model->maxY();
    double x =  ( width / (xEnd - xStart) * (model->x(i) - xStart) );
    double y = ( height / (maxY - minY) * (model->y(i) - minY) );

    y = height - y;

    m_X = x;
    m_Y = y;
}

void CurrentPoint::nextPoint(FunctionModel *model, double width, double height)
{
    m_point += m_step;

    if (m_point >= LINE_POINTS)
        m_point = LINE_POINTS - 1;

    setPoint(model, width, height, m_point);
}

void CurrentPoint::previousPoint(FunctionModel *model, double width, double height)
{
    m_point -= m_step;

    if (m_point < 0)
        m_point = 0;

    setPoint(model, width, height, m_point);
}

void CurrentPoint::incPoint(FunctionModel *model, double width, double height)
{
    m_point++;

    if (m_point >= LINE_POINTS)
        m_point = LINE_POINTS - 1;

    setPoint(model, width, height, m_point);
}

void CurrentPoint::decPoint(FunctionModel *model, double width, double height)
{
    m_point--;

    if (m_point <= 0)
        m_point = 0;

    setPoint(model, width, height, m_point);
}

void CurrentPoint::update(FunctionModel *model, double width, double height)
{
    int size = model->lineSize();
    double xStart = model->x(0);
    double xEnd = model->x(size - 1);
    double minY = model->minY();
    double maxY = model->maxY();
    double x =  ( width / (xEnd - xStart) * (model->x(m_point) - xStart) );
    double y = ( height / (maxY - minY) * (model->y(m_point) - minY) );

    y = height - y;

    m_X = x;
    m_Y = y;
}

void CurrentPoint::startMoving(FunctionModel *model, double width, double height, int duration)
{
    m_model = model;
    m_width = width;
    m_height = height;
    m_duration = duration * 1000;
    m_timeElapsed = 0;
    timer.start();
}

void CurrentPoint::timerExpired()
{
    m_timeElapsed += timer.interval();
    if (m_timeElapsed >= m_duration) {
        stop();
        return;
    }

    double cx = (double) m_timeElapsed / m_duration;
    int i = round(cx * LINE_POINTS);
    if (i >= LINE_POINTS)
        i = LINE_POINTS - 1;
    if (i < 0)
        i = 0;

    double minY = m_model->minY();
    double maxY = m_model->maxY();
    double xStart = m_model->minX();
    double xEnd = m_model->maxX();

    double x =  ( m_width / (xEnd - xStart) * (m_model->x(i) - xStart) );
    double y = ( m_height / (maxY - minY) * (m_model->y(i) - minY) );

    y = m_height - y;

    m_X = x;
    m_Y = y;
}

void CurrentPoint::setPoint(FunctionModel *model, double width, double height, int point)
{
    int size = model->lineSize();
    double xStart = model->x(0);
    double xEnd = model->x(size - 1);
    double minY = model->minY();
    double maxY = model->maxY();
    double x =  ( width / (xEnd - xStart) * (model->x(point) - xStart) );
    double y = ( height / (maxY - minY) * (model->y(point) - minY) );

    y = height - y;

    m_X = x;
    m_Y = y;
}

int CurrentPoint::step() const
{
    return m_step;
}

void CurrentPoint::stop()
{
    timer.stop();
    m_X = -20;
    m_Y = -20;
}

void CurrentPoint::reset()
{
    m_point = 0;
    m_X = -20;
    m_Y = -20;
}

void CurrentPoint::incStep()
{
    if (m_step == 1) {
        m_step = 10;
        return;
    }

    m_step += 10;
    m_step = round(m_step);
    if (m_step > 100)
        m_step = 100;
}

void CurrentPoint::decStep()
{
    m_step -= 10;
    m_step = round(m_step);
    if (m_step < 1)
        m_step = 1;
}
