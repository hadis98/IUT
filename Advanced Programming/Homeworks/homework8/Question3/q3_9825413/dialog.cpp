#include "dialog.h"
#include "ui_dialog.h"
#include <QMessageBox>
#include "Product.h"

Dialog::Dialog(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::Dialog)
{
    ui->setupUi(this);
    setFixedSize(241,206);

}

Dialog::~Dialog()
{
    delete ui;
}

void Dialog::on_buttonBox_accepted()
{
    if(ui->lineEdit->text()==NULL || ui->lineEdit_2->text()==NULL || ui->lineEdit_3->text()==NULL || ui->lineEdit_4->text()==NULL)
    {
        QMessageBox *msg = new QMessageBox(this);
        msg->setText("You must fill all of part.");
        msg->setWindowTitle("error");
        msg->setModal(true);
        msg->show();
    }
    else
    {

        product *p = new product();
        p->setName(ui->lineEdit->text());
        p->setSort(ui->lineEdit_2->text());
        p->setPrice(QVariant(ui->lineEdit_3->text()).toDouble());
        p->setNum(QVariant(ui->lineEdit_4->text()).toInt());

        vec.push_back(*p);
        delete p;
    }
}
