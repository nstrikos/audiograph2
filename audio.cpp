#include "audio.h"

Audio::Audio()
{
    m_audioEngine = nullptr;
    m_fparser.AddConstant("pi", M_PI);
    m_fparser.AddConstant("e", M_E);
}

Audio::~Audio()
{
    if (m_audioEngine != nullptr)
        delete m_audioEngine;
}

void Audio::start(QString expression,
                  double start,
                  double end,
                  double minY,
                  double maxY,
                  int seconds,
                  double fmin,
                  double fmax)
{
    reset();

    std::string exp = expression.toStdString();

    int res = m_fparser.Parse(exp, "x");
    if (res >= 0)
        return;

    m_audioEngine = new AudioEngine(expression,
                                    start,
                                    end,
                                    minY,
                                    maxY,
                                    seconds,
                                    fmin,
                                    fmax);
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
