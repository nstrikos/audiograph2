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
                  QString start,
                  QString end,
                  QString minY,
                  QString maxY,
                  QString seconds,
                  QString fmin,
                  QString fmax)
{
    reset();

    QString piString = QString::number(M_PI);
    QString eString = QString::number(M_E);
    expression.replace("pi", piString);
    expression.replace("e", eString);

    std::string exp = expression.toStdString();

    int res = m_fparser.Parse(exp, "x");
    if (res >= 0)
        return;


    double m_start = start.toDouble();
    double m_end = end.toDouble();
    double m_minY = minY.toDouble();
    double m_maxY = maxY.toDouble();
    int m_seconds = seconds.toInt();
    int m_fmin = fmin.toInt();
    int m_fmax = fmax.toInt();
    m_audioEngine = new AudioEngine(expression,
                                    m_start,
                                    m_end,
                                    m_minY,
                                    m_maxY,
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
