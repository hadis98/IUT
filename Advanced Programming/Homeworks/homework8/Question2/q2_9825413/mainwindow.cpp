#include "mainwindow.h"
#include "ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent) :
    QWidget(parent)
{
    setWindowTitle("Simple TELEPHONE Book");
    mainlayout = new QGridLayout();
    lbl1 = new QLabel("Name:");
    lbl2 = new QLabel("Telephone:");
    led1 = new QLineEdit();
    tedit = new QTextEdit();
    pbn_add = new QPushButton("&Add");
    pbn_edit = new QPushButton("&Edit");
    pbn_remove = new QPushButton("&Remove");
    pbn_find = new QPushButton("&Find");
    pbn_load = new QPushButton("&Load");
    pbn_save = new QPushButton("Sa&ve");
    pbn_export = new QPushButton("E&xport");
    pbn_previous = new QPushButton("&Previous");
    pbn_next = new QPushButton("&Next");
    pbn_confirm_add = new QPushButton("&Confirm");
    pbn_confirm_edit= new QPushButton("&Confirm");
    pbn_confirm_remove=new QPushButton("&Confirm");
    pbnExit = new QPushButton("Exi&t");
    pbn_confirm_add->hide();
    pbn_confirm_edit->hide();
    pbn_confirm_remove->hide();
    mainlayout->addWidget(pbn_confirm_add,2,5);
    mainlayout->addWidget(pbn_confirm_edit,3,5);
    mainlayout->addWidget(pbn_confirm_remove,4,5);
    pbn_previous->setEnabled(false);pbn_next->setEnabled(false);pbn_save->setEnabled(false);
    pbn_remove->setEnabled(false);pbn_edit->setEnabled(false);pbn_find->setEnabled(false);
    led1->setReadOnly(true);tedit->setReadOnly(true);pbn_export->setEnabled(false);
    //mainlayout->setSizeConstraint(QLayout::SetFixedSize);
    mainlayout->addWidget(lbl1,0,0);
    mainlayout->addWidget(led1,0,1,1,4);
    mainlayout->addWidget(lbl2,1,0);
    mainlayout->addWidget(tedit,1,1,9,4);
    mainlayout->addWidget(pbn_add,1,5);
    mainlayout->addWidget(pbn_edit,2,5);
    mainlayout->addWidget(pbn_remove,3,5);
    mainlayout->addWidget(pbn_find,4,5);
    mainlayout->addWidget(pbn_load,5,5);
    mainlayout->addWidget(pbn_save,6,5);
    mainlayout->addWidget(pbn_export,7,5);
    mainlayout->addWidget(pbnExit,8,5);
    mainlayout->addWidget(pbn_previous,10,1,1,2);
    mainlayout->addWidget(pbn_next,10,3,1,2);
    setLayout(mainlayout);
    //*************** connections ******************/
    connect(pbn_add,SIGNAL(clicked()),this,SLOT(addMember()));
    connect(pbn_confirm_add,SIGNAL(clicked()),this,SLOT(confirmNewMember()));
    connect(pbn_remove,SIGNAL(clicked()),this,SLOT(removeMember()));
    connect(pbn_confirm_remove,SIGNAL(clicked()),this,SLOT(confirmRemoveMember()));
    connect(pbn_edit,SIGNAL(clicked()),this,SLOT(EditMember()));
    connect(pbn_confirm_edit,SIGNAL(clicked()),this,SLOT(confirmEditMember()));
    connect(pbn_find,SIGNAL(clicked()),this,SLOT(find()));
    connect(pbn_save,SIGNAL(clicked()),this,SLOT(saveAs()));
    connect(pbn_export,SIGNAL(clicked()),this,SLOT(saveAs()));
    connect(pbn_load,SIGNAL(clicked()),this,SLOT(load()));
    connect(pbn_next,SIGNAL(clicked()),this,SLOT(nextMember()));
    connect(pbn_previous,SIGNAL(clicked()),this,SLOT(previousMember()));
    connect(pbnExit,SIGNAL(clicked()),this,SLOT(close()));
}

MainWindow::~MainWindow(){}
//************ Add Member *************
void MainWindow::addMember()
{

    if(!Members.isEmpty())
    {
        led1->clear();
        tedit->clear();
    }
    hide_buttonsAdd();
    led1->setFocus();

}
//************** Confirm to Add Member **************
void MainWindow::confirmNewMember()
{
    QString newMemberName,newMemberAddress;
    newMemberName = led1->text();
    newMemberAddress = tedit->toPlainText();
    if(newMemberName.isEmpty() | newMemberAddress.isEmpty())
    {
        QMessageBox::warning(this,"Warning","Pay Attention, all fileds should be completed");
        return;
    }
    if(Members.contains(newMemberName))
        QMessageBox::information(this,tr("Attention"),"the Member "+newMemberName+" has already been in list ");

    else {
        Members.insert(newMemberName,newMemberAddress);
        QMessageBox::information(this,"Successfully added","the Member "+newMemberName+" added to list successfully:)");
    }
    if(Members.isEmpty())
    {
        led1->clear();
        tedit->clear();
    }
    show_buttonsAdd();
}

//*************** remove button ******************
void MainWindow::removeMember()
{
    if(Members.isEmpty())
        QMessageBox::information(this,"Warning","list is empty:(");
    else
        hide_buttonRemove();//if user clicked remove_button then hide all buttons except remove and show confirm button
}
//************ Confirm to remove Member ***************
void MainWindow::confirmRemoveMember()
{
    QString name =led1->text();
    if(Members.contains(name))
    {
        int res = QMessageBox::question(this,"Remove?!","Are you sure you want to remove this member?",QMessageBox::Yes | QMessageBox::No);
        if(res == QMessageBox::Yes)
        {
            if(Members.size()==1)
            {
                Members.remove(name);
                led1->clear();
                tedit->clear();
            }
            else {
                previousMember();
                Members.remove(name);
            }

            QMessageBox::information(this,"Removed Successfully:)","the Member "+name+" Removed Successfully");
        }
    }
show_buttonsRemove();

}
//********** Edit button ***************
void MainWindow::EditMember()
{
hide_buttonsEdit();
MemberName = led1->text();
MemberTelephon = tedit->toPlainText();
}
//*********** Confirm to Edit Members ************8
void MainWindow::confirmEditMember()
{
    QString nameAfterEdit =led1->text();
    QString telephonAfterEdit = tedit->toPlainText();
    if(MemberName == nameAfterEdit)
    {
        int res= QMessageBox::question(this,"Edit","Are you sure to Edit Member's info?",QMessageBox::Yes | QMessageBox::No);
        if(res == QMessageBox::Yes)
            Members[MemberName]=telephonAfterEdit;
        else
           tedit->setText(MemberTelephon);
    }
    else {
        int res= QMessageBox::question(this,"Edit","Are you sure to Edit Member's info?",QMessageBox::Yes | QMessageBox::No);
        if(res == QMessageBox::Yes)
        {
            Members.remove(MemberName);
            Members.insert(nameAfterEdit,telephonAfterEdit);
        }
        else
        {
            led1->setText(MemberName);
            tedit->setText(MemberTelephon);
        }

    }

show_buttonsEdit();
}
//*************** find member ****************
void MainWindow::find()
{
    if(Members.size()==1)
    {
        QMessageBox::warning(this,"Attention","only have one Member");
        return;
    }
    searchMember = new FindMember;
    //qDebug()<<"in find slot1";
    searchMember->show();
    //qDebug()<<"in find slot2";
    if(searchMember->exec()==1)
    {
        //qDebug()<<"in find slot3";
        QString foundName = searchMember->getName();
        if(Members.contains(foundName))
        {
            led1->clear();tedit->clear();
            searchMember->close();
            led1->setText(foundName);
            tedit->setText(Members.value(foundName));
        }
        else {
            QMessageBox::information(this,"NOT FOUND","the Member "+foundName+" Not found in list:(");
        }
    }
}
//*********** save or save as file *****************
void MainWindow::saveAs()
{
    if(!currentFileName.isEmpty())
    {
        QFile file(currentFileName);
        if(file.open(QIODevice::WriteOnly))
        {

            QDataStream out(&file);
            out<<Members;
        }
        else {
            QMessageBox::warning(this,"Can Not Open the File:(",file.errorString());
        }
    }
    else {
        QString fileName = QFileDialog::getSaveFileName(this,"Save To File","untitled.txt");//QFileDialog::getSaveFileName()
        if(!fileName.isEmpty())
        {
            QFile file(fileName);
            if(file.open(QIODevice::WriteOnly))
            {
                currentFileName = fileName;
                QDataStream out(&file);
                out<<Members;
            }
            else {
                QMessageBox::warning(this,"Can Not Open the File:(",file.errorString());
            }
        }
        else {
            return;
        }
    }


}
//********* load file  ****************
void MainWindow::load()
{
    QString fileName = QFileDialog::getOpenFileName(this,"Open File","untitled(*.txt);;All Files(*)");  //QFileDialog::getOpenFileName()
    if(!fileName.isEmpty())
    {
        QFile file(fileName);
        if(file.open(QIODevice::ReadOnly))
        {
            QDataStream in(&file);
            in>>Members;
            QMap<QString,QString>::iterator it = Members.begin();

            led1->setText(it.key());
            tedit->setText(it.value());
            if(Members.isEmpty())
            {
              pbn_remove->setEnabled(false);pbn_edit->setEnabled(false);pbn_find->setEnabled(false);pbn_export->setEnabled(false);
              pbn_save->setEnabled(false);
            }
            else {
                pbn_remove->setEnabled(true);pbn_edit->setEnabled(true);pbn_find->setEnabled(true);pbn_export->setEnabled(true);
                pbn_save->setEnabled(true);
            }
            if(Members.size()==1 || Members.isEmpty())
            {
                pbn_next->setEnabled(false);pbn_previous->setEnabled(false);
            }
            else {
                pbn_next->setEnabled(true);pbn_previous->setEnabled(true);
            }
        }
        else {
            QMessageBox::warning(this,"Can Not Open the File:(",file.errorString());
        }
    }
    else {
        return;
    }
}
//************ Next button **************
void MainWindow::nextMember()
{
    QString name = led1->text();
    QMap<QString, QString>::iterator it = Members.find(name);

    if (it != Members.end())
        it++;

    if (it == Members.end())
        it = Members.begin();
    led1->setText(it.key());
    tedit->setText(it.value());
}
//***************** previus button ***************
void MainWindow::previousMember()
{

    QString current_memberName = led1->text();// see the current member
    QMap<QString,QString>::iterator it;// define an iterator to get the current place
    it=Members.find(current_memberName);

    if (it == Members.end() || Members.isEmpty()) {
        led1->clear();
        tedit->clear();
        return;
    }

    if (it == Members.begin())
        it = Members.end();

    it--;
    if(Members.isEmpty())
    {
        led1->clear();
        tedit->clear();
        return;
    }
    led1->setText(it.key());
    tedit->setText(it.value());

}
//************ procces when Add button clicked(disable and hide and show and .... buttons) ****
void MainWindow::hide_buttonsAdd()
{
    pbn_add->setEnabled(false); pbn_next->setEnabled(false);pbn_previous->setEnabled(false);
    led1->setReadOnly(false);tedit->setReadOnly(false);
    pbn_edit->hide();pbn_find->hide();pbn_save->hide();pbn_find->hide();
    pbn_export->hide();pbn_remove->hide();pbn_load->hide();pbn_confirm_remove->hide();
    pbn_confirm_add->show();pbn_confirm_edit->hide();
}
void MainWindow::show_buttonsAdd()
{
    pbn_edit->show();pbn_find->show();pbn_save->show();pbn_find->show();
    pbn_export->show();pbn_remove->show();pbn_load->show();
    led1->setReadOnly(true);tedit->setReadOnly(true);
    pbn_remove->setEnabled(true);pbn_edit->setEnabled(true);pbn_find->setEnabled(true);pbn_add->setEnabled(true);
    pbn_save->setEnabled(true);pbn_confirm_edit->hide();pbn_export->setEnabled(true); pbn_confirm_remove->hide();
    if(Members.size()>1)
    {
        pbn_previous->setEnabled(true);pbn_next->setEnabled(true);

    }
}
//************ procces when Remove button clicked(disable and hide and show and .... buttons) ****
void MainWindow::hide_buttonRemove()
{
    pbn_add->hide();pbn_edit->hide();pbn_find->hide();pbn_load->hide();pbn_confirm_add->hide();
    pbn_save->hide();pbn_export->hide();pbn_next->setEnabled(false);pbn_previous->setEnabled(false);
    pbn_remove->setEnabled(false);pbn_confirm_edit->hide();
    pbn_confirm_remove->show();
}
void MainWindow::show_buttonsRemove()
{
    pbn_add->show();pbn_edit->show();pbn_find->show();pbn_load->show();pbn_remove->setEnabled(true);
     pbn_save->show();pbn_export->show();pbn_next->setEnabled(true);pbn_previous->setEnabled(true);
    if(Members.isEmpty())
    {
      pbn_remove->setEnabled(false);pbn_edit->setEnabled(false);pbn_find->setEnabled(false);pbn_export->setEnabled(false);
      pbn_save->setEnabled(false);pbn_next->setEnabled(false);pbn_previous->setEnabled(false);
    }

    if(Members.size()==1 )
    {
        pbn_next->setEnabled(false);pbn_previous->setEnabled(false);
    }

}
//************ procces when Edit button clicked(disable and hide and show and .... buttons) ****
void MainWindow::hide_buttonsEdit()
{
    tedit->setReadOnly(false);led1->setReadOnly(false);
    pbn_edit->setEnabled(false);pbn_next->setEnabled(false);pbn_previous->setEnabled(false);
    pbn_confirm_edit->show();pbn_confirm_remove->hide();pbn_confirm_add->hide();
    pbn_add->hide();pbn_remove->hide();pbn_find->hide();pbn_load->hide();pbn_confirm_add->hide();
    pbn_save->hide();pbn_export->hide();
}

void MainWindow::show_buttonsEdit()
{
    pbn_add->show();pbn_remove->show();pbn_find->show();pbn_load->show();pbn_save->show();
    pbn_edit->setEnabled(true);pbn_export->show();pbn_next->setEnabled(true);pbn_previous->setEnabled(true);
    led1->setReadOnly(true);tedit->setReadOnly(true);
    if(Members.size()==1 || Members.size()==0)
    {
        pbn_next->setEnabled(false);pbn_previous->setEnabled(false);
    }
}
