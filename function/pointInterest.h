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
#include <texttospeech.h>

class PointsInterest : public QObject
{
    Q_OBJECT
public:
    explicit PointsInterest(TextToSpeech &textToSpeech);
    ~PointsInterest();
    void nextPoint(AudioNotes *audioNotes,
                   CurrentPoint *currentPoint,
                   FunctionPointView *pointView);

    void previousPoint(AudioNotes *audioNotes,
                       CurrentPoint *currentPoint,
                       FunctionPointView *pointView);

    void nextPointFast(CurrentPoint *currentPoint,
                       FunctionPointView *pointView);

    void previousPointFast(CurrentPoint *currentPoint,
                           FunctionPointView *pointView);

    void stop();

    void setModel(FunctionModel *model);

    double currentPointX();
    double currentPointY();
    QString currentPointLabel();

    void setMode(int mode);

signals:
    void finished();


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
    CurrentPoint *m_currentPoint;
    TextToSpeech &m_textToSpeech;
    bool m_isUpdated;
    int getNextPointInterest();
    void start(AudioNotes *audioNotes,
               CurrentPoint *currentPoint,
               FunctionPointView *pointView);
    int m_mode = 0;
};

#endif // POINTSINTEREST_H
