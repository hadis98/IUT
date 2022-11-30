#ifndef MAINWINDOW_H
#define MAINWINDOW_H
#include <QMap>
#include <QMainWindow>
#include <QPushButton>
#include <QLabel>
#include <QTextEdit>
#include <QLineEdit>
#include <QGridLayout>
#include <QMessageBox>
#include <QDebug>
#include <QFileDialog>
#include <QMenuBar>
#include <QMenu>
#include <QAction>
#include "findmember.h"
class MainWindow : public QWidget
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = nullptr);
    ~MainWindow();
private slots:
    void addMember();
    void confirmNewMember();
    void removeMember();
    void confirmRemoveMember();
    void EditMember();
    void confirmEditMember();
    void nextMember();
    void previousMember();
    void find();
    void load();
    void saveAs();

private:
    QMap<QString,QString> Members;
    QString MemberName;
    QString MemberTelephon;
    QString currentFileName;
    QGridLayout *mainlayout;
    QLabel *lbl1;
    QLabel *lbl2;
    QLineEdit *led1;
    QTextEdit *tedit;
    FindMember *searchMember;
    QPushButton *pbn_add,*pbn_edit,*pbn_remove,*pbn_find,*pbn_load,
    *pbn_save,*pbn_export,*pbn_previous,*pbn_next,*pbn_confirm_add,
    *pbn_confirm_remove,*pbn_confirm_edit,*pbnExit;
    void hide_buttonsAdd();
    void show_buttonsAdd();
    void hide_buttonRemove();
    void show_buttonsRemove();
    void hide_buttonsEdit();
    void show_buttonsEdit();

};

#endif // MAINWINDOW_H
