#ifndef ECHO_EXAMPLE_QT_H
#define ECHO_EXAMPLE_QT_H

#include <QtWidgets/QWidget>
#include "ui_echo_example_qt.h"

class echo_example_qt : public QWidget
{
	Q_OBJECT

public:
	echo_example_qt(QWidget *parent = 0);
	~echo_example_qt();

private:
	Ui::echo_example_qtClass ui;
};

#endif // ECHO_EXAMPLE_QT_H
