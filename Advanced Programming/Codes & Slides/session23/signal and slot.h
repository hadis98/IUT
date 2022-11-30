#ifndef LAYOUTPRACTICE_H
#define LAYOUTPRACTICE_H

#include <QtWidgets/QDialog>
#include "ui_layoutpractice.h"
#include <QPushButton>
#include <QLineEdit>
class layoutPractice : public QDialog
{
	Q_OBJECT

public:
	layoutPractice(QWidget *parent = 0);
	~layoutPractice();

private:
	QLineEdit *led1, *led2;
public slots:
	void setText();
	void checkText();
signals:
	int sayHello(const QString);
};




#endif // LAYOUTPRACTICE_H
