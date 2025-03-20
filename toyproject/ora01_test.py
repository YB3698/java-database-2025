# Oracle 콘솔 연동 예제
# pip install cx_Oracle (모듈 설치함)
import cx_Oracle as oci

# DB연결 설정변수 선언
sid = 'XE'
host = '127.0.0.1' # localhost와 동일한 의미. 
# DB 서버가 외부에 있다면 oracle.pkunqrd.net(호스트가 포함된 도메인 주소) 또는 211.12.11.45(ip 주소)로 입력 필요
port = 1521
username = 'madang' # madang dbeaver에서 만듦
password = 'madang'

# DB 연결 시작
conn = oci.connect(f'{username}/{password}@{host}:{port}/{sid}')
cursor = conn.cursor() # DB 커서와 동일한 역할을 하는 개체

query = 'SELECT * FROM Students' # 파이썬에서 쿼리호출할 때 ; 삭제하고 넣기(넣으면 오류남)
cursor.execute(query)

# 불러온 데이터 처리
for i, (std_id, std_name, std_mobile, std_regyear) in enumerate(cursor, start=1):
    print(std_id, std_name, std_mobile, std_regyear)

cursor.close()
conn.close()
# DB는 연결하면 마지막에 close() 해주기, 파일은 오픈하면 마지막에 닫아줘야 됨
