#ifndef DIALOG2_H
#define DIALOG2_H

#include <QDialog>
#include <QGroupBox>
#include <QFormLayout>
#include <QLabel>
#include <QLineEdit>
#include <Product.h>


namespace Ui {
class Dialog2;
}

class Dialog2 : public QDialog
{
    Q_OBJECT

public:
    explicit Dialog2(QWidget *parent = nullptr);
    ~Dialog2();
    QString getName();
    double getPrice();

private slots:
    void on_pushButton_clicked();

    void on_buttonBox_accepted();

    void on_buttonBox_rejected();

private:
    Ui::Dialog2 *ui;
    QGroupBox *gbox;
    QFormLayout *form;
    QLabel *lbl1;
    QLabel *lbl2;
    QLabel *lbl3;
    QLabel *lbl4;
    QLineEdit *led1;
    QLineEdit *led2;
    QLineEdit *led3;
    QLineEdit *led4;
};

#endif // DIALOG2_H
