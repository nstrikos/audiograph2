#include "pointsinterest.h"

PointsInterest::PointsInterest(QObject *parent) : QObject(parent)
{
    m_funcDescription = nullptr;

    //    m_currentPoint = 0;
    m_pointInterest = 0;
    m_audioNotes = nullptr;
    m_forward = true;
    m_timer.setTimerType(Qt::PreciseTimer);

    connect(&m_timer, SIGNAL(timeout()), this, SLOT(timerExpired()));
}

PointsInterest::~PointsInterest()
{
    if (m_funcDescription != nullptr)
        delete m_funcDescription;
}

void PointsInterest::nextPoint(AudioNotes *audioNotes,
                               CurrentPoint *currentPoint,
                               FunctionPointView *pointView,
                               Parameters *parameters)
{
    if (m_funcDescription == nullptr)
        m_funcDescription = new FunctionDescription;


    if (m_isUpdated == false) {
        m_points.clear();
        m_points = m_funcDescription->points(m_model);
        m_isUpdated = true;
    }

    m_audioNotes = audioNotes;
    m_currentPoint = currentPoint;
    m_pointView = pointView;
    m_parameters = parameters;

    m_forward = true;

    for (int i = 0; i < m_points.size(); i++) {
        if (m_points.at(i).x < m_currentPoint->point()) {
            continue;
        } else if ((m_points.at(i).x == m_currentPoint->point())) {
            m_pointInterest = i + 1;
            break;
        }
        else {
            m_pointInterest = i;
            break;
        }
    }

    //m_pointInterest++;
    if (m_pointInterest >= m_points.size())
        m_pointInterest = m_points.size() - 1;
    m_timer.setInterval(1);
    m_timer.start();
}

void PointsInterest::previousPoint(AudioNotes *audioNotes,
                                   CurrentPoint *currentPoint,
                                   FunctionPointView *pointView,
                                   Parameters *parameters)
{
    if (m_funcDescription == nullptr)
        m_funcDescription = new FunctionDescription;

    if (m_isUpdated == false) {
        m_points.clear();
        m_points = m_funcDescription->points(m_model);
        m_isUpdated = true;
    }

    m_audioNotes = audioNotes;
    m_currentPoint = currentPoint;
    m_pointView = pointView;
    m_parameters = parameters;

    m_forward = false;
    for (int i = m_points.size() - 1; i >= 0; i--) {
        if (m_points.at(i).x > m_currentPoint->point()) {
            continue;
        } else if (m_points.at(i).x == m_currentPoint->point()) {
            m_pointInterest = i - 1;
            break;
        }
        else {
            m_pointInterest = i;
            break;
        }
    }

    if (m_pointInterest <  0)
        m_pointInterest = 0;


    m_timer.setInterval(1);
    m_timer.start();
}

void PointsInterest::stop()
{
    m_timer.stop();
    if (m_audioNotes != nullptr)
        m_audioNotes->stopNotes();
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
        //m_currentPoint += 1;
        m_currentPoint->incPoint(m_model, m_pointView->width(), m_pointView->height());
        if (m_currentPoint->point() >= m_points[m_pointInterest].x) {
            m_timer.stop();
        } else {
            //            m_curveMovingPoint.setPoint(&m_function, m_currentPoint);
            //            m_audioNotes.setNote(&m_function, m_currentPoint, m_parameters.minFreq(), m_parameters.maxFreq(), m_parameters.useNotes());
            //m_pointView->setPoint(m_model, m_currentPoint);
            m_audioNotes->setNote(m_model, m_currentPoint->point(), m_parameters->minFreq(), m_parameters->maxFreq(), m_parameters->useNotes());
            //            emit drawPoint(m_currentPoint);
        }
    } else {
        //        m_currentPoint -= 1;
        m_currentPoint->decPoint(m_model, m_pointView->width(), m_pointView->height());
        if (m_currentPoint->point() <= m_points[m_pointInterest].x) {
            m_timer.stop();
        } else {
            //m_pointView->setPoint(m_model, m_currentPoint);
            m_audioNotes->setNote(m_model, m_currentPoint->point(), m_parameters->minFreq(), m_parameters->maxFreq(), m_parameters->useNotes());
            //            emit drawPoint(m_currentPoint);
        }
    }
}

void PointsInterest::setModel(FunctionModel *model)
{
    m_model = model;
    m_isUpdated = false;
}
