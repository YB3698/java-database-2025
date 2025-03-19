## PyQt5 첫 윈도우앱 개발
import sys
from PyQt5.QtWidgets import *
from PyQt5.QtGui import *

# PyQt의 모든 컨트롤은 Wiget(위젯)이라고 부름.
class YubinWindow(QMainWindow): 
    def __init__(self):          
        super().__init__()
        self.initUI() # 화면 디자인은 분리리      

    def initUI(self): # 화면 디자인
        self.setWindowTitle('My First App')
        self.setWindowIcon(QIcon('./image/duck.png')) # 윈도우 아이콘 지정
        self.resize(600,350)

        # 라벨(레이블) 추가
        self.lbl1 = QLabel('버튼클릭', self)
        self.lbl1.move(10,10) # 위젯 위치 조정
        self.lbl1.resize(250,30) # 레이블 사이즈 조정
        # 버튼 추가
        self.btn1 = QPushButton('Click',self)
        self.btn1.move(10,40)
        self.btn1.clicked.connect(self.btn1click) # 버튼 클릭 시그널(이벤트)함수 연결

        # 윈도우 바탕화면 정중앙에 위치
        qr = self.frameGeometry()
        cp = QDesktopWidget().availableGeometry().center()
        qr.moveCenter(cp)
        self.move(qr.topLeft())

        self.show()
    def btn1click(self):
        # self.lbl1.setText('버튼을 클릭했네요!')
        QMessageBox.show('버튼을 클릭했습니다.')
        
if __name__ == '__main__':  # 메인 모듈이라면
    app = QApplication(sys.argv)     
    win = YubinWindow()               
    app.exec_()       