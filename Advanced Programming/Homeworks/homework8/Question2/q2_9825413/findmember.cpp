#include "findmember.h"

FindMember::FindMember(QWidget *parent) : QDialog(parent)
{
    setWindowTitle("Find");
    Mainlayout = new QGridLayout;
    ledFind = new QLineEdit;
    labelFind = new QLabel("Enter a Name:");
    pbnCancel = new QPushButton("Cancel");
    pbnSearch = new QPushButton("Search");
    Mainlayout->addWidget(labelFind,0,0);
    Mainlayout->addWidget(ledFind,0,1,1,3);
    Mainlayout->addWidget(pbnCancel,1,2);
    Mainlayout->addWidget(pbnSearch,1,3);
    setLayout(Mainlayout);
    pbnSearch->setDefault(true);
    connect(pbnCancel,SIGNAL(clicked()),this,SLOT(close()));
    connect(pbnSearch, SIGNAL(clicked()), this, SLOT(search()));
    connect(pbnSearch, SIGNAL(clicked()), this, SLOT(accept()));
}
QString FindMember::getName()
{
    return NameOFmember;
}

void FindMember::search()
{
    NameOFmember = ledFind->text();
}
