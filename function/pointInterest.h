#ifndef POINTINTEREST_H
#define POINTINTEREST_H

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

    void nextPointFast(CurrentPoint *currentPoint,
                       FunctionPointView *pointView,
                       Parameters *parameters);

    void previousPointFast(CurrentPoint *currentPoint,
                           FunctionPointView *pointView,
                           Parameters *parameters);

    void stop();

    void setModel(FunctionModel *model);

    double currentPointX();
    double currentPointY();
    QString currentPointLabel();


private slots:
    void timerExpired();

private:
    int m_pointInterest;
    QTimer m_timer;
    bool m_forward;
    FunctionPointView *m_pointView;
    FunctionModel *m_model;
    FunctionDescription *m_funcDescription;
    QVector<InterestingPoint> m_points;
    AudioNotes *m_audioNotes;
    Parameters *m_parameters;
    CurrentPoint *m_currentPoint;
    bool m_isUpdated;
    int getNextPointInterest();
    void start(AudioNotes *audioNotes,
               CurrentPoint *currentPoint,
               FunctionPointView *pointView,
               Parameters *parameters);
};

#endif // POINTSINTEREST_H
