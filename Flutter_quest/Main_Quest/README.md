# 팝퀴즈앱        

## 앱 정보

- **앱 이름** 

  - 내팝퀴즈    

- **시장(마켓)**  

  - 초중고등학교 출제 시장

- **타겟**  

  - 초중고등학교 교원 약 44만명



## 앱 구조도(사용 툴: https://app.diagrams.net/)
![팝퀴즈앱_구조도 drawio](https://github.com/bluetss/AIFFEL_quest/assets/13924283/5a3cc01f-4874-4fed-aaac-8b79df9d1cd2)




## 앱 와이어프레임 (사용 툴 : 갤럭시노트)
![앱와이어프레임](https://github.com/bluetss/AIFFEL_quest/assets/13924283/620c06cd-9a74-4931-a2d4-53d3001fbb40)



## 프로토타이핑 (사용 툴 : 피그마)
![프로토타이핑](https://github.com/bluetss/AIFFEL_quest/assets/13924283/f96b60e3-4d5a-49dc-bd77-3f5f375deefe)




## 페이지 구현
1. main.dart - 메인 화면으로 하단 메뉴바로 구성됨. initial은 quiz_screen.dart로 설정
2. quiz_screen.dart - 쪽지 시험 출제 메뉴
3. board_screen.dart - 커뮤니티(게시판) 메뉴
4. my_screen.dart - 내 출제 목록 저장 메뉴
5. setting_screen.dart - 출제 등 설정 메뉴
6. image_provider.dart - 이미지 저장을 위한 dart 파일
7. onboarding_screen.dart - 온보딩 스크린



## 구현영상: 프로토타이핑
https://github.com/bluetss/AIFFEL_quest/assets/13924283/152dd5ad-530a-457d-af90-5994f9ec2d4e



## 구현영상: 가상 에뮬레이터
https://github.com/user-attachments/assets/c831edff-9985-4076-b54a-4c6f5b12aaee



## 참고 학습 자료 


## 회고
1. 어려웠던 점
    - 사진 촬영후 widget list로 화면의 위젯을 복귀시킨후 다른 위젯 화면으로 바로 가게 만드는 것
    - 이미지를 로컬에 파일로 저장하는 것
    - api로 저장된 파일을 업로드하고 이를 서버에서 인공지능으로 처리하는 것
    - OCR 모델이 구동될 수 있도록 서버를 구축하는 것
2. 새로운 시도
    - 그리뷰의 표시 순서를 최신 순으로 바꾸는 것
