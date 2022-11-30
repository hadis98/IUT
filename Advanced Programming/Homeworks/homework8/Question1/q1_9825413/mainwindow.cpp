#include "mainwindow.h"
#include "ui_mainwindow.h"

mainWindow::mainWindow()
{
       textEdit = new QPlainTextEdit;
       setCentralWidget(textEdit);
       menuBar = new QMenuBar();
       this->setMenuBar(menuBar);
       fileMenu = new QMenu(tr("&File"));
       menuBar->addMenu(fileMenu);
       openFile = new QAction(tr("&Open"));
       openFile->setShortcut(tr("Ctrl+O"));
       openFile->setStatusTip(tr("Open a New File"));
       saveFile = new QAction(tr("&Save"));
       saveFile->setStatusTip(tr("Save the File after new changes"));
       saveFile->setShortcut(tr("Ctrl+S"));
       Exit = new QAction(tr("&Exit"));
       Exit->setShortcut(tr("Ctrl+Q"));
       Exit->setStatusTip(tr("Click to Exit the program"));
       fileMenu->addAction(openFile);
       fileMenu->addAction(saveFile);
       fileMenu->addAction(Exit);
       //****** connections *********
       connect(openFile,SIGNAL(triggered()),this,SLOT(open()));
       connect(saveFile,SIGNAL(triggered()),this,SLOT(saveAs()));
       connect(Exit,SIGNAL(triggered()),this,SLOT(close()));//exit
       statusBar()->showMessage(tr("write something ..."));
       this->setSizeIncrement(300,300);
       connect(textEdit->document(), SIGNAL(contentsChanged()),this, SLOT(fileModified()));
       SetInUseFile("");
}

mainWindow::~mainWindow(){}
//******** open a file **********8
void mainWindow::open()
{
    if (SaveChanges()) {
        QString fileName = QFileDialog::getOpenFileName(this);
      if (!fileName.isEmpty())
            readFile(fileName);
    }
    else {
        QString fileName = QFileDialog::getOpenFileName(this);
      if (!fileName.isEmpty())
            readFile(fileName);
    }
}
//********** save or save as a file **********
bool mainWindow::saveAs()
{
    if(currentFileName.isEmpty())
    {
        QString fileName = QFileDialog::getSaveFileName(this,"Save To File","untitled.txt");//QFileDialog::getSaveFileName()
        if(!fileName.isEmpty())
        {
            QFile file(fileName);
            if(file.open(QIODevice::WriteOnly))
            {
                currentFileName = fileName;
                QDataStream out(&file);
                out << textEdit->toPlainText();
                statusBar()->showMessage(tr("File Saved:)"),3000);
                SetInUseFile(fileName);
                return  true;
            }
            else {
                QMessageBox::warning(this,"Can Not Open the File:(",file.errorString());
                return  false;
            }
        }
        else {
            return false;
        }
    }else {
    SaveFile(currentFileName);
    return  true;
    }

}

void mainWindow::SaveFile(const QString &fileName)
{
    QFile file(fileName);
    if(file.open(QFile::WriteOnly |  QFile::Text))
    {
        QTextStream out(&file);
        out << textEdit->toPlainText();
        SetInUseFile(fileName);
        statusBar()->showMessage(tr("File Saved:)"),3000);

    }
    else {
        QMessageBox::warning(this,tr("TextEditor"),tr("Cannot Write File:(").arg(QDir::toNativeSeparators(fileName),file.errorString()));

    }
}
void mainWindow::readFile(const QString &fileName)
{
    QFile file(fileName);
    if(file.open(QFile::ReadOnly |  QFile::Text))
    {
        QTextStream in(&file);
        textEdit->setPlainText(in.readAll());
        SetInUseFile(fileName);
        statusBar()->showMessage(tr("File Uploaded:)"),3000);
    }
    else {
        QMessageBox::warning(this,tr("TextEditor"),tr("Cannot Read File:(").arg(QDir::toNativeSeparators(fileName),file.errorString()));
        return;
    }

}
bool mainWindow::SaveChanges()
{
    if(textEdit->document()->isModified())
        {
        QMessageBox::StandardButton res = QMessageBox::question(this,tr("TextEditor"),tr("the file has been edited.\n Want to save it?"),QMessageBox::Yes | QMessageBox::No) ;
            if(res == QMessageBox::Yes)
                return saveAs();
            else
                return false;

    }

    else {
        return true;
    }
}
void mainWindow::SetInUseFile(const QString &fileName)
{
    currentFileName = fileName;
    textEdit->document()->setModified(false);
    setWindowModified(false);
    QString NameOfFileToBeShown = currentFileName;
    if(currentFileName.isEmpty()) NameOfFileToBeShown = "unknown.txt";
    setWindowFilePath(NameOfFileToBeShown);

}
void mainWindow::fileModified()
{
    setWindowModified(textEdit->document()->isModified());
}
