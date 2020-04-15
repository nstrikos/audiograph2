#ifndef FUNCTIONMODEL_H
#define FUNCTIONMODEL_H

#include <QObject>
#include <QVector>
#include <point.h>
#include "fparser/fparser.hh"

class FunctionModel : public QObject
{
    Q_OBJECT

public:
    explicit FunctionModel(QObject *parent = nullptr);
    ~FunctionModel();
    void calculate(QString expression,
                   QString minX,
                   QString maxX,
                   QString minY,
                   QString maxY);

    void calculate(QString expression,
                   double minX,
                   double maxX,
                   double minY,
                   double maxY);

    double x(int i) const;
    double y(int i) const;
    bool isValid(int i) const;
    double maxValue() const;
    double minValue() const;

    QString expression() const;
    double minX() const;
    double maxX() const;
    double minY() const;
    double maxY() const;
    int lineSize() const;

    bool validExpression() const;
    QString getError();

signals:
    void update();
    void error();

private:
    void performCalculation();
    void replaceConstants();
    bool check();
    void clear();
    void calculatePoints();
    QString m_expression;
    QString m_minXString;
    QString m_maxXString;
    QString m_minYString;
    QString m_maxYString;
    QString m_pointsString;
    double m_minX;
    double m_maxX;
    double m_minY;
    double m_maxY;
    double m_maxValue;
    double m_minValue;
    int m_numPoints;
    FunctionParser m_fparser;
    bool m_validExpression;

    QVector<Point> m_linePoints;
    QVector<Point> m_points;

    QString m_error;
};

#endif // FUNCTIONMODEL_H
