#ifndef POINTSINTEREST_H
#define POINTSINTEREST_H

#include <QObject>
#include <QVector>
#include <QTimer>
#include "function/functionPointView.h"
#include "function/functionModel.h"
#include "function/functionDescription.h"
#include <audionotes.h>
#include <parameters.h>
#include "function/currentPoint.h"

class PointsInterest : public QObject
{
    Q_OBJECT
public:
    explicit PointsInterest(QObject *parent = nullptr);
    ~PointsInterest();
    void nextPoint(AudioNotes *audioNotes,
                   CurrentPoint *currentPoint,
                   FunctionPointView *pointView,
                   Parameters *parameters);

    void previousPoint(AudioNotes *audioNotes,
                       CurrentPoint *currentPoint,
                       FunctionPointView *pointView,
                       Parameters *parameters);

    void stop();

    void setModel(FunctionModel *model);

signals:
    void drawPoint(int point);

private slots:
    void timerExpired();

private:
//    int m_currentPoint;
    int m_pointInterest;
    QVector<int> m_list;
    QTimer m_timer;
    bool m_forward;
//    CurveMovingPoint& m_curveMovingPoint;
    FunctionPointView *m_pointView;
    FunctionModel *m_model;
    FunctionDescription *m_funcDescription;
    QVector<InterestingPoint> m_points;
//    Function& m_function;
//    AudioNotes& m_audioNotes;
    AudioNotes *m_audioNotes;
    Parameters *m_parameters;
    CurrentPoint *m_currentPoint;
//    Parameters& m_parameters;
    bool m_isUpdated;
};

#endif // POINTSINTEREST_H
