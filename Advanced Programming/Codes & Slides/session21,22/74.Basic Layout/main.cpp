#include "basiclayourproject.h"
#include <QtWidgets/QApplication>

int main(int argc, char *argv[])
{
	QApplication a(argc, argv);
	basicLayourProject w;
	w.show();
	return a.exec();
}
