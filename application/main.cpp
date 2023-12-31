#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>
#include <QtGui/QIcon>


#include "appcore.h"
#include "uiModels/tablemodel.h"
#include "uiModels/listmodel.h"
#include "uiModels/randomgraphmodel.h"

//#include "tablemodel.h"
//#include "listmodel.h"
//#include "randomgraphmodel.h"

int main(int argc, char *argv[]){
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    QQuickStyle::setStyle("Material");
    qputenv("QT_QUICK_CONTROLS_STYLE", QByteArray("Material"));
   // qputenv("QT_QUICK_CONTROLS_MATERIAL_THEME", QByteArray("Light"));

    qputenv("QT_QUICK_CONTROLS_CONF", QByteArray("qrc:/qml/qtquickcontrols2.conf"));

    QString iconPath = QCoreApplication::applicationDirPath() + "/resourses/icon16.png";
    app.setWindowIcon(QIcon(iconPath));
    engine.addImportPath(":/qml");
    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));
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

    qmlRegisterType<ListModel>("CustomListModel", 1, 0, "CustomListModel");
    ListModel* listModel = new ListModel();
    engine.rootContext()->setContextProperty("listModel", listModel);

    qmlRegisterType<RandomGraphModel>("RandomModel", 1, 0, "RandomModel");
    RandomGraphModel* randomModel = new RandomGraphModel();
    engine.rootContext()->setContextProperty("randomModel", randomModel);


    engine.load(url);

    QObject::connect(core, SIGNAL(nodesChange(QVector<QString>)),
                     model, SLOT(updateData(QVector<QString>)));

    QObject::connect(core, SIGNAL(nodesChange(QVector<QVector<QString>>)),
                     model, SLOT(updateData(QVector<QVector<QString>>)));

    QObject::connect(core, SIGNAL(sendNodeNames(QVector<QString>)),
                     listModel, SLOT(loadList(QVector<QString>)));

    return app.exec();
}
