#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QWidget>
#include <QMenu>
#include <QMenuBar>
#include <QPlainTextEdit>
#include <QAction>
#include <QMainWindow>
#include <QFileDialog>
#include <QStatusBar>
#include <QMessageBox>
#include <QTextStream>
class mainWindow : public QMainWindow
{
    Q_OBJECT

public:
     mainWindow();
    ~mainWindow();
    void readFile(const QString &fileName);
private slots:
    void open();
    void fileModified();
    bool saveAs();


private:
    QPlainTextEdit *textEdit;
    QString currentFileName;
    QMenuBar *menuBar;
    QMenu *fileMenu;
    QAction *openFile;
    QAction *saveFile;
    QAction *saveAsFile;
    QAction *Exit;
    bool SaveChanges();
    void SetInUseFile(const QString &fileName);
    void SaveFile(const QString &fileName);

};

#endif // MAINWINDOW_H
