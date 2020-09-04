#include <QCoreApplication>
#include <QDebug>
#include <QDir>
#include <ak.h>
#include <akelement.h>
#include <akvideocaps.h>
#include <akfrac.h>

int main(int argc, char* argv[])
{

    QCoreApplication app(argc,argv);

    qDebug() << "Starting...";
    Ak::registerTypes();

    //This is required and will initialize the IPC system on Windows
    Ak::setQmlEngine(nullptr);

    //Tell the library where to look for plugins
    //TODO Hardcoded for now...
    QStringList searchPaths;
    searchPaths << QCoreApplication::applicationDirPath() + "/AvKysPlugins";

    AkElement::setSearchPaths(searchPaths);

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
        qDebug() << "DRIVER : " << VirtualCameraPtr->property("driver");
        qDebug() << "FORMATS : " << VirtualCameraPtr->property("defaultOutputPixelFormat");

        //Install camera
        //Q_INVOKABLE QString createWebcam(const QString &description,
        //                                 const AkVideoCapsList &formats);

        AkVideoCapsList formats;
        AkVideoCaps caps(AkVideoCaps::Format_yuyv422, 640, 480, AkFrac(15,1));



        formats << caps;

        return QMetaObject::invokeMethod(VirtualCameraPtr.data(),"createWebcam",Q_ARG(QString,"TeraCam"),Q_ARG(AkVideoCapsList, formats));
    }

    return -1;
}
