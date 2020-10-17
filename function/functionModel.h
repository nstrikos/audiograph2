#ifndef FUNCTIONMODEL_H
#define FUNCTIONMODEL_H

#include <QObject>
#include <QVector>
#include <point.h>

#ifdef Q_OS_WIN
#include "fparser/fparser.hh"
#else

#include "exprtk/exprtk.hpp"

typedef exprtk::symbol_table<double> symbol_table_t;
typedef exprtk::expression<double>     expression_t;
typedef exprtk::parser<double>             parser_t;

#endif

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

    void calculateDerivative();
    void calculateDerivative2();

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

    double derivative(int i) const;
    double derivative2(int i) const;

signals:
    void update();
    void updateDerivative();
    void updateDerivative2();
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
    bool m_validExpression;

    QVector<Point> m_linePoints;
    QVector<Point> m_points;
    QVector<Point> m_deriv;
    QVector<Point> m_deriv2;

    QString m_error;

#ifdef Q_OS_WIN
    FunctionParser m_fparser;
#else
    symbol_table_t symbol_table;
    double m_x;
    expression_t parser_expression;
    expression_t parser_expression2;
    symbol_table_t symbol_table2;
#endif
};

#endif // FUNCTIONMODEL_H
