#ifndef POINTSINTEREST_H
#define POINTSINTEREST_H

#include <QObject>
#include <QVector>
#include <QTimer>
#include <curvemovingpoint.h>
#include <function.h>
#include <audionotes.h>
#include <parameters.h>

class PointsInterest : public QObject
{
    Q_OBJECT
public:
    explicit PointsInterest(Function& function,
                            AudioNotes& audioNotes,
                            CurveMovingPoint& curveMovingPoint,
                            Parameters& parameters,
                            QObject *parent = nullptr);
    Q_INVOKABLE void nextPoint();
    Q_INVOKABLE void previousPoint();

signals:
    void drawPoint(int point);

private slots:
    void timerExpired();

private:
    int m_currentPoint;
    QVector<int> m_list;
    QTimer m_timer;
    bool m_forward;
    CurveMovingPoint& m_curveMovingPoint;
    Function& m_function;
    AudioNotes& m_audioNotes;
    Parameters& m_parameters;
};

#endif // POINTSINTEREST_H
