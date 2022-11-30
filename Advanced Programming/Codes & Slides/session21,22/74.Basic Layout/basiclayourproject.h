#ifndef BASICLAYOURPROJECT_H
#define BASICLAYOURPROJECT_H

#include <QtWidgets/QMainWindow>
#include "ui_basiclayourproject.h"

class basicLayourProject : public QMainWindow
{
	Q_OBJECT

public:
	basicLayourProject(QWidget *parent = 0);
	~basicLayourProject();

private:
	Ui::basicLayourProjectClass ui;
};

#endif // BASICLAYOURPROJECT_H
