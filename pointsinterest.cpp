#include "pointsinterest.h"

PointsInterest::PointsInterest(QObject *parent) : QObject(parent)
{
    m_currentPoint = 0;
    m_pointInterest = 0;
    m_forward = true;
    m_list.append(0);
    m_list.append(1000);
    m_list.append(2000);
    m_list.append(3000);
    m_list.append(4000);
    m_list.append(5000);
    m_list.append(6000);
    m_list.append(7000);
    m_list.append(8000);
    m_list.append(9000);

    m_timer.setTimerType(Qt::PreciseTimer);

    connect(&m_timer, SIGNAL(timeout()), this, SLOT(timerExpired()));
}

void PointsInterest::nextPoint(FunctionModel *functionModel,
                               AudioNotes *audioNotes,
                               FunctionPointView *pointView,
                               Parameters *parameters)
{
    m_model = functionModel;
    m_audioNotes = audioNotes;
    m_pointView = pointView;
    m_parameters = parameters;

    m_forward = true;
    m_pointInterest++;
    if (m_pointInterest >= m_list.size())
        m_pointInterest = m_list.size() - 1;
    m_timer.setInterval(1);
    m_timer.start();
}

void PointsInterest::previousPoint(FunctionModel *functionModel,
                                   AudioNotes *audioNotes,
                                   FunctionPointView *pointView,
                                   Parameters *parameters)
{
    m_model = functionModel;
    m_audioNotes = audioNotes;
    m_pointView = pointView;
    m_parameters = parameters;

    m_forward = false;
    m_pointInterest--;
    if (m_pointInterest < 0)
        m_pointInterest = 0;
    m_timer.setInterval(1);
    m_timer.start();
}

void PointsInterest::timerExpired()
{
    if (m_pointView == nullptr)
        return;
    if (m_audioNotes == nullptr)
        return;
    if (m_model == nullptr)
        return;
    if (m_parameters == nullptr)
        return;

    if (m_forward) {
        m_currentPoint++;
        if (m_currentPoint >= m_list.at(m_pointInterest)) {
            m_timer.stop();
        } else {
//            m_curveMovingPoint.setPoint(&m_function, m_currentPoint);
//            m_audioNotes.setNote(&m_function, m_currentPoint, m_parameters.minFreq(), m_parameters.maxFreq(), m_parameters.useNotes());
            m_pointView->setPoint(m_model, m_currentPoint);
            m_audioNotes->setNote(m_model, m_currentPoint, m_parameters->minFreq(), m_parameters->maxFreq(), m_parameters->useNotes());
//            emit drawPoint(m_currentPoint);
        }
    } else {
        m_currentPoint--;
        if (m_currentPoint <= m_list.at(m_pointInterest)) {
            m_timer.stop();
        } else {
            m_pointView->setPoint(m_model, m_currentPoint);
            m_audioNotes->setNote(m_model, m_currentPoint, m_parameters->minFreq(), m_parameters->maxFreq(), m_parameters->useNotes());
//            emit drawPoint(m_currentPoint);
        }
    }
}
