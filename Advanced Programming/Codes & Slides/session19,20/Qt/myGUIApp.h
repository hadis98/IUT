#pragma once

#include <QtWidgets/QWidget>
#include "ui_myGUIApp.h"

class myGUIApp : public QWidget
{
	Q_OBJECT

public:
	myGUIApp(QWidget *parent = Q_NULLPTR);

private:
	Ui::myGUIAppClass ui;
};
