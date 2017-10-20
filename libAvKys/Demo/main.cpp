#include <QCoreApplication>
#include <QDebug>
#include <QDir>
#include "main.h"

int main(int argc, char* argv[])
{
    QCoreApplication app(argc,argv);

    qDebug() << "Starting...";


    //Tell the library where to look for plugins
    QStringList searchPaths;
    searchPaths << QDir::currentPath() + "/AvKysPlugins";
    AkElement::setSearchPaths(searchPaths);


    AkElement::listSubModules("MultiSrc");

    //This should load the library. Let's see...
    AkElementPtr MultiSrcPtr = AkElement::create("MultiSrc");

    if (MultiSrcPtr)
    {
        qDebug() << "State: " << MultiSrcPtr->state();

        QObject* subModule = MultiSrcPtr->loadSubModule("ffmpeg");
        qDebug() << subModule;

        if (subModule)
        {
            //Set media information
            QMetaObject::invokeMethod(subModule,"setMedia",Q_ARG(QString,"rtsp://admin:admin@localhost:554/live.sdp"));

            //Start loop
            QMetaObject::invokeMethod(subModule,"setState",Q_ARG(AkElement::ElementState,AkElement::ElementStatePlaying));


        }



    }



    //Start event loop
    return app.exec();

}
