#include "functionModel.h"
#include "constants.h"

#include <QtMath>

#include <QDebug>

FunctionModel::FunctionModel(QObject *parent) : QObject(parent)
{
    m_error = tr("Syntax error");
}

FunctionModel::~FunctionModel()
{

}

void FunctionModel::calculate(QString expression,
                              QString minX,
                              QString maxX,
                              QString minY,
                              QString maxY)
{
    m_expression = expression;
    m_minXString = minX;
    m_maxXString = maxX;
    m_minYString = minY;
    m_maxYString = maxY;
    performCalculation();
}

void FunctionModel::calculate(QString expression, double minX, double maxX, double minY, double maxY)
{
    m_expression = expression;
    m_minX = minX;
    m_maxX = maxX;
    m_minY = minY;
    m_maxY = maxY;
    calculatePoints();
}

void FunctionModel::performCalculation()
{
    replaceConstants();
    if (check()) {
        m_validExpression = true;
        calculatePoints();
    }
    else {
        m_validExpression = false;
        clear();
    }
}

void FunctionModel::replaceConstants()
{
    QString piString = QString::number(M_PI);
    QString eString = QString::number(M_E);
    QString ln = "ln";

    m_expression.replace(ln, "log");

    m_minXString.replace("pi", piString);
    m_minXString.replace("e", eString);
    m_minYString.replace("pi", piString);
    m_minYString.replace("e", eString);

    m_maxXString.replace("pi", piString);
    m_maxXString.replace("e", eString);
    m_maxYString.replace("pi", piString);
    m_maxYString.replace("e", eString);
}

bool FunctionModel::check()
{
    bool okMin, okMax, okMinY, okMaxY;//, okPoints;
    double minDouble = m_minXString.toDouble(&okMin);
    if (okMin) {
        m_minX = minDouble;
    }
    else {
        m_error = tr("Minimum is not a real number.");
        emit error();
        return false;
    }

    double maxDouble = m_maxXString.toDouble(&okMax);
    if (okMax) {
        m_maxX = maxDouble;
    }
    else {
        m_error = tr("Maximum is not a real number.");
        emit error();
        return false;
    }

    double minYDouble = m_minYString.toDouble(&okMinY);
    if (okMinY) {
        m_minY = minYDouble;
    }
    else {
        m_error = tr("Minimum Y is not a real number.");
        emit error();
        return false;
    }

    double maxYDouble = m_maxYString.toDouble(&okMaxY);
    if (okMaxY) {
        m_maxY = maxYDouble;
    }
    else {
        m_error = tr("Maximum Y is not a real number.");
        emit error();
        return false;
    }

    if (m_maxX <= m_minX) {
        m_error = tr("Maximum must be greater than minimum.");
        emit error();
        return false;
    }

    if (m_maxY <= m_minY) {
        m_error = tr("Maximum Y must be greater than minimum Y.");
        emit error();
        return false;
    }

    m_fparser.AddConstant("pi", M_PI);
    m_fparser.AddConstant("e", M_E);
    int res = m_fparser.Parse(m_expression.toStdString(), "x");
    if(res >= 0 || m_expression == "") {
        const char *s;
        s = m_fparser.ErrorMsg();
        m_error = QString::fromUtf8(s);
        qDebug() << m_error;
        emit error();
        return false;
    }

    return true;
}

void FunctionModel::clear()
{
    m_linePoints.clear();
}

void FunctionModel::calculatePoints()
{
    double x, result;
    Point tmpPoint;

    m_linePoints.clear();

    double vals[] = { 0 };
    double step;
    int res;

    step = (m_maxX - m_minX) / LINE_POINTS;
    for (int i = 0; i < LINE_POINTS; i++) {
        x = m_minX + i * step;
        vals[0] = x;
        result = m_fparser.Eval(vals);
        res = m_fparser.EvalError();
        tmpPoint.x = x;
        tmpPoint.y = result;
        if (result != result)
            tmpPoint.isValid = false;
        else if (res > 0)
            tmpPoint.isValid = false;
        else if (res == 0)
            tmpPoint.isValid = true;

        m_linePoints.append(tmpPoint);
    }

    m_minValue = std::numeric_limits<double>::max();//m_linePoints[0].y;
    m_maxValue = std::numeric_limits<double>::min();//m_linePoints[0].y;

    for (int i = 1; i < LINE_POINTS; i++) {
        if (!m_linePoints[i].isValid)
            continue;
        if (m_linePoints[i].y < m_minValue)
            m_minValue = m_linePoints[i].y;
        if (m_linePoints[i].y > m_maxValue)
            m_maxValue = m_linePoints[i].y;
    }

    emit update();
}

double FunctionModel::x(int i) const
{
    return m_linePoints[i].x;
}

double FunctionModel::y(int i) const
{
    return m_linePoints[i].y;
}

bool FunctionModel::isValid(int i) const
{
    return m_linePoints[i].isValid;
}

int FunctionModel::lineSize() const
{
    return m_linePoints.size();
}

double FunctionModel::minX() const
{
    return m_minX;
}

double FunctionModel::maxX() const
{
    return m_maxX;
}

double FunctionModel::minY() const
{
    return m_minY;
}

double FunctionModel::maxY() const
{
    return m_maxY;
}

double FunctionModel::minValue() const
{
    return m_minValue;
}

double FunctionModel::maxValue() const
{
    return m_maxValue;
}

bool FunctionModel::validExpression() const
{
    return m_validExpression;
}

QString FunctionModel::getError()
{
    return m_error;
}

QString FunctionModel::expression() const
{
    return m_expression;
}

