#ifndef GENMODVALUES_H
#define GENMODVALUES_H

#include <generator/genfunctioncalculator.h>
#include <generator/genclipper.h>
#include <generator/genminfinder.h>
#include <generator/genmaxfinder.h>
#include <generator/gensum.h>
#include <generator/genphicalculator.h>
#include <generator/genmod.h>
#include <generator/genparameters.h>


class GenModValues
{
public:
    GenModValues(double *modulationValues,
                 QString expression,
                 double start,
                 double end,
                 unsigned long long int timeLength,
                 int fmin,
                 int fmax,
                 int sampleRate);

    double *modulationValues();

private:
    unsigned long long int m_timeLength;
    double *m_modulationValues;
    QString m_expression;
    int m_fmin;
    int m_fmax;
    int m_sampleRate;
    double m_start;
    double m_end;
};

#endif // GENMODVALUES_H
