#include "layoutpractice.h"
#include <QVBoxLayout>
#include <QPushButton>
#include <QGroupBox>
#include <QHBoxLayout>
#include <QGridLayout>
#include <QLineEdit>
#include <QLabel>
#include <QTextEdit>
#include <QSpinBox>
#include <QComboBox>
#include <QFormLayout>
#include <QMenuBar>
#include <QMenu>
#include <QAction>

layoutPractice::layoutPractice(QWidget *parent)
	: QDialog(parent)
{
	QVBoxLayout *mainLayout=new QVBoxLayout();
	setWindowTitle("Layout Practice");
	QMenuBar *myMenuBar = new QMenuBar();
	mainLayout->setMenuBar(myMenuBar);
//	QMenu *fileMenu = new QMenu("file");
	//myMenuBar->addMenu(fileMenu);
	QMenu *fileMenu = myMenuBar->addMenu(tr("&File"));
	QMenu *editMenu = myMenuBar->addMenu("Edit");
	QMenu *optionMenu = myMenuBar->addMenu(tr("&Option"));
	QAction *newAction = fileMenu->addAction("New");
	QAction *exitAction = fileMenu->addAction("Exit");



	QGroupBox *gb1 = new QGroupBox("Horizontal Layout");
	QPushButton *pbn1 = new QPushButton("Button 1");
	QPushButton *pbn2 = new QPushButton("Button 2");
	QPushButton *pbn3 = new QPushButton("Button 3");
	QPushButton *pbn4 = new QPushButton("Button 4");

	QHBoxLayout *hbl = new QHBoxLayout();
	gb1->setLayout(hbl);
	hbl->addWidget(pbn1);
	hbl->addWidget(pbn2);
	hbl->addWidget(pbn3);
	hbl->addWidget(pbn4);
	mainLayout->addWidget(gb1);


	QGroupBox *gb2 = new QGroupBox("GridLayout");
	QGridLayout *gl = new QGridLayout();
	gb2->setLayout(gl);

	QLabel *lbl1 = new QLabel("Line 1:");
	QLabel *lbl2 = new QLabel("Line 2:");
	QLabel *lbl3 = new QLabel("Line 3:");

	QLineEdit *led1 = new QLineEdit();
	QLineEdit *led2= new QLineEdit();
	QLineEdit *led3 = new QLineEdit();

	QTextEdit *ted = new QTextEdit("This widget takes up about two thirds of the grid layout.");
	gl->addWidget(lbl1, 1, 0);
	gl->addWidget(lbl2, 2, 0);
	gl->addWidget(lbl3, 3, 0);
	gl->addWidget(led1, 1, 1);
	gl->addWidget(led2, 2, 1);
	gl->addWidget(led3, 3, 1);
	gl->addWidget(ted, 0, 2, 4, 1);
	mainLayout->addWidget(gb2);

	//third row:
	QGroupBox *gb3 = new QGroupBox("Form Layout");
	QFormLayout *fml = new QFormLayout();
	gb3->setLayout(fml);
	QLabel *lbl4 = new QLabel("line 1: ");
	QLabel *lbl5 = new QLabel("line 2, long text: ");
	QLabel *lbl6 = new QLabel("line 3: ");
	QComboBox *cmb = new QComboBox();
	QSpinBox *spn = new QSpinBox();
	spn->setRange(90, 800);
	cmb->addItem("Apple");
	cmb->addItem("Banana");
	cmb->addItem("Kiwi");
	cmb->addItem("Orange");
	QLineEdit *led4 = new QLineEdit();



	fml->addRow(lbl4, led4);
	fml->addRow(lbl5, cmb);
	fml->addRow(lbl6, spn);
	mainLayout->addWidget(gb3);





	//forth row
	QTextEdit *tedBig = new QTextEdit();
	mainLayout->addWidget(tedBig);

	//fifth row:
	QHBoxLayout *hblLast = new QHBoxLayout();
	QPushButton *pbnOk = new QPushButton("Ok");
	QPushButton *pbnCancel = new QPushButton("Cancel");
	hblLast->addWidget(pbnOk);
	pbnOk->setDefault(true);
	hblLast->addWidget(pbnCancel);
	hblLast->setAlignment(Qt::AlignRight);


	mainLayout->addLayout(hblLast);

	setLayout(mainLayout);

	
	connect(pbnOk, SIGNAL(clicked()), this, SLOT(showSecondForm()));



	

}

layoutPractice::~layoutPractice()
{

}
void layoutPractice::showSecondForm()
{
	sd = new secondForm("hellllllllo");
	close();
	sd->show();
}