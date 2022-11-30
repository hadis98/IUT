#include "basiclayourproject.h"
#include <QMenu>
#include <QMenuBar>
#include <QAction>
#include <QVBoxLayout>
#include <QHBoxLayout>
#include <QPushButton>
#include <QGroupBox>
#include <QLabel>
#include <QLineEdit>
#include <QTextEdit>
#include  <QFormLayout>
#include <QComboBox>
#include <QSpinBox>
basicLayourProject::basicLayourProject(QWidget *parent)
	: QMainWindow(parent)
{
	//making the menu
	QMenu *fileMenu = menuBar()->addMenu("File");
	QAction *newAction = fileMenu->addAction("Exit");
	

	QVBoxLayout *mainLayout = new QVBoxLayout();
	QWidget *w = new QWidget();
	w->setLayout(mainLayout);
	setCentralWidget(w);


	//the first section:
	QGroupBox *firstGB = new QGroupBox("Horizontal Layout");
	QHBoxLayout *hFirstLayout = new QHBoxLayout();
	QPushButton *pbn1 = new QPushButton("Button 1");
	QPushButton *pbn2 = new QPushButton("Button 2");
	QPushButton *pbn3 = new QPushButton("Button 3");
	QPushButton *pbn4 = new QPushButton("Button 4");
	hFirstLayout->addWidget(pbn1);
	hFirstLayout->addWidget(pbn2);
	hFirstLayout->addWidget(pbn3);
	hFirstLayout->addWidget(pbn4);

	firstGB->setLayout(hFirstLayout);
	mainLayout->addWidget(firstGB);
	
	//the second section
	QGroupBox *secondGB = new QGroupBox("Grid Layout");
	QGridLayout *gSecondLayout = new QGridLayout();
	QLabel *lbl1 = new QLabel("Line 1");
	QLabel *lbl2 = new QLabel("Line 2");
	QLabel *lbl3 = new QLabel("Line 3");
	gSecondLayout->addWidget(lbl1, 1, 0);
	gSecondLayout->addWidget(lbl2, 2,0);
	gSecondLayout->addWidget(lbl3, 3, 0);

	QLineEdit *led1 = new QLineEdit();
	QLineEdit *led2 = new QLineEdit();
	QLineEdit *led3 = new QLineEdit();
	gSecondLayout->addWidget(led1, 1, 2);
	gSecondLayout->addWidget(led2, 2, 2);
	gSecondLayout->addWidget(led3, 3, 2);
	

	QTextEdit *txtEdit = new QTextEdit("This widget takes up about two thirds of the grid layout.");
	gSecondLayout->addWidget(txtEdit, 0, 3, 4,1);

	secondGB->setLayout(gSecondLayout);
	mainLayout->addWidget(secondGB);

	//the third section
	QGroupBox *thirdGB = new QGroupBox("Form Layout");
	QFormLayout *gthirdLayout = new QFormLayout();
	gthirdLayout->addRow(new QLabel("Line1: "), new QLineEdit());
	QComboBox *qcb = new QComboBox();
	qcb->addItem("First Item");
	qcb->addItem("Second Item");
	qcb->addItem("Third Item");

	gthirdLayout->addRow(new QLabel("Line2, long text: "), qcb);
	QSpinBox *spn = new QSpinBox();
	spn->setMaximum(100);
	spn->setMinimum(1);
	gthirdLayout->addRow(new QLabel("Line3: "), spn);
	thirdGB->setLayout(gthirdLayout);
	mainLayout->addWidget(thirdGB);
	

	//the forth section
	QTextEdit *txt = new QTextEdit("This widget takes up all the remaining space in the top-level layout.");
	mainLayout->addWidget(txt);


	//And finally the buttons:
	QPushButton *okPbn = new QPushButton("OK");
	QPushButton *cancelPbn = new QPushButton("Cancel");
	QHBoxLayout *lastl = new QHBoxLayout();
	lastl->setAlignment(Qt::AlignRight);
	lastl->addWidget(okPbn);
	okPbn->setDefault(true);
	
	lastl->addWidget(cancelPbn);
	mainLayout->addLayout(lastl);

}

basicLayourProject::~basicLayourProject()
{

}
