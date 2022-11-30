#include "secondClass.h"
#include <QLabel>


secondClass::secondClass(QString str)
{
	QLabel *lbl = new QLabel("Welcome " + str,this);
}


secondClass::~secondClass()
{
}
