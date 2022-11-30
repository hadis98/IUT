#include "echo_example_qt.h"
#include <QLabel>
#include <QLineEdit>
#include <QPushButton>
#include <QSize>
#include <QGridLayout>
echo_example_qt::echo_example_qt(QWidget *parent)
	: QWidget(parent)
{
	setWindowTitle("Login");
	
	QGridLayout *gl = new QGridLayout();
	gl->setSizeConstraint(QLayout::SetFixedSize);

	QLabel *lbl_msg = new QLabel("Message: ");
	gl->addWidget(lbl_msg,0,0);
	//lbl_msg->show();
	QLabel *lbl_pwd = new QLabel("Passowrd: ");

	gl->addWidget(lbl_pwd,1,0);
	//lbl_pwd->show();
	QLineEdit *led_msg = new QLineEdit();
	gl->addWidget(led_msg,0,1,1,2);

	//QSize qs= led_msg->sizeHint();
//	led_msg->move(80,0);

	QLabel *lbl_echo = new QLabel(this);
	//lbl_echo->move(80, 40);
	gl->addWidget(lbl_echo, 1,1,1,2);

	//lbl_echo->setFixedWidth(qs.rwidth());
	lbl_echo->setFrameStyle(QFrame::Box );

	QPushButton *pbn_send = new QPushButton("Send Message",this);
	//pbn_send->move(40,80);
	gl->addWidget(pbn_send, 2,2);
	setLayout(gl);

}

echo_example_qt::~echo_example_qt()
{

}
