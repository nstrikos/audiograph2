#include "pointsinterest.h"

PointsInterest::PointsInterest(Function& function,
                               AudioNotes& audioNotes,
                               CurveMovingPoint& curveMovingPoint,
                               Parameters& parameters,
                               QObject *parent) : QObject(parent),
    m_function(function),
    m_audioNotes(audioNotes),
    m_curveMovingPoint(curveMovingPoint),
    m_parameters(parameters)
{
    m_currentPoint = 0;
    m_forward = true;
    m_list.append(0);
    m_list.append(1000);
    m_list.append(9000);

    m_timer.setTimerType(Qt::PreciseTimer);

    connect(&m_timer, SIGNAL(timeout()), this, SLOT(timerExpired()));
}

void PointsInterest::nextPoint()
{
    m_forward = true;
    m_currentPoint = m_list.at(1);
    m_timer.setInterval(1);
    m_timer.start();
}

void PointsInterest::previousPoint()
{
    m_forward = false;
    m_timer.setInterval(1);
    m_timer.start();
}

void PointsInterest::timerExpired()
{
    if (m_forward) {
        m_currentPoint++;
        if (m_currentPoint >= m_list.at(2)) {
            m_timer.stop();
        } else {
            //emit drawPoint(m_currentPoint);
//            m_curveMovingPoint.setPoint(&m_function, m_currentPoint);
            m_audioNotes.setNote(&m_function, m_currentPoint, m_parameters.minFreq(), m_parameters.maxFreq(), m_parameters.useNotes());

        }
    } else {
        m_currentPoint--;
        if (m_currentPoint <= m_list.at(1)) {
            m_timer.stop();
        } else {
            emit drawPoint(m_currentPoint);
        }
    }
}
