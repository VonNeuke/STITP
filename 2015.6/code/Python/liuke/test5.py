#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys
from PyQt4 import QtGui
from PyQt4 import QtCore


class OpenFileExample(QtGui.QMainWindow):

    def __init__(self):
        super(OpenFileExample, self).__init__()

        self.initUI()

    def initUI(self):

        self.textEdit = QtGui.QTextEdit()
        self.setCentralWidget(self.textEdit)
        self.statusBar()
        self.setFocus()

        openFile = QtGui.QAction(QtGui.QIcon('icons/open.png'), 'Open', self)
        openFile.setShortcut('Ctrl+O')
        openFile.setStatusTip('Open new File')
        self.connect(openFile, QtCore.SIGNAL('triggered()'), self.showDialog)

        menubar = self.menuBar()
        fileMenu = menubar.addMenu('&File')
        fileMenu.addAction(openFile)

        self.setGeometry(300, 300, 350, 300)
        self.setWindowTitle('OpenFile')

    def showDialog(self):

        filename = QtGui.QFileDialog.getOpenFileName(self, 'Open file',
                                                     '/home')
        # 第一个字符串是标题，第二个字符串指定对话框的工作目录，在windows下用/home也是可以的
        fname = open(filename)
        # 不能直接打开路径中包含中文的文件，会报错
        data = fname.read()
        # 读取文件
        self.textEdit.setText(data)
        # 显示在文本域中

app = QtGui.QApplication(sys.argv)
ex = OpenFileExample()
ex.show()
app.exec_()