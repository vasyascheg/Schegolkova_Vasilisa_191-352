#ifndef GROUPSMODEL_H
#define GROUPSMODEL_H

#include <QAbstractListModel>

class GroupItem  : public QObject
{
    Q_OBJECT

private:
    QString _name; // лаб 5
    QString _photo;
    QString _activity;

public:

    GroupItem();
    GroupItem(const QString name, const QString photo, const QString activity);
    GroupItem(const GroupItem &t);

    const QString& name() const;
    const QString& photo() const;
    const QString& activity() const;

};




class GroupsModel : public QAbstractListModel
{
private:
    QList<GroupItem> groupList;
public:
    enum enmRoles {   //список именованных чисел
        Gname = Qt::UserRole + 1,
        Gphoto,
        Gactivity
    };

    GroupsModel(QObject *parent=0);


    //Модификатор override может использоваться с любым методом, который должен быть переопределением
    void addItem(const GroupItem & newItem);
    int rowCount(const QModelIndex & parent = QModelIndex()) const override;
    QVariant data(const QModelIndex & index, int role=Qt::DisplayRole) const override;


    QVariantMap get(int idx) const;


protected:
    QHash<int, QByteArray> roleNames() const override;
    // ключ - значение
    // нужен, чтобы строковые имена приводить в соответствие к полям френда





};




#endif // GROUPSMODEL_H





