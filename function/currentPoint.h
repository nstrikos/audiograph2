#ifndef CURRENTPOINT_H
#define CURRENTPOINT_H

#include <QObject>
#include "functionModel.h"
#include <QTimer>

class CurrentPoint : public QObject
{
        Q_OBJECT
public:
    CurrentPoint();

    void setWidth(double width);
    void setHeight(double height);
    void setModel(FunctionModel *model);

    void setMouseX(int mouseX);
    void setPoint(int point);
    void nextPoint();
    void previousPoint();
    void incPoint();
    void decPoint();
    void update(double width, double height);
    void startMoving(int duration);
    void stop();
    void reset();

    void incStep();
    void decStep();

    int step() const;

    double X() const;
    double Y() const;
    double point() const;

signals:
    void movingPointFinished();

private slots:
    void timerExpired();

private:
    double m_X;
    double m_Y;
    double m_point;
    int m_step;
    QTimer timer;
    int m_timeElapsed;
    int m_duration;
    FunctionModel *m_model;
    double m_width;
    double m_height;
};

#endif // CURRENTPOINT_H
