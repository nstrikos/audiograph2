#include "functionDisplayViewInterface.h"
#include <QDebug>

FunctionDisplayViewInterface::FunctionDisplayViewInterface()
{
    qDebug() << "FunctionDisplayViewInterface: create function display view interface";
    m_model = nullptr;
}

FunctionDisplayViewInterface::~FunctionDisplayViewInterface()
{
    qDebug() << "FunctionDisplayViewInterface: delete function display view interface";
}

void FunctionDisplayViewInterface::calcCoords(int width, int height)
{
    if (m_model != nullptr) {

        qDebug() << "FunctionDisplayViewInterface: calculate screen coords";

        m_points.clear();
        Point tmpPoint;

        int size = m_model->lineSize();

        double xStart = m_model->x(0);
        double xEnd = m_model->x(size - 1);

        for (int i = 0; i < size; i++) {
            if (m_model->isValid(i)) {
                double minY = m_model->minY();
                double maxY = m_model->maxY();

                double x =  ( width / (xEnd - xStart) * (m_model->x(i) - xStart) );
                double y = ( height / (maxY - minY) * (m_model->y(i) - minY) );

                y = height - y;
                tmpPoint.x = x;
                tmpPoint.y = y;
            } else {
                tmpPoint.x = -30;
                tmpPoint.y = -30;
            }
            m_points.append(tmpPoint);
        }
    }
}
