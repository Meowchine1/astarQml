#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "graph.h"
#include "nodetablemodel.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    qmlRegisterType<Graph>("Graph", 1, 0, "Graph");

    qmlRegisterType<NodeTableModel>("TableModel", 1, 0, "TableModel");
    NodeTableModel* model = new NodeTableModel();

    engine.rootContext()->setContextProperty("myModel", model);
    engine.load(url);

    return app.exec();
}
