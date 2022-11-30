#include "echo_example_qt.h"
#include <QtWidgets/QApplication>

int main(int argc, char *argv[])
{
	QApplication a(argc, argv);
	echo_example_qt w;
	w.show();
	return a.exec();
}
