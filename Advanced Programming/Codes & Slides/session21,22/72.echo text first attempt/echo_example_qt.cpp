#include "echo_example_qt.h"
#include <QLabel>
#include <QLineEdit>
#include <QPushButton>
#include <QSize>
echo_example_qt::echo_example_qt(QWidget *parent)
	: QWidget(parent)
{
	setWindowTitle("Login");
	QLabel *lbl_msg = new QLabel("Message: ", this);
	//lbl_msg->show();
	QLabel *lbl_pwd = new QLabel("Passowrd: ",this);
	lbl_pwd->move(0,40);
	//lbl_pwd->show();
	QLineEdit *led_msg = new QLineEdit(this);
	QSize qs= led_msg->sizeHint();
	led_msg->move(80,0);

	QLabel *lbl_echo = new QLabel(this);
	lbl_echo->move(80, 40);

	lbl_echo->setFixedWidth(qs.rwidth());
	lbl_echo->setFrameStyle(QFrame::Box );

	QPushButton *pbn_send = new QPushButton("Send Message",this);
	pbn_send->move(40,80);

	
}

echo_example_qt::~echo_example_qt()
{

}
