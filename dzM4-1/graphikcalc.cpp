#include <QDebug>
#include "graphikcalc.h"

double func0(const double x) { return sin(x); }

double func1(const double x) { return x; }

double func2(const double x) { return abs(x-2.5); }

double func3(const double x) { return x*x; }

double func4(const double x) { return log2(x); }

typedef // создаем новый прототип (в данном случае указатель на функцию)
    double // возвращаемое значение (такое же как в функциях)
    (*func) // имя прототипа (в коде употребляется без звездочки)
    (const double);

func arr[5] = {func0, func1, func2, func3, func4};

GraphikCalc::GraphikCalc(QObject *parent)
{
    for (int t=0;t<=50;t++)
        x[t] = t*0.1;

    connect(this, &GraphikCalc::modelGraphicChanged, &GraphikCalc::chGraphic);

    modelColor("black");
    graphicModel(0);
    chGraphic(graphicModel());
}

void GraphikCalc::chGraphic(graphicModel g)
{
    for (int t=0;t<=50;t++)
        y[t] = arr[g](x[t]);

    min_Y = 0;
    max_Y = 0;

//    for (int i=0; i < sizeof(y)/sizeof(double); i++)
//    {
//        if ( y[i] > max_Y)
//        {
//            max_Y = y[i];
//        }

//        else if (y[i] < min_Y)
//        {
//            min_Y = y[i];
//        }
//    }
// Возможно надо попробовать https://web-answers.ru/c/kak-poluchit-pravuju-bokovuju-os-v-qml.html

    min_Y = -1;
    max_Y = 7;

    emit graphicReady();
}

double GraphikCalc::getX(int t)
{
    return x[t];
}

double GraphikCalc::getY(int t)
{
    return y[t];
}

double GraphikCalc::maxY()
{
    return max_Y;
}

double GraphikCalc::minY()
{
    return min_Y;
}

