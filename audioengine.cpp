#include "audioengine.h"

AudioEngine::AudioEngine(QString expression, double start, double end, double minY, double maxY, int seconds, int fmin, int fmax)
{
    generator = NULL;
    audioOutput = nullptr;

    this->seconds = seconds;
    this->fmin = fmin;
    this->fmax = fmax;
    m_expression = expression;
    m_start = start;
    m_end = end;
    m_minY = minY;
    m_maxY = maxY;
    checkParameters();
}

AudioEngine::~AudioEngine()
{
    if (generator != NULL)
        delete generator;
    if (audioOutput != nullptr)
        delete audioOutput;
}

void AudioEngine::createAudioOutput()
{
    setDevice();
    setFormat();
    resetAudioOutput();
    resetGenerator();
    audioOutput = new QAudioOutput(device, format);
    audioOutput->start(generator);
}

void AudioEngine::stop()
{
    if (audioOutput != nullptr)
        audioOutput->stop();
}

void AudioEngine::resetAudioOutput()
{
    if (audioOutput != NULL)
    {
        audioOutput->stop();
        delete audioOutput;
        audioOutput = NULL;
    }
}

void AudioEngine::resetGenerator()
{
    if (generator != NULL)
        delete generator;
    generator = new Generator(format, m_expression, m_start, m_end, m_minY, m_maxY, seconds, fmin, fmax);
    generator->start();
}

void AudioEngine::setDevice()
{
    device = QAudioDeviceInfo::defaultOutputDevice();
}

void AudioEngine::setFormat()
{
    format.setSampleRate(DataSampleRateHz);
    format.setChannelCount(channelCount);
    format.setSampleSize(sampleSize);
    format.setCodec(codec);
    format.setByteOrder(QAudioFormat::LittleEndian);
    format.setSampleType(QAudioFormat::SignedInt);
}

void AudioEngine::checkParameters()
{
    if (seconds < minDuration)
    {
        seconds = minDuration;
    }
    else if (seconds > maxDuration)
    {
        seconds = maxDuration;
    }

    if (fmin < minimumAllowedFmin)
    {
        fmin = minimumAllowedFmin;
    }
    else if (fmin > maximumAllowedFmin)
    {
        fmin = maximumAllowedFmin;
    }

    if (fmax < minimumAllowedFmax)
    {
        fmax = minimumAllowedFmax;
    }
    else if (fmax > maximumAllowedFmax)
    {
        fmax = maximumAllowedFmax;
    }
}

int AudioEngine::getFmax() const
{
    return fmax;
}

int AudioEngine::getFmin() const
{
    return fmin;
}
