#pragma once

#include <QObject>

#include "auto_property.h"

class GraphikCalc : public QObject
{
    Q_OBJECT

    enum graphicModel {
        sinus = 0, // "y = sin(x)",
        linear = 1, // "y = x",
        modul = 2, //"y = |x - 2.5|",
        cubic = 3, //"y = x ^ 2",
        logariphm =4 //"y = log2(x)"
    };

    AUTO_PROPERTY(QString, modelColor)
    AUTO_PROPERTY(graphicModel, modelGraphic)   

public:
    explicit GraphikCalc(QObject *parent = nullptr);

    // Методы, вызов которого будет возможен из QML
//    Q_INVOKABLE void chGraphic(/*int*/);
//    Q_INVOKABLE void chColor(/*int*/);

    Q_INVOKABLE double getX(int);
    Q_INVOKABLE double getY(int);

    Q_INVOKABLE double maxY();
    Q_INVOKABLE double minY();

signals:
    void graphicReady();

public slots:
//    void registeredClassSlot(); // Слот назван отлично от автоматически сгенерированного в QML
    void chGraphic(graphicModel);

private:
//    double func0(const double x) { return sin(x); }

//    double func1(const double x) { return x; }

//    double func2(const double x) { return abs(x-2.5); }

//    double func3(const double x) { return x*x; }

//    double func4(const double x) { return log2(x); }

private:
    double x[50];
    double y[50];
    double min_Y;
    double max_Y;

//    typedef // создаем новый прототип (в данном случае указатель на функцию)
//        double // возвращаемое значение (такое же как в функциях)
//        (*func) // имя прототипа (в коде употребляется без звездочки)
//        (const double);

//    func arr[4] = {func0, func1, func2, func3, func4};

};


