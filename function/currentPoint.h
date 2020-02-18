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
    void setMouseX(FunctionModel *model, double width, double height, int mouseX);
    void nextPoint(FunctionModel *model, double width, double height);
    void previousPoint(FunctionModel *model, double width, double height);
    void incPoint(FunctionModel *model, double width, double height);
    void decPoint(FunctionModel *model, double width, double height);
    void update(FunctionModel *model, double width, double height);
    void startMoving(FunctionModel *model, double width, double height, int duration);
    void reset();
    void stop();

    double point() const;

signals:
    void finished();

private slots:
    void timerExpired();

private:
    double m_X;
    double m_Y;
    double m_point;
    QTimer timer;
    int m_timeElapsed;
    void setPoint(FunctionModel *model, double width, double height, int point);
    int m_duration;
    FunctionModel *m_model;
    double m_width;
    double m_height;
};

#endif // CURRENTPOINT_H
