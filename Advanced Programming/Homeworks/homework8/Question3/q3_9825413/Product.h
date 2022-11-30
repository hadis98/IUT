#ifndef PRODUCT_H
#define PRODUCT_H
#include <QVector>

class product{
    QString name;
    QString sort;
    double price;
    int num;
public:
    void setName(QString _name){ name = _name; }
    void setSort(QString _sort){ sort = _sort; }
    void setPrice(double _price){ price = _price; }
    void setNum(int  _num){ num = _num; }
    QString getName(){ return name; }
    QString getSort(){ return sort; }
    double getPrice (){ return price; }
    int getNum(){ return num; }
};
extern QVector<product> vec;

#endif // PRODUCT_H
