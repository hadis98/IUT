#ifndef FINDMEMBER_H
#define FINDMEMBER_H

#include <QMainWindow>
#include <QObject>
#include <QWidget>
#include  <QLineEdit>
#include <QLabel>
#include <QPushButton>
#include <QGridLayout>
#include <QDialog>
class FindMember : public QDialog
{
    Q_OBJECT
private:
    QLineEdit *ledFind;
    QLabel *labelFind;
    QPushButton *pbnSearch,*pbnCancel;
    QGridLayout *Mainlayout;
    QString NameOFmember;
public:
    explicit FindMember(QWidget *parent = nullptr);
    QString getName();
signals:

public slots:
    void search();
};

#endif // FINDMEMBER_H
