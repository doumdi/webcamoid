#include <QCoreApplication>
#include <QDebug>
#include <QDir>
#include <ak.h>
#include <akelement.h>

int main(int argc, char* argv[])
{

    QCoreApplication app(argc,argv);

    qDebug() << "Starting...";
    Ak::registerTypes();

    //This is required and will initialize the IPC system on Windows
    //Ak::setQmlEngine(nullptr);

    //Tell the library where to look for plugins
    //TODO Hardcoded for now...
    QStringList searchPaths;
    searchPaths << QCoreApplication::applicationDirPath() + "/AvKysPlugins";

    AkElement::setSearchPaths(searchPaths);

    qDebug() << "VirtualCamera submodules: "<< AkElement::listSubModules("VirtualCamera");

    //This should load the library. Let's see...

    auto VirtualCameraPtr = AkElement::create("VirtualCamera");

    if (VirtualCameraPtr)
    {

        qDebug() << "Setting driver Path";
        QStringList driverPaths;
        QString appPath = QCoreApplication::applicationDirPath();
        driverPaths << appPath;
        VirtualCameraPtr->setProperty("driverPaths",driverPaths);

        qDebug() << "PATH : " << VirtualCameraPtr->property("driverPaths");
        //Uninstall camera
        auto ret = QMetaObject::invokeMethod(VirtualCameraPtr.data(),"removeAllWebcams");

        return ret;
    }

    return -1;
}
