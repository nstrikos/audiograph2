#include "currentPoint.h"

#include "constants.h"

CurrentPoint::CurrentPoint()
{
    m_model = nullptr;
    m_point = 0;
    m_width = -1;
    m_height = -1;
    m_X = -20;
    m_Y = -20;
    m_step = 10;
    timer.setTimerType(Qt::PreciseTimer);
    timer.setInterval(50);
    connect(&timer, SIGNAL(timeout()), this, SLOT(timerExpired()));
}

void CurrentPoint::setModel(FunctionModel *model)
{
    m_model = model;
}

void CurrentPoint::setHeight(double height)
{
    m_height = height;
}

void CurrentPoint::setWidth(double width)
{
    m_width = width;
}

void CurrentPoint::setMouseX(int mouseX)
{
    if (m_width == -1 || m_height == -1)
        return;

    if (m_model == nullptr)
        return;

    int m_mouseX = mouseX;

    if (m_mouseX < 0)
        m_mouseX = 0;
    if (m_mouseX > m_width)
        m_mouseX = static_cast<int>(m_width);

    int i = round((m_mouseX / m_width) * LINE_POINTS);
    if (i < 0)
        i = 0;
    if (i >= LINE_POINTS)
        i = LINE_POINTS - 1;

    m_point = i;

    int size = m_model->lineSize();
    if (size == 0)
        return;
    double xStart = m_model->x(0);
    double xEnd = m_model->x(size - 1);
    double minY = m_model->minY();
    double maxY = m_model->maxY();

    double x, y;
    if (m_mode == 0) {
        x =  ( m_width / (xEnd - xStart) * (m_model->x(i) - xStart) );
        y = ( m_height / (maxY - minY) * (m_model->y(i) - minY) );
    } else if (m_mode == 1) {
        x =  ( m_width / (xEnd - xStart) * (m_model->x(i) - xStart) );
        y = ( m_height / (maxY - minY) * (m_model->derivative(i) - minY) );
    } else if (m_mode == 2) {
        x =  ( m_width / (xEnd - xStart) * (m_model->x(i) - xStart) );
        y = ( m_height / (maxY - minY) * (m_model->derivative2(i) - minY) );
    }

    y = m_height - y;

    m_X = x;
    m_Y = y;
}

void CurrentPoint::nextPoint()
{
    if (m_width == -1 || m_height == -1)
        return;

    if (m_model == nullptr)
        return;

    if (m_model->lineSize() == 0)
        return;

    m_point += m_step;

    if (m_point >= LINE_POINTS)
        m_point = LINE_POINTS - 1;

    setPoint(m_point);
}

void CurrentPoint::previousPoint()
{
    if (m_width == -1 || m_height ==- -1)
        return;

    if (m_model == nullptr)
        return;

    if (m_model->lineSize() == 0)
        return;

    m_point -= m_step;

    if (m_point < 0)
        m_point = 0;

    setPoint(m_point);
}

void CurrentPoint::incPoint()
{
    if (m_width == -1 || m_height == -1)
        return;

    if (m_model == nullptr)
        return;

    m_point++;

    if (m_point >= LINE_POINTS)
        m_point = LINE_POINTS - 1;

    setPoint(m_point);
}

void CurrentPoint::decPoint()
{
    if (m_width == -1 || m_height == -1)
        return;

    if (m_model == nullptr)
        return;

    m_point--;

    if (m_point <= 0)
        m_point = 0;

    setPoint(m_point);
}

void CurrentPoint::update(double width, double height)
{
    m_width = width;
    m_height = height;

    if (m_width == -1 || m_height == -1)
        return;

    if (m_model == nullptr)
        return;

    int size = m_model->lineSize();
    if (size == 0)
        return;
    double xStart = m_model->x(0);
    double xEnd = m_model->x(size - 1);
    double minY = m_model->minY();
    double maxY = m_model->maxY();
    double x, y;
    if (m_mode == 0) {
        x =  ( m_width / (xEnd - xStart) * (m_model->x(m_point) - xStart) );
        y = ( m_height / (maxY - minY) * (m_model->y(m_point) - minY) );
    } else if (m_mode == 1) {
        x =  ( m_width / (xEnd - xStart) * (m_model->x(m_point) - xStart) );
        y = ( m_height / (maxY - minY) * (m_model->derivative(m_point) - minY) );
    } else if (m_mode == 2) {
        x =  ( m_width / (xEnd - xStart) * (m_model->x(m_point) - xStart) );
        y = ( m_height / (maxY - minY) * (m_model->derivative2(m_point) - minY) );
    }

    y = m_height - y;

    m_X = x;
    m_Y = y;
}

void CurrentPoint::startMoving(int duration)
{
    if (m_width == -1 || m_height == -1)
        return;

    if (m_model == nullptr)
        return;

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



    double x, y;
    if (m_mode == 0) {
        x =  ( m_width / (xEnd - xStart) * (m_model->x(i) - xStart) );
        y = ( m_height / (maxY - minY) * (m_model->y(i) - minY) );
    } else if (m_mode == 1) {
        x =  ( m_width / (xEnd - xStart) * (m_model->x(i) - xStart) );
        y = ( m_height / (maxY - minY) * (m_model->derivative(i) - minY) );
    } else if (m_mode == 2) {
        x =  ( m_width / (xEnd - xStart) * (m_model->x(i) - xStart) );
        y = ( m_height / (maxY - minY) * (m_model->derivative2(i) - minY) );
    }

    y = m_height - y;

    m_X = x;
    m_Y = y;
}

void CurrentPoint::setMode(int mode)
{
    m_mode = mode;
}

void CurrentPoint::setPoint(int point)
{
    if (m_width == -1 || m_height == -1)
        return;

    if (m_model == nullptr)
        return;

    if (m_model->lineSize() == 0)
        return;

    int size = m_model->lineSize();
    double xStart = m_model->x(0);
    double xEnd = m_model->x(size - 1);
    double minY = m_model->minY();
    double maxY = m_model->maxY();

    double x, y;
    if (m_mode == 0) {
        x =  ( m_width / (xEnd - xStart) * (m_model->x(point) - xStart) );
        y = ( m_height / (maxY - minY) * (m_model->y(point) - minY) );
    } else if (m_mode == 1) {
        x =  ( m_width / (xEnd - xStart) * (m_model->x(point) - xStart) );
        y = ( m_height / (maxY - minY) * (m_model->derivative(point) - minY) );
    } else if (m_mode == 2) {
        x =  ( m_width / (xEnd - xStart) * (m_model->x(point) - xStart) );
        y = ( m_height / (maxY - minY) * (m_model->derivative2(point) - minY) );
    }

    y = m_height - y;

    m_point = point;
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
    emit movingPointFinished();
}

void CurrentPoint::reset()
{
    m_point = 0;
    m_X = -200;
    m_Y = -200;
}

void CurrentPoint::endPoint()
{
    if (m_model->lineSize() > 0)
        m_point = m_model->lineSize() - 1;
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
