#include "audionotes.h"
#include "math.h"
#include "constants.h"

#include <QDebug>

AudioNotes::AudioNotes()
{
    m_model = nullptr;
    m_timer.setTimerType(Qt::PreciseTimer);
    m_timer.setInterval(50);
    connect(&m_timer, SIGNAL(timeout()), this, SLOT(timerExpired()));
    m_audioPoints = new AudioPoints();
}

AudioNotes::~AudioNotes()
{
    delete m_audioPoints;
}

void AudioNotes::startNotes(FunctionModel *model,
                            int fmin,
                            int fmax,
                            int duration)
{
    m_model = model;
    m_fmin = fmin;
    m_fmax = fmax;
    m_duration = duration * 1000;
    m_timeElapsed = 0;
    m_timer.start();
}

void AudioNotes::setNote(FunctionModel *model,
                         int mouseX,
                         int width,
                         int fmin,
                         int fmax,
                         bool useNotes)
{
    m_model = model;
    m_mouseX = mouseX;
    m_fmin = fmin;
    m_fmax = fmax;

    if (m_mouseX < 0)
        m_mouseX = 0;
    if (m_mouseX > width)
        m_mouseX = width;

    int i = round((1.0 * m_mouseX / width) * LINE_POINTS);
    if (i < 0)
        i = 0;
    if (i >= LINE_POINTS)
        i = LINE_POINTS - 1;

    double min = m_model->minValue();
    double max = m_model->maxValue();

    if (max > 10 * m_model->maxY())
        max = 10 * m_model->maxY();
    if (min < 10 * m_model->minY())
        min = 10 * m_model->minY();

    double a;
    double b;
    double l;
    double freq;
    bool n = true;
    if (max != min) {
        a =  (m_fmax-m_fmin)/(max - min);
        b = m_fmax - a * max;
        l = m_model->y(i);
        if (l >= 0)
            n = true;
        else
            n = false;
        freq = a * l + b;
        m_audioPoints->setFreq(freq, useNotes, n);
    } else {
        m_audioPoints->setFreq((m_fmax - m_fmin) / 2, useNotes, n);
    }
}

void AudioNotes::setNote(FunctionModel *model, int currentPoint, int fmin, int fmax, bool useNotes)
{
    m_model = model;
    m_fmin = fmin;
    m_fmax = fmax;
    m_currentPoint = currentPoint;

    if (m_currentPoint < 0)
        m_currentPoint = 0;
    if (m_currentPoint >= LINE_POINTS)
        m_currentPoint = LINE_POINTS - 1;

    double min = m_model->minValue();
    double max = m_model->maxValue();

    if (max > 10 * m_model->maxY())
        max = 10 * m_model->maxY();
    if (min < 10 * m_model->minY())
        min = 10 * m_model->minY();

    double a;
    double b;
    double l;
    double freq;
    bool n = true;
    if (max != min) {
        a =  (m_fmax-m_fmin)/(max - min);
        b = m_fmax - a * max;
        l = m_model->y(m_currentPoint);
        if (l >= 0)
            n = true;
        else
            n = false;
        freq = a * l + b;
        m_audioPoints->setFreq(freq, useNotes, n);
    } else {
        m_audioPoints->setFreq((m_fmax - m_fmin) / 2, useNotes, n);
    }
}

void AudioNotes::stopNotes()
{
    m_timer.stop();
    m_audioPoints->stopAudio();
}

void AudioNotes::timerExpired()
{
    m_timeElapsed += m_timer.interval();
    if (m_timeElapsed > m_duration) {
        stopNotes();
        return;
    }

    double cx = (double) m_timeElapsed / m_duration;
    int i = round(cx * LINE_POINTS);
    if (i >= LINE_POINTS)
        i = LINE_POINTS - 1;
    if (i < 0)
        i = 0;

    double min = m_model->minValue();
    if (min < 10 * m_model->minY())
        min = 10 * m_model->minY();
    double max = m_model->maxValue();
    if (max > 10 * m_model->maxX())
        max = 10 * m_model->maxY();
    double a;
    double b;
    double l;
    double freq;
    bool n = true;
    if (max != min) {
        m_fmin = 110;
        m_fmax = 2959.96;
        a =  (m_fmax-m_fmin)/(max - min);
        b = m_fmax - a * max;
        l = m_model->y(i);
        if (l >= 0)
            n = true;
        else
            n = false;
        freq = a * l + b;
        m_audioPoints->setFreq(freq, true, n);
    } else {
        m_audioPoints->setFreq((m_fmax - m_fmin) / 2, true, n);
    }
}
