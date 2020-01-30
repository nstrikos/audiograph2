#ifndef FUNCTIONCONTROLLER_H
#define FUNCTIONCONTROLLER_H

#include <QObject>
#include "functionModel.h"
#include "functionDisplayView.h"

class FunctionController : public QObject
{
    Q_OBJECT

public:
    explicit FunctionController(QObject *parent = nullptr);
    Q_INVOKABLE void displayFunction(QString expression,
                                     QString minX,
                                     QString maxX,
                                     QString minY,
                                     QString maxY);

    void setDisplayView(FunctionDisplayView *view);

    Q_INVOKABLE void zoom(double delta);
    Q_INVOKABLE double minX();
    Q_INVOKABLE double maxX();
    Q_INVOKABLE double minY();
    Q_INVOKABLE double maxY();

signals:
    void updateFinished();
    void error();

private slots:
    void updateDisplayView();
    void clearDisplayView();

private:
    FunctionModel m_model;
    FunctionDisplayView *m_view;
};

#endif // FUNCTIONCONTROLLER_H

