#include "myGUIApp.h"
#include <QtWidgets/QApplication>
//Qlabel 
//QlineEdit
//QpushButton
#include <QLabel>
#include <QLineEdit>
#include <QWidget>
#include <QPushButton>
//parent

int main(int argc, char *argv[])
{
	QApplication a(argc, argv);
	QWidget w;
	QLabel lblUser("username");
	QLabel lblPass("password");
	lblUser.setParent(&w);
	lblPass.setParent(&w);
	lblUser.move(150, 200);
	lblPass.move(150, 260);
	QLineEdit ledUser;
	QLineEdit ledPass;
	ledUser.setParent(&w);
	ledPass.setParent(&w);
	ledUser.move(250, 200);
	ledPass.move(250, 260);

	QPushButton pbn("OK");
	pbn.setParent(&w);
	pbn.move(250, 310);
	w.show();

	return a.exec();
}
