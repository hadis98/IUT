#ifndef LAYOUTPRACTICE_H
#define LAYOUTPRACTICE_H

#include <QtWidgets/QDialog>
#include "ui_layoutpractice.h"
#include <QPushButton>
#include "secondForm.h"
class layoutPractice : public QDialog
{
	Q_OBJECT

public:
	layoutPractice(QWidget *parent = 0);
	~layoutPractice();

private:
	secondForm *sd;
public slots:
	void showSecondForm();
};

#endif // LAYOUTPRACTICE_H
