#include "qtBasicLayout.h"
#include <QtWidgets/QApplication>

int main(int argc, char *argv[])
{
	QApplication a(argc, argv);
	qtBasicLayout w;
	w.show();
	return a.exec();
}
