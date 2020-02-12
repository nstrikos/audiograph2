#include "functionDescription.h"

FunctionDescription::FunctionDescription()
{

}

QVector<InterestingPoint> FunctionDescription::points(FunctionModel *model)
{
    InterestingPoint tmp;
    m_points.clear();

    tmp.x = 0;
    tmp.y = model->y(0);
    tmp.label = "starting point";
    m_points.append(tmp);

    if (model == nullptr)
        return m_points;
    else {
        int prev = 0;
        int next = 0;
        for (int i = 0; i < model->lineSize(); i++) {
            prev = i - 1;
            if (prev < 0)
                prev = 0;
            next = i + 1;
            if (next >= model->lineSize())
                next = model->lineSize() - 1;

            if (model->y(i) > model->y(prev) && model->y(i) > model->y(next)) {
                tmp.x = i;
                tmp.y = i;
                tmp.label = "maximum";
                m_points.append(tmp);
            }

            if (model->y(i) < model->y(prev) && model->y(i) < model->y(next)) {
                InterestingPoint tmp;
                tmp.x = i;
                tmp.y = i;
                tmp.label = "minimum";
                m_points.append(tmp);
            }
        }

        tmp.x = model->lineSize() - 1;
        tmp.y = model->y(tmp.x);
        tmp.label = "ending point";
        m_points.append(tmp);

        return m_points;
    }
}
