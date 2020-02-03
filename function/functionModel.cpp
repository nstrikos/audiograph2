#include "functionModel.h"
#include "constants.h"

FunctionModel::FunctionModel(QObject *parent) : QObject(parent)
{

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
    }
}

void FunctionModel::replaceConstants()
{
    QString piString = QString::number(M_PI);
    QString eString = QString::number(M_E);

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
        emit error(tr("Minimum is not a real number."));
        return false;
    }

    double maxDouble = m_maxXString.toDouble(&okMax);
    if (okMax) {
        m_maxX = maxDouble;
    }
    else {
        emit error(tr("Maximum is not a real number."));
        return false;
    }

    double minYDouble = m_minYString.toDouble(&okMinY);
    if (okMinY) {
        m_minY = minYDouble;
    }
    else {
        emit error(tr("Minimum Y is not a real number."));
        return false;
    }

    double maxYDouble = m_maxYString.toDouble(&okMaxY);
    if (okMaxY) {
        m_maxY = maxYDouble;
    }
    else {
        emit error(tr("Maximum Y is not a real number."));
        return false;
    }

    if (m_maxX <= m_minX) {
        emit error(tr("Maximum must be greater than minimum."));
        return false;
    }

    if (m_maxY <= m_minY) {
        emit error(tr("Maximum Y must be greater than minimum Y."));
        return false;
    }

    m_fparser.AddConstant("pi", M_PI);
    m_fparser.AddConstant("e", M_E);
    int res = m_fparser.Parse(m_expression.toStdString(), "x");
    if(res >= 0 || m_expression == "") {
        emit error(tr("Cannot understand expression.\n") + m_fparser.ErrorMsg());
        return false;
    }

    return true;
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
        if (res == 0)
            tmpPoint.isValid = true;
        else if (res > 0) {
            tmpPoint.isValid = false;
       }

        m_linePoints.append(tmpPoint);
    }

    m_minValue = m_linePoints[0].y;
    m_maxValue = m_linePoints[0].y;

    for (int i = 1; i < LINE_POINTS; i++) {
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

//double FunctionModel::minValue() const
//{
//    return m_minValue;
//}

//double FunctionModel::maxValue() const
//{
//    return m_maxValue;
//}

void FunctionModel::zoom(double delta)
{
    double factor;
    if (delta < 0)
        factor = 1.1;
    else
        factor = 0.9;

    if (m_expression != "")
        performZoom(factor);
}

//void FunctionModel::pinch(double scale)
//{
//    performZoom(scale);
//}

void FunctionModel::performZoom(double factor)
{
    double minX = m_minX;
    double maxX = m_maxX;
    double minY = m_minY;
    double maxY = m_maxY;

    double distanceX = maxX - minX;
    double centerX = (maxX + minX) / 2;

    double distanceY = maxY - minY;
    double centerY = (maxY + minY) / 2;

    distanceX = distanceX * factor;
    distanceY = distanceY * factor;

    if ( (abs(distanceX) > 0.00001) && (abs(distanceY) > 0.00001) ) {
        m_minX = centerX - distanceX / 2;
        m_maxX = centerX + distanceX / 2;
        m_minY = centerY - distanceY / 2;
        m_maxY = centerY + distanceY / 2;
        calculatePoints();
    }

    double distance = maxX - minX;
    double power = -floor(log10(distance)) + 1;
    double ten = pow(10, power);

    if (power > 0) {
        minX = round(minX * ten) / ten;
        maxX = round(maxX * ten) / ten;
    }
    else {
        minX = round(minX);
        maxX = round(maxX);
    }

    distance = maxY - minY;
    power = -floor(log10(distance)) + 1;
    ten = pow(10, power);
    if (power > 0) {
        minY = round(minY * ten) / ten;
        maxY = round(maxY * ten) / ten;
    }
    else {
        minY = round(minY);//minY.toFixed(0);
        maxY = round(maxY);//maxY.toFixed(0);
    }

    emit newInputValues(minX, maxX, minY, maxY);
}

//QString FunctionModel::error() const
//{
//    return m_error;
//}

//bool FunctionModel::validExpression() const
//{
//    return m_validExpression;
//}

QString FunctionModel::expression() const
{
    return m_expression;
}

