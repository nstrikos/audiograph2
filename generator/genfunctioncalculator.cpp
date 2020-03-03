#include "genfunctioncalculator.h"
#include <limits>
#include <QElapsedTimer>
#include <QVector>

#include <QtMath>

GenFunctionCalculator::GenFunctionCalculator(GenParameters *params)
{
    m_params = params;
    unsigned long long int length = params->length();

    unsigned int numThreads = static_cast<unsigned int>(QThread::idealThreadCount());

    unsigned long long int interval = length / numThreads;


    for (unsigned int i = 0; i < numThreads - 1; i++) {
        m_tmpThread = new GenFunctionCalculatorThread(m_params,
                                                      i * interval,
                                                      (i+1)* interval);
        m_threads.push_back(m_tmpThread);
        connect(m_tmpThread, SIGNAL(finished()),
                m_tmpThread, SLOT(deleteLater()));
        m_tmpThread->start();
    }

    m_tmpThread = new GenFunctionCalculatorThread(m_params,
                                                  (numThreads - 1) * interval,
                                                  length);
    m_threads.push_back(m_tmpThread);
    connect(m_tmpThread, SIGNAL(finished()),
            m_tmpThread, SLOT(deleteLater()));
    m_tmpThread->start();

    for (unsigned int i = 0; i < numThreads; i++) {
        m_threads.at(i)->wait();
    }
}

GenFunctionCalculatorThread::GenFunctionCalculatorThread(GenParameters *params,
                                                         unsigned long long first,
                                                         unsigned long long last)
{
    m_params = params;
    m_first = first;
    m_last = last;
}

void GenFunctionCalculatorThread::run()
{
    double x;
    double start = m_params->start();
    double step = m_params->step();
    double *functionValues = m_params->functionValues();
    unsigned long long int i = 0;

    QString expression = m_params->expression();
    std::string exp = expression.toStdString();

    m_fparser.AddConstant("pi", M_PI);
    m_fparser.AddConstant("e", M_E);

    double vals[] = { 0 };
    double result;

//    size_t err = parser.parse(byteCode, exp, "x");
//    if ( err  )

    int res = m_fparser.Parse(exp, "x");

//    if(res >= 0 || exp == "") {
//        emit error(tr("Cannot understand expression.\n") + m_fparser.ErrorMsg());
//        return false;
//    }


    for (i = m_first; i < m_last; i++) {
        x = start + i * step;
        //byteCode.var[0] = x;   // x is 1st in the above variables list, so it has index 0
        //result = byteCode.run();
        vals[0] = x;
        result = m_fparser.Eval(vals);
        res = m_fparser.EvalError();

        if (result > 10 * m_params->maxY())
            result = 10 * m_params->maxY();
        if (result < 10 * m_params->minY())
            result = 10 * m_params->minY();


//        if (x > -4.0 && x < -3.0)
//            result = 440.0;
//        if (x >= -3.0 && x < -2.0)
//            result = 493.88;
//        if (x >= -2.0 && x < -1.0)
//            result = 523.25;
//        if (x >= -1.0 && x < 0.0)
//            result = 587.33;
//        if (x >= 0.0 && x < 1.0)
//            result = 659.25;
//        if (x >= 1.0 && x < 2.0)
//            result = 698.46;
//        if (x >= 2.0 && x < 3.0)
//            result = 783.99;
//        if (x >= 3.0 && x <= 4.0)
//            result = 880.00;

        functionValues[i] = result;

//        if (is_positive_infinite(result)) {
//            functionValues[i] = std::numeric_limits<double>::max();
//        }

//        if (is_negative_infinite(result)) {
//            functionValues[i] = -std::numeric_limits<double>::max();
//        }

//        if (is_nan(result)) {
//            functionValues[i] = 0;
//        }
        //        m_functionValues[i] = sin(x)*x*x*x - x*x*sin(x);
        //        functionValues[i] = -5/(x*x + 1);
        //        m_functionValues[i] = x;
        //        m_functionValues[i] = 5 - x;
        //        functionValues[i] = 5;
        //         functionValues[i] = sin(x)*log(x)*cos(x/3)*x^3
        //          functionValues[i] = sin(x)*log(abs(x))*x;
        //        if (x != 0.0)
        //            functionValues[i] = sin(x*x) / x;
        //        functionValues[i] = sin(x*x*x) / x;
        //        m_functionValues[i] = cos(x*x) / x;
        //        functionValues[i] = 1 / abs(x);
        //            functionValues[i] = 1 / x;

    }
}

bool GenFunctionCalculatorThread::is_positive_infinite(const double &value)
{
    double max_value = std::numeric_limits<double>::max();

    return ! ( value <= max_value );
}

bool GenFunctionCalculatorThread::is_negative_infinite(const double &value)
{
    double min_value = - std::numeric_limits<double>::max();

    return ! ( min_value <= value  );
}

bool GenFunctionCalculatorThread::is_nan(const double &value)
{
    // True if NAN
    return value != value;
}

bool GenFunctionCalculatorThread::is_valid(const double &value)
{
    return ! is_positive_infinite(value) && is_negative_infinite(value) && ! is_nan(value);
}
