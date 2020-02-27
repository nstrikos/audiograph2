#ifndef AUDIONOTES_H
#define AUDIONOTES_H

#include <QObject>
#include <QTimer>
#include "function/functionModel.h"
#include "audiopoints.h"

class AudioNotes : public QObject
{
    Q_OBJECT

public:
    AudioNotes();
    ~AudioNotes();
    Q_INVOKABLE void startNotes(FunctionModel *model,
                                int fmin,
                                int fmax,
                                int duration);
    Q_INVOKABLE void setNote(FunctionModel *model,
                             int mouseX,
                             int width,
                             int fmin,
                             int fmax,
                             bool useNotes);
    Q_INVOKABLE void setNote(FunctionModel *model,
                             int currentPoint,
                             int fmin,
                             int fmax,
                             bool useNotes);
    Q_INVOKABLE void stopNotes();

signals:
    void finished();

private slots:
    void timerExpired();

private:
    FunctionModel *m_model;
    int m_fmin;
    int m_fmax;
    int m_duration;
    QTimer m_timer;
    int m_timeElapsed;
    AudioPoints *m_audioPoints;
    int m_mouseX;
    int m_currentPoint;
};

#endif // AUDIONOTES_H
