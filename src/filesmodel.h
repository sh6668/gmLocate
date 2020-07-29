#ifndef FILESMODEL_H
#define FILESMODEL_H
#include <QAbstractListModel>
#include <QProcess>

class FilesModel : public QAbstractListModel
{
    Q_OBJECT
public:
    //// neuer constructor um obj in qml global zu machen
    FilesModel(QObject * p = nullptr);// : QAbstractListModel(p){};

    /*{
        //backing << "sea cow" << "platypus" << "axolotl" << "quokka" << "pitahui" << "jerboa";

    }*/


    //// alter constructor
    ////explicit FilesModel(QObject *parent = NULL);

    virtual int rowCount(const QModelIndex&) const { return backing.size(); }
    virtual QVariant data(const QModelIndex &index, int role) const;

    QHash<int, QByteArray> roleNames() const;
    Q_INVOKABLE void appends(QString s) ;
    Q_INVOKABLE void activate(const int i);
    Q_INVOKABLE void swap2top(const int i);
    Q_INVOKABLE QString diskFree();
    Q_INVOKABLE int getsMyCounter();
    Q_INVOKABLE int locate(QString s, bool useUserDB, bool ignoreCase = false);
    Q_INVOKABLE QString updateDb(bool useUserDB, bool doUpdate = false);
    Q_INVOKABLE QStringList getFileList();
    Q_INVOKABLE void remove(const int i);
    Q_INVOKABLE bool execXdgOpen(QString filename);
    int lcount = 0;
    enum DemoRoles {
        NameRole = Qt::UserRole + 1,
    };
private:
    //QVector<QString> backing;
    QStringList backing;
    QString systemDB;
    QString userDB;
};
#endif // FILESMODEL_H
