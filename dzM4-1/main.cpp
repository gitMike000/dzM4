#include <QApplication>
#include <QQmlApplicationEngine>
//#include "registered_class.h"

#include "graphikcalc.h"

int main(int argc, char *argv[])
{

    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/dzM4-1/main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        }, Qt::QueuedConnection);

    qmlRegisterType<GraphikCalc>("ru.gb.MyGraphikCalc", 1, 0,
                                     "GraphikCalc");

    engine.load(url);

    return app.exec();
}
