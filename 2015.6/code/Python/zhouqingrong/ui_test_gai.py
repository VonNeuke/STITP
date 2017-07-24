# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'D:\test.ui'
#
# Created: Sun Jul 24 14:20:43 2016
#      by: PyQt4 UI code generator 4.10.4
#
# WARNING! All changes made in this file will be lost!
import sys
from PyQt4 import QtCore, QtGui

try:
    _fromUtf8 = QtCore.QString.fromUtf8
except AttributeError:
    def _fromUtf8(s):
        return s

try:
    _encoding = QtGui.QApplication.UnicodeUTF8
    def _translate(context, text, disambig):
        return QtGui.QApplication.translate(context, text, disambig, _encoding)
except AttributeError:
    def _translate(context, text, disambig):
        return QtGui.QApplication.translate(context, text, disambig)

class Ui_MainWindow(object):
    def setupUi(self, MainWindow):
        MainWindow.setObjectName(_fromUtf8("MainWindow"))
        MainWindow.resize(445, 432)
        self.centralwidget = QtGui.QWidget(MainWindow)
        self.centralwidget.setObjectName(_fromUtf8("centralwidget"))
        self.open_button = QtGui.QPushButton(self.centralwidget)
        self.open_button.setGeometry(QtCore.QRect(40, 300, 91, 31))
        self.open_button.setObjectName(_fromUtf8("open_button"))
        self.save_button = QtGui.QPushButton(self.centralwidget)
        self.save_button.setGeometry(QtCore.QRect(150, 300, 91, 31))
        self.save_button.setObjectName(_fromUtf8("save_button"))
        self.progressBar = QtGui.QProgressBar(self.centralwidget)
        self.progressBar.setGeometry(QtCore.QRect(290, 270, 118, 23))
        self.progressBar.setProperty("value", 0)
        self.progressBar.setObjectName(_fromUtf8("progressBar"))
        MainWindow.setCentralWidget(self.centralwidget)
        self.menubar = QtGui.QMenuBar(MainWindow)
        self.menubar.setGeometry(QtCore.QRect(0, 0, 445, 23))
        self.menubar.setObjectName(_fromUtf8("menubar"))
        MainWindow.setMenuBar(self.menubar)
        self.statusbar = QtGui.QStatusBar(MainWindow)
        self.statusbar.setObjectName(_fromUtf8("statusbar"))
        MainWindow.setStatusBar(self.statusbar)

        self.retranslateUi(MainWindow)
        #QtCore.QObject.connect(self.save_button, QtCore.SIGNAL(_fromUtf8("clicked()")), MainWindow.close)
        QtCore.QObject.connect(self.open_button, QtCore.SIGNAL(_fromUtf8("clicked()")), self.openfile)
        QtCore.QMetaObject.connectSlotsByName(MainWindow)

    def retranslateUi(self, MainWindow):
        MainWindow.setWindowTitle(_translate("MainWindow", "MainWindow", None))
        self.open_button.setText(_translate("MainWindow", "open picture", None))
        self.save_button.setText(_translate("MainWindow", "save picture", None))

    def  openfile(self):
        absolute_path=QFileDialog.getOpenFileName(self,'open file','.',"txt files(*.txt)")
        if absolute_path:
            cur_path=QDir('.')
            relative_path=cui_path.relativeFilePath(absolute_path)
            self.le.setText(relative_path)

            print relative_path

if __name__ == '__main__':
    app=QtGui.QApplication(sys.argv)
    mainWindow=QtGui.QMainWindow()
    ui=Ui_MainWindow()
    ui.setupUi(mainWindow)
    mainWindow.show()
    sys.exit(app.exec_())

