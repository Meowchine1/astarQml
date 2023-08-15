#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "appcore.h"
#include "tablemodel.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.addImportPath(":/qml");
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    qmlRegisterType<AppCore>("Graph", 1, 0, "Graph");
    AppCore* core = new AppCore();
    engine.rootContext()->setContextProperty("appCore", core);

    qmlRegisterType<TableModel>("TableModel", 1, 0, "TableModel");
    TableModel* model = new TableModel();

    engine.rootContext()->setContextProperty("myModel", model);
    engine.load(url);

    return app.exec();
}
