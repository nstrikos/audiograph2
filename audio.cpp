#include "audio.h"

Audio::Audio()
{
    m_audioEngine = nullptr;
}

Audio::~Audio()
{
    if (m_audioEngine != nullptr)
        delete m_audioEngine;
}

void Audio::start(QString expression,
                  QString start,
                  QString end,
                  QString seconds,
                  QString fmin,
                  QString fmax)
{
    reset();

    double m_start = start.toDouble();
    double m_end = end.toDouble();
    int m_seconds = seconds.toInt();
    int m_fmin = fmin.toInt();
    int m_fmax = fmax.toInt();
    m_audioEngine = new AudioEngine(expression,
                                    m_start,
                                    m_end,
                                    m_seconds,
                                    m_fmin,
                                    m_fmax);
    m_audioEngine->createAudioOutput();
}

void Audio::stop()
{
    if (m_audioEngine != nullptr)
        m_audioEngine->stop();
}

void Audio::reset()
{
    if (m_audioEngine != nullptr)
    {
        m_audioEngine->stop();
        delete m_audioEngine;
        m_audioEngine = nullptr;
    }
}
