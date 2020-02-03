#ifndef AUDIO_H
#define AUDIO_H

#include <QObject>
#include "audioengine.h"
#include "fparser/fparser.hh"

class Audio : public QObject
{
    Q_OBJECT
public:
    Audio();
    ~Audio();
    Q_INVOKABLE void start(QString expression,
                           double start,
                           double end,
                           double minY,
                           double maxY,
                           int seconds,
                           double fmin,
                           double fmax);
    Q_INVOKABLE void stop();

private:
    AudioEngine *m_audioEngine;
    FunctionParser m_fparser;
    void reset();
};

#endif // AUDIO_H
