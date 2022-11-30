#include "mainwindow.h"
#include "ui_mainwindow.h"
#include "dialog.h"
#include "dialog2.h"
#include <QMessageBox>


QVector<product> vec;
void PushBack(){
    product *p;
    p = new product();
    p->setName("a"); p->setSort("1"); p->setPrice(2000); p->setNum(2);
    vec.push_back(*p);

    p->setName("b"); p->setSort("1"); p->setPrice(2340.89); p->setNum(10);
    vec.push_back(*p);

    p->setName("c"); p->setSort("2"); p->setPrice(8400); p->setNum(3);
    vec.push_back(*p);

    p->setName("d"); p->setSort("3"); p->setPrice(7890); p->setNum(20);
    vec.push_back(*p);

    p->setName("e"); p->setSort("4"); p->setPrice(2130); p->setNum(11);
    vec.push_back(*p);

    p->setName("f"); p->setSort("4"); p->setPrice(200); p->setNum(5);
    vec.push_back(*p);

    p->setName("g"); p->setSort("4"); p->setPrice(3000); p->setNum(3);
    vec.push_back(*p);

    p->setName("h"); p->setSort("4"); p->setPrice(22000.2); p->setNum(0);
    vec.push_back(*p);

    p->setName("i"); p->setSort("5"); p->setPrice(5600); p->setNum(2);
    vec.push_back(*p);

    p->setName("x"); p->setSort("6"); p->setPrice(55.5); p->setNum(7);
    vec.push_back(*p);

    delete p;
}

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    PushBack();
}

MainWindow::~MainWindow()
{
    delete ui;
}


void MainWindow::on_pushButton_clicked()
{
    QString _name;
    double _price;
    int res;
    dlg2 = new Dialog2(this);
    dlg2->setModal(true);
    res = dlg2->exec();
    if(res == QDialog::Rejected)
        return;
    _name = dlg2->getName();
    _price = dlg2->getPrice();
    int fila = ui->tableWidget->rowCount();
    ui->tableWidget->insertRow(fila);
    ui->tableWidget->setItem(fila,0,new QTableWidgetItem(_name));
    ui->tableWidget->setItem(fila,1,new QTableWidgetItem(QString::number(_price)));
    ui->tableWidget->setCellWidget(fila,2,new QSpinBox());

}

void MainWindow::on_pushButton_3_clicked()
{
    /*Dialog dlg;
    dlg.setModal(true);
    dlg.exec();*/
    //dlg1->show();
    Dialog * dlg1 = new Dialog(this);
    dlg1->setModal(true);
    dlg1->exec();
}

void MainWindow::on_pushButton_2_clicked()
{
    int numberOfRow = ui->tableWidget->rowCount();
    int sum = 0;
    for(int i=0 ; i< numberOfRow ; i++){
        double _price = ui->tableWidget->item(i,1)->text().toDouble();
        QSpinBox *temp = (QSpinBox *)ui->tableWidget->cellWidget(i,2);
        int _num = temp->value();
        QString _name = ui->tableWidget->item(i,0)->text();
        if(!checkNumber(_name,_num)){
            QMessageBox::information(this, tr("Message"),
                tr("Please check the number of product."));
            return;
        }
        sum += (_price * _num);
    }
    int res = QMessageBox::information(this, tr("Complete"),"You must pay " + QString::number(sum)
                                       ,QMessageBox::Yes|QMessageBox::No);

    if(res == QMessageBox::Yes){
        for(int i=0 ; i< numberOfRow ; i++){
            QSpinBox *temp = (QSpinBox*)ui->tableWidget->cellWidget(i,2);
            int _num = temp->value();
            QString _name = ui->tableWidget->item(i,0)->text();
            updateNumber(_name,_num);
        }
        QMessageBox::information(this,"Result","Buy is done successfully");

        numberOfRow = ui->tableWidget->rowCount();
        for(int i=0 ; i<numberOfRow ; i++){
            ui->tableWidget->removeCellWidget(i,2);
            ui->tableWidget->removeRow(0);
        }
    }

}

bool MainWindow::checkNumber(QString _name, int _num){
    for(int i=0 ; i< vec.size(); i++){
        if(vec[i].getName() == _name){
            if(vec[i].getNum() >= _num)
                return true;
            else
                return false;
        }
    }
    return false;
}

void MainWindow::updateNumber(QString _name, int _num){
    for(int i=0 ; i< vec.size(); i++){
        if(vec[i].getName() == _name){
            vec[i].setNum(vec[i].getNum() - _num);
        }
    }
}
