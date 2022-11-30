#include "qtBasicLayout.h"

qtBasicLayout::qtBasicLayout(QWidget *parent)
	: QWidget(parent)
{
	mainLayout = new QVBoxLayout();
	//menu
	mnuBar = new QMenuBar();
	mainLayout->setMenuBar(mnuBar);
	fileMenu = new QMenu("File");
	mnuBar->addMenu(fileMenu);
	editMenu = new QMenu("Edit");
	mnuBar->addMenu(editMenu);
	exitAction = new QAction("Exit");
	fileMenu->addAction(exitAction);
	QMenu *testMenu = new QMenu("Test Menu");
	fileMenu->addMenu(testMenu);
	testMenu->addAction(new QAction("test"));





	
	//row1
	layoutRow1 = new QHBoxLayout();
	groupRow1 = new QGroupBox("Horizontal Layout");
	groupRow1->setLayout(layoutRow1);
	pbn1 = new QPushButton("Button 1");
	pbn2 = new QPushButton("Button 2");
	pbn3 = new QPushButton("Button 3");
	pbn4 = new QPushButton("Button 4");
	layoutRow1->addWidget(pbn1);
	layoutRow1->addWidget(pbn2);
	layoutRow1->addWidget(pbn3);
	layoutRow1->addWidget(pbn4);
	mainLayout->addWidget(groupRow1);

	//row2 
	groupRow2 = new QGroupBox("GridLayout");
	layoutRow2 = new QGridLayout();
	row2Lbl1 = new QLabel("Line 1: ");
	row2Lbl2 = new QLabel("Line 2: ");
	row2Lbl3 = new QLabel("Line 3: ");

	row2Led1 = new QLineEdit();
	row2Led2 = new QLineEdit();
	row2Led3 = new QLineEdit();
	row2Ted = new  QTextEdit("This widget takes up about two thirds of the grid layout.");
	
	layoutRow2->addWidget(row2Lbl1, 1, 0);
	layoutRow2->addWidget(row2Lbl2, 2, 0);
	layoutRow2->addWidget(row2Lbl3, 3, 0);
	
	layoutRow2->addWidget(row2Led1, 1, 1);
	layoutRow2->addWidget(row2Led2, 2, 1);
	layoutRow2->addWidget(row2Led3, 3, 1);
	layoutRow2->addWidget(row2Ted, 0, 2,4,1);
		
	groupRow2->setLayout(layoutRow2);
	mainLayout->addWidget(groupRow2);
	
	//Row3 

	layoutRow3 = new QFormLayout();
	groupRow3 = new QGroupBox("FormLayout");
	row3Lbl1 = new QLabel("Line 1: ");
	row3Lbl2 = new QLabel("Line 2:long text: ");
	row3Lbl3 = new QLabel("Line 3: ");
	row3Led1 = new QLineEdit();
	row3Cmb = new QComboBox();
	row3Spn = new QSpinBox();
	
	layoutRow3->addRow(row3Lbl1, row3Led1);
	layoutRow3->addRow(row3Lbl2, row3Cmb);
	layoutRow3->addRow(row3Lbl3, row3Spn);
	row3Cmb->addItem("Apple");
	row3Cmb->addItem("Banana");
	row3Cmb->addItem("Kiwi");
	row3Spn->setMinimum(10);
	row3Spn->setMaximum(999);
	groupRow3->setCheckable(true);
	groupRow3->setChecked(false);
	groupRow3->setLayout(layoutRow3);
	mainLayout->addWidget(groupRow3);
	
	//row4
	row4Ted = new QTextEdit("This widget takes up all the remaining space in the top-level layout.");
	mainLayout->addWidget(row4Ted);

	//row5
	layoutRow5 = new QHBoxLayout();
	pbnOk = new QPushButton("Ok");
	pbnCancel = new QPushButton("Cancel");
	layoutRow5->addWidget(pbnOk);
	layoutRow5->addWidget(pbnCancel);
	layoutRow5->setAlignment(Qt::AlignRight);
	pbnOk->setDefault(true);
	mainLayout->addLayout(layoutRow5);
	
	setLayout(mainLayout);

}
