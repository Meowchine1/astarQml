#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "appcore.h"
#include "tablemodel.h"
#include "listmodel.h"

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

    qmlRegisterType<AppCore>("AppCore", 1, 0, "AppCore");
    AppCore* core = new AppCore();
    engine.rootContext()->setContextProperty("appCore", core);

    qmlRegisterType<TableModel>("TableModel", 1, 0, "TableModel");
    TableModel* model = new TableModel();
    engine.rootContext()->setContextProperty("tableModel", model);

    qmlRegisterType<ListModel>("ListModel", 1, 0, "ListModel");
    ListModel* listModel = new ListModel();
    engine.rootContext()->setContextProperty("listModel", listModel);


    engine.load(url);

    QObject::connect(core, SIGNAL(nodesChange(QVector<QString>)),
                     model, SLOT(updateData(QVector<QString>)));

    QObject::connect(core, SIGNAL(nodesChange(QVector<QVector<QString>>)),
                     model, SLOT(updateData(QVector<QVector<QString>>)));

    QObject::connect(core, SIGNAL(sendNodeNames(QVector<QString>)),
                     listModel, SLOT(loadList(QVector<QString>)));


    return app.exec();
}
