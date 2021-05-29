#include <QDebug>
#include "groupsmodel.h"




const QString& GroupItem::name() const
{
    return _name;
}

const QString& GroupItem::photo() const
{
    return _photo;
}

const QString& GroupItem::activity() const
{
    return _activity;
}

GroupItem::GroupItem()
{
}

GroupItem::GroupItem(const QString name, const QString photo, const QString activity)
  :  _name(name), _photo(photo), _activity(activity)
{

}

GroupItem::GroupItem(const GroupItem &t)
{
    _name = t._name;
    _photo = t._photo;
    _activity = t._activity;
}

GroupsModel::GroupsModel(QObject *parent):QAbstractListModel(parent)
{
}


void GroupsModel::GroupsModel::addItem(const GroupItem & newItem)
{
    // не изменяется
  // благодаря beginInsertRows() и endInsertRows() QML реагирует на изменения модели
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    groupList << newItem;
    endInsertRows();
}

int GroupsModel::rowCount(const QModelIndex & /*parent*/) const
{
    return groupList.count();
}

QVariant GroupsModel::data(const QModelIndex & index, int role) const
{
    // метод используется в QML для получения значения одного поля под обозначением role одного элемента модели index
    if (index.row() < 0 || (index.row() >= groupList.count()))
        return QVariant();

    switch (role) {
    case Gname: return groupList[index.row()].name();
    case Gphoto: return groupList[index.row()].photo();
    case Gactivity: return groupList[index.row()].activity();
    }

    return QVariant();
}

QHash<int, QByteArray> GroupsModel::roleNames() const
{
    // метод используется в QML для сопоставления полей данных со строковыми названиями
    QHash<int, QByteArray> roles;

    roles[ Gname ] = "g_name";
    roles[ Gphoto] = "g_photo";
    roles[ Gactivity] = "g_activity";

    return roles;
}

QVariantMap GroupsModel::get(int idx) const
{
    // не изменяется
    // метод используется ListView в QML для получения значений полей idx-го элемента модели
    QVariantMap map;
    foreach(int k, roleNames().keys())
    {
        map[roleNames().value(k)] = data(index(idx, 0), k);
    }
    return map;
}

