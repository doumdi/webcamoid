#include <QApplication>
#include <QDebug>
#include <QMetaObject>
#include <akvideocaps.h>
#include <ak.h>
#ifndef Q_OS_LINUX
    #include <objbase.h>
#endif
#include <QDir>
#include "main.h"

int main(int argc, char* argv[])
{
    QApplication app(argc,argv);

    qDebug() << "Starting...";
    //Why do we need to do that?
    //qRegisterMetaType<AkPacket>("AkPacket");
    Ak::registerTypes();

    //This is required and will initialize the IPC system on Windows
    Ak::setQmlEngine(nullptr);

    //Tell the library where to look for plugins
    //TODO Hardcoded for now...
    QStringList searchPaths;
    searchPaths << QDir::currentPath() + "/AvKysPlugins";
    AkElement::setSearchPaths(searchPaths);


    qDebug() << "MultiSrc submodules: " << AkElement::listSubModules("MultiSrc");
    qDebug() << "VirtualCamera submodules: "<< AkElement::listSubModules("VirtualCamera");
    qDebug() << "DesktopCapture submodules: "<< AkElement::listSubModules("DesktopCapture");

    //This should load the library. Let's see...
    auto MultiSrcPtr = AkElement::create("MultiSrc");
    auto VirtualCameraPtr = AkElement::create("VirtualCamera");
    auto DesktopCapturePtr = AkElement::create("DesktopCapture");
    QString deviceId;
    AkVideoCapsList formats;

/*
    QMetaObject::invokeMethod(VirtualCameraPtr.data(),
                              "createWebcam",
                              Q_RETURN_ARG(QString, deviceId),
                              Q_ARG(QString, "VirtCam"),
                              Q_ARG(AkVideoCapsList, formats));
*/
    if (MultiSrcPtr && VirtualCameraPtr && DesktopCapturePtr)
    {
        qDebug() << "Linking Src & Dest";
        MultiSrcPtr->link(VirtualCameraPtr);
        //DesktopCapturePtr->link(VirtualCameraPtr);

        DesktopCapturePtr->setProperty("media", "screen://0");
        DesktopCapturePtr->setProperty("fps", "10.0");


        //Set Parameters
        //Start streaming something from VLC at this address for testing...
        MultiSrcPtr->setProperty("media", "rtsp://wowzaec2demo.streamlock.net/vod/mp4:BigBuckBunny_115k.mov");
        //MultiSrcPtr->setProperty("media", "C:/Big_Buck_Bunny_360_10s_30MB.mp4");
        MultiSrcPtr->setProperty("loop", false);          // Loop the video/media if you need it.
        MultiSrcPtr->setProperty("showLog", true);       // Show play log in console, similar to MPlayer and ffplay.

        //First, a virtual camera needs to be created
        VirtualCameraPtr->setProperty("media","/akvcam/video0");
        VirtualCameraPtr->setProperty("swapRgb", true);

        // start the pipeline.
        //DesktopCapturePtr->setState(AkElement::ElementStatePlaying);
        MultiSrcPtr->setState(AkElement::ElementStatePlaying);
        VirtualCameraPtr->setState(AkElement::ElementStatePlaying);

    }

    qDebug() << "Starting event loop";

    //Start event loop
    return app.exec();

}
