## PyQt5 첫 윈도우앱 개발
import sys
from PyQt5.QtWidgets import *
from PyQt5.QtGui import *

class YubinWindow(QMainWindow): 
    def __init__(self):          
        super().__init__()
        self.initUI()    

    def initUI(self):
        # QtDesigner 생성 ui파일 로드
        uic.loadUi('./toyproject/sampleqt.ui', self) 
        uic.loadUi("./")
        self.setWindowIcon(QIcon('./image/duck.png')) # 윈도우 아이콘 지정
        # ui에 있는 위젯 접근하려면 이름 그대로 사용
        self.lbl1.setText('UI를 로드했습니다!')
        self.btn1.clicked.connect(self.btn1click)
        self.btn2.clicked.connect(self.btn2click)

        self.show()

    def btn1click(self):
        QMessageBox.about(self, '알림','버튼을 클릭했습니다!')
    
    def btn1click(self):
        ans = QMessageBox.question(self, '종료','종료하시겠습니까?', QMessageBox.Yes | QMessageBox.No, QMessageBox.No)
        if ans == QMessageBox.Yes:
            e.accept()
        else:
            e.ignore()
        
if __name__ == '__main__':  # 메인 모듈이라면
    app = QApplication(sys.argv)     
    win = YubinWindow()               
    app.exec_()   