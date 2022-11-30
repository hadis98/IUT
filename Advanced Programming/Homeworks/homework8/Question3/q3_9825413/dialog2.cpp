#include "dialog2.h"
#include "ui_dialog2.h"
#include <QMessageBox>

Dialog2::Dialog2(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::Dialog2)
{
    ui->setupUi(this);
    gbox = new QGroupBox("product");
    gbox->setVisible(false);
    form = new QFormLayout();
    lbl1 = new QLabel("Name");
    lbl2 = new QLabel("Sort");
    lbl3 = new QLabel("Price");
    lbl4 = new QLabel("Quantity");
    led1 = new QLineEdit();
    led2 = new QLineEdit();
    led3 = new QLineEdit();
    led4 = new QLineEdit();
    form->addRow(lbl1,led1);
    form->addRow(lbl2,led2);
    form->addRow(lbl3,led3);
    form->addRow(lbl4,led4);
    gbox->setLayout(form);
    ui->gridLayout->addWidget(gbox,1,0,1,3);

}

Dialog2::~Dialog2()
{
    delete ui;
}

void Dialog2::on_pushButton_clicked()
{
    product *p = new product();
    int i;
    for(i=0;i<vec.size();i++){
        if(ui->lineEdit->text() == vec[i].getName()){
            p->setName(vec[i].getName());
            p->setSort(vec[i].getSort());
            p->setPrice(vec[i].getPrice());
            p->setNum(vec[i].getNum());
            break;
        }
    }

    if(i>= vec.size())
    {
        QMessageBox *msg = new QMessageBox(this);
        msg->setModal(true);
        msg->setText("Not found!");
        msg->show();
    }
    else
    {
        led1->setText(p->getName());
        led2->setText(p->getSort());
        QString str = QString::number(p->getPrice());
        led3->setText(str);
        str = QString::number(p->getNum());
        led4->setText(str);

        led1->setReadOnly(true);
        led2->setReadOnly(true);
        led3->setReadOnly(true);
        led4->setReadOnly(true);

        gbox->show();

    }
}

void Dialog2::on_buttonBox_accepted()
{
    QString _name = led1->text();
    if(_name.isEmpty())
    {
        reject();
        return;
    }
    accept();
}

void Dialog2::on_buttonBox_rejected()
{
    reject();
}

QString Dialog2::getName(){
    return led1->text();
}

double Dialog2::getPrice(){
    return led3->text().toDouble();
}
