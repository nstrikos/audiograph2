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

    double X() const;
    double Y() const;
    double point() const;

    void setMouseX(FunctionModel *model, double width, double height, int mouseX);
    void nextPoint(FunctionModel *model, double width, double height);
    void previousPoint(FunctionModel *model, double width, double height);
    void incPoint(FunctionModel *model, double width, double height);
    void decPoint(FunctionModel *model, double width, double height);
    void update(FunctionModel *model, double width, double height);
    void startMoving(FunctionModel *model, double width, double height, int duration);
    void stop();
    void reset();

    void incStep();
    void decStep();

    int step() const;

private slots:
    void timerExpired();

private:
    void setPoint(FunctionModel *model, double width, double height, int point);
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
