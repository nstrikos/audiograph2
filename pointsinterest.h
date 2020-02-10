#ifndef POINTSINTEREST_H
#define POINTSINTEREST_H

#include <QObject>
#include <QVector>
#include <QTimer>
#include "function/functionPointView.h"
#include "function/functionModel.h"
#include <audionotes.h>
#include <parameters.h>

class PointsInterest : public QObject
{
    Q_OBJECT
public:
    explicit PointsInterest(QObject *parent = nullptr);
    void nextPoint(FunctionModel *functionModel,
                   AudioNotes *audioNotes,
                   FunctionPointView *pointView,
                   Parameters *parameters);

    void previousPoint(FunctionModel *functionModel,
                       AudioNotes *audioNotes,
                       FunctionPointView *pointView,
                       Parameters *parameters);

signals:
    void drawPoint(int point);

private slots:
    void timerExpired();

private:
    int m_currentPoint;
    int m_pointInterest;
    QVector<int> m_list;
    QTimer m_timer;
    bool m_forward;
//    CurveMovingPoint& m_curveMovingPoint;
    FunctionPointView *m_pointView;
    FunctionModel *m_model;
//    Function& m_function;
//    AudioNotes& m_audioNotes;
    AudioNotes *m_audioNotes;
    Parameters *m_parameters;
//    Parameters& m_parameters;
};

#endif // POINTSINTEREST_H
