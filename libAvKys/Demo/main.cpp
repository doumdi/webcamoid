#include <QCoreApplication>
#include <QDebug>
#include <QDir>
#include "main.h"

int main(int argc, char* argv[])
{
    QCoreApplication app(argc,argv);

    qDebug() << "Starting...";


    //Tell the library where to look for plugins
    //TODO Hardcoded for now...
    QStringList searchPaths;
    searchPaths << QDir::currentPath() + "/AvKysPlugins";
    AkElement::setSearchPaths(searchPaths);


    qDebug() << "MultiSrc submodules: " << AkElement::listSubModules("MultiSrc");
    qDebug() << "VirtualCamera submodules: "<< AkElement::listSubModules("VirtualCamera");

    //This should load the library. Let's see...
    auto MultiSrcPtr = AkElement::create("MultiSrc");
    auto VirtualCameraPtr = AkElement::create("VirtualCamera");

    if (MultiSrcPtr && VirtualCameraPtr)
    {
        qDebug() << "Linking Src & Dest";
        MultiSrcPtr->link(VirtualCameraPtr);


        //Set Parameters
        MultiSrcPtr->setProperty("media", "rtsp://user:password@192.168.0.44:554/live.sdp");
        MultiSrcPtr->setProperty("loop", true);          // Loop the video/media if you need it.
        MultiSrcPtr->setProperty("showLog", true);       // Show play log in console, similar to MPlayer and ffplay.


        // start the pipeline.
        MultiSrcPtr->setState(AkElement::ElementStatePlaying);
        VirtualCameraPtr->setState(AkElement::ElementStatePlaying);

    }

    //Start event loop
    return app.exec();

}
