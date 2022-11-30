#pragma once

#include <QtWidgets/QWidget>
#include "ui_qtBasicLayout.h"
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QGroupBox>
#include <QPushButton>
#include <QGridLayout>
#include <QLabel>
#include <QLineEdit>
#include <QTextEdit>
#include <QFormLayout>
#include <QComboBox>
#include <QSpinBox>
#include <QMenuBar>
#include <QMenu>
#include <QAction>

class qtBasicLayout : public QWidget
{
	Q_OBJECT

public:
	qtBasicLayout(QWidget *parent = Q_NULLPTR);

private:
	QVBoxLayout *mainLayout;
	QGroupBox *groupRow1;
	QHBoxLayout *layoutRow1;
	QPushButton *pbn1;
	QPushButton *pbn2;
	QPushButton *pbn3;
	QPushButton *pbn4;

	QGroupBox *groupRow2;
	QGridLayout *layoutRow2;
	
	QLabel *row2Lbl1;
	QLabel *row2Lbl2;
	QLabel *row2Lbl3;

	QLineEdit *row2Led1;
	QLineEdit *row2Led2;
	QLineEdit *row2Led3;

	QTextEdit *row2Ted;
	
	//row3
	QFormLayout *layoutRow3;
	QGroupBox *groupRow3;
	QLabel *row3Lbl1;
	QLabel *row3Lbl2;
	QLabel *row3Lbl3;
	QLineEdit *row3Led1;
	QComboBox *row3Cmb;
	QSpinBox *row3Spn;

	//row4
	QTextEdit *row4Ted;
	
	//row5
	QPushButton *pbnOk;
	QPushButton *pbnCancel;
	QHBoxLayout *layoutRow5;

	//menu
	QMenuBar *mnuBar;
	QMenu *fileMenu, *editMenu;
	QAction *exitAction;
};
