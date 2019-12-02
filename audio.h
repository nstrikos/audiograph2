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
                           QString start,
                           QString end,
                           QString minY,
                           QString maxY,
                           QString seconds,
                           QString fmin,
                           QString fmax);
    Q_INVOKABLE void stop();

private:
    AudioEngine *m_audioEngine;
    FunctionParser m_fparser;
    void reset();
};

#endif // AUDIO_H
