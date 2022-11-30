#include "secondForm.h"
#include <QLabel>
#include <QPushButton>
#include <QVBoxLayout>

secondForm::secondForm(QString str)
{
	QVBoxLayout *vbl = new QVBoxLayout();
	QPushButton *pbn = new QPushButton("Done!");
	QLabel *lbl = new QLabel(str);
	vbl->addWidget(lbl);
	vbl->addWidget(pbn);
	setLayout(vbl);

}


secondForm::~secondForm()
{
}
