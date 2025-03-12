# 공부다방 - 스터디 카페 예약 앱

# 프로젝트 소개
공부다방은 스터디 카페 예약을 위한 모바일 애플리케이션입니다.

사용자는 스터디 카페 예약, 예약 확인, 결제 등의 기능을 편리하게 이용할 수 있으며, 

Firebase Firestore와 연동하여 회원 관리 및 예약 내역 등 데이터 저장을 지원합니다.

# 주요 기능
- 회원 관리
  - 로그인 / 로그아웃
  - 회원가입
  - 회원 탈퇴
  - 비밀번호 변경
  - 프로필 이미지 등록 및 저장

- 스터디 카페 예약 기능
  - 좌석 및 날짜 선택 후 예약 가능 
  - 예약 내역 조회 및 관리

- 결제 기능
  - 토스(Toss) 결제 시스템 연동
  - 예약 시 결제 진행 가능
  - 데이터 저장
  - Firebase Firestore 연동
  - 예약 데이터 및 사용자 정보 저장

- 관리자 웹 페이지
  - 관리자 로그인 및 로그아웃 기능 (Firebase Firestore 규칙 수정하여 특정 유저만 관리자 권한부여)
  - 예약 및 결제정보 Firebase Firestore 연동으로 실시간 정보 연동 기능

# 사용한 기술 스택

# 스크린샷
## Splash & AppIcon

| Splash | AppIcon |
| - | - |
| <div align="center"><img src="https://github.com/user-attachments/assets/bcff77d4-84d5-41b6-97d4-2fba59459033" width="320" height="500"/></div> | <div align="center"><img src= "https://github.com/user-attachments/assets/f4a59a2b-5d51-4843-9255-23953599b59d" width="350" height="350"/></div> |
| <div align="center">앱 실행시 화면</div> | <div align="center">앱 아이콘</div> |

## Login
| - | - |
| - | - |
| <div align="center"><img src="https://github.com/user-attachments/assets/188450ff-bf87-4676-99cf-1e5f9d45a24f" width="320" height="500"/></div> | <div align="center"><img src= "https://github.com/user-attachments/assets/aba1f040-5f8e-41a6-8e23-1e24e8dfa618" width="320" height="500"/></div> |
| <div align="center">회원가입</div> | <div align="center">로그인</div> |

## 홈
| - | - |
| - | - |
| <div align="center"><img src="https://github.com/user-attachments/assets/e5b868fe-4ac0-46df-8cf9-aaf317363817" width="320" height="500"/></div> | <div align="center"><img src= "https://github.com/user-attachments/assets/4e607f52-7b57-47c9-8ae5-5e8ee82365ef" width="320" height="500"/></div> |
| <div align="center">홈 1</div> | <div align="center">홈 2</div> |

## 예약
| - | - | - | - |
| - | - | - | - |
| <div align="center"><img src="https://github.com/user-attachments/assets/eb86bb20-bafb-47cb-bbc9-5396de496b4c" width="800" height="400"/></div> | <div align="center"><img src= "https://github.com/user-attachments/assets/7bd4782b-984b-470c-8000-35e20ae3452c" width="800" height="400"/></div> | <div align="center"><img src= "https://github.com/user-attachments/assets/c2fda935-ef0e-4c06-b1d3-a6e716141ec8" width="800" height="400"/></div> | <div align="center"><img src= "https://github.com/user-attachments/assets/fcdc9ac1-c6cb-4187-afd6-24852c5c7d15" width="800" height="400"/></div> |
| <div align="center">좌석선택 1</div> | <div align="center">좌석선택 2</div> | <div align="center">날짜 선택</div> | <div align="center">상품 선택</div> |

## 결제
| - | - | - | - | - |
| - | - | - | - | - |
| <div align="center"><img src="https://github.com/user-attachments/assets/704a9c90-6e79-4e6c-8459-10fd654a0890" width="800" height="400"/></div> | <div align="center"><img src= "https://github.com/user-attachments/assets/8aadca16-36f6-4fad-b182-3fccce8a361b" width="800" height="400"/></div> | <div align="center"><img src= "https://github.com/user-attachments/assets/a71cc304-9037-4831-b6e1-cf5ff59ebd89" width="800" height="400"/></div> | <div align="center"><img src= "https://github.com/user-attachments/assets/f3dbd49a-fc22-4728-bfcf-99b3901f9143" width="800" height="400"/></div> | <div align="center"><img src= "https://github.com/user-attachments/assets/ff147bef-ff6b-41d8-b904-fba7608b013e" width="800" height="400"/></div> |
| <div align="center">결제 1</div> | <div align="center">결제 2</div> | <div align="center">결제 3</div> | <div align="center">결제 완료</div> | <div align="center">결제 실패</div> |

## 내정보
| - | - | - | - | - |
| - | - | - | - | - |
| <div align="center"><img src="https://github.com/user-attachments/assets/15f9f5fc-bd4e-4611-8908-9b8ea9172f83" width="800" height="400"/></div> | <div align="center"><img src= "https://github.com/user-attachments/assets/b5e10586-4f67-4fb4-82ae-1ecaccfe47d4" width="800" height="400"/></div> | <div align="center"><img src= "https://github.com/user-attachments/assets/d30de69d-4f22-44f1-aaaf-c7e195291d7a" width="800" height="400"/></div> | <div align="center"><img src= "https://github.com/user-attachments/assets/e770eaa5-3368-41ed-bd21-3e8819fe5776" width="800" height="400"/></div> | <div align="center"><img src= "https://github.com/user-attachments/assets/ee5705ba-8dfb-428b-b429-1452184f3922" width="800" height="400"/></div> |
| <div align="center">내 정보</div> | <div align="center">예약 내역</div> | <div align="center">계정 관리</div> | <div align="center">비밀번호 변경</div> | <div align="center">회원 탈퇴</div> |

# 역할 및 회고
- 김덕원(팀장)
  - 역할
    - App 로고 및 아이콘 생성, FirebaseAuth를 연동하여 로그인 및 회원가입 기능구현, 예약 및 결제정보 FirebaseFirestore 저장구현, 관리자 전용 웹페이지 구현
  - 회고
    - 정말 좋은 팀원들을 만나서 도움도 많이 받고 실력이 많이 업그레이드가 된 프로젝트였습니다. 평소에 해보고 싶던 결제관련 앱 구현도 해보고 기존에 작게나마 가지고 있던 웹 개발 지식으로 관리자 전용 웹페이지 구현도 해보고 정말 즐거웠던 프로젝트였습니다. 프로젝트 기간동안 하루도 빠짐없이 밤늦게 까지 같이 회의하고 개발하고 다들 지치고 힘들텐데 힘들다는 말 한마디, 소통문제 없이 끝까지 같이 프로젝트 진행해준 팀원들 최고입니다! 다음에 기회가 된다면 또 같이 해보고 싶습니다.
      
- 김건
  - 역할
    - 메인 뷰 기능 구현.
    - 예약 기능 구현.
    - 디자인 보조.
  - 회고
    - 이번 프로젝트를 통하여 목표로 했던 것은 세가지입니다. 
      1.팀원들과의 커뮤니케이션. 2.flutter UI View 익숙해지기. 3.기능 한두개라도 구현해서 적용해보기. 위 목표로 프로젝트에 임하였으며, 첫번째 a 목표는 정말 대성공이었습니다. 자신있게 저의 팀이 분위기가 가장 좋았으며, 열정적이었다고 말할 수 있습니다. 서로 피드백을 주고받으며 수정하고, 받아들이고 의견을 어필하며 매일매일을 새벽 늦게까지 함께 작업하였습니다.

      두번째 b 목표도 실력있고 정말 좋은 팀원들 덕분에 이전과는 다르게 머리에 생각한 구상의 초안은 그릴 수 있으며, 좀 더 다듬는 다면 정말 원했던 UI를 구상할 수 있을 거라는 자신감이 생겼습니다. 저의 UI 실력 증진의 바램을 팀원분들이 잘 받아주셔서 메인 뷰와 좌석 예약 뷰를 맡게 되었으며, 아직은 많이 부족한 부분이 많지만 이전과는 비교도 할 수 없이 성장한 것을 느낍니다.

      세번째 c 목표도 이번 프로젝트에서는 Firebase를 사용하여 구상하였으며 직접적으로 Firebase 작업에는 참여하지 않았지만, 만들어준 모델과 예시들로 인하여 데이터를 가져와 메인뷰에 적용하게 하였습니다. 또한, 일부는 반응형 레이아웃을 사용하여 안드로이드와 IOS 기기에서 동일한 위치를 가질 수 있게 하였습니다.
    - 부족했던 점
      - Firebase를 제대로 사용못하는 점과 모델 및 Firebase 데이터를 사용하는 법,  MVC, MVVM 패턴 적용 부분에 있어서 많은 아쉬움이 있으며, 더 많은 공부와 연습이 필요 할 것 같습니다. 좌석 부분에 있어서는 시간 상 초안부분에서 크게 벗어나지 않게 하기 위하여 적용을 하지 못하였으나, 추후 수정하며 초기 기획 단계의 중요성을 다시 한번 깨달았습니다.
        
- 김태건
  - 역할
    - 내 정보 스크린 기능 구현.
    - 예약 내역 확인 기능 구현.
    - 비밀번호 변경 기능 구현.
    - 회원 탈퇴 기능 구현.
    - Forebase Firestore와 연동하여 프로필 이미지 변경 및 저장 기능 구현.
  - 회고
    - 프로젝트 기간동안 크고 작은 어려움들이 있었지만 의지와 열정이 넘치는 팀원들과 소통하고 개발하며 협업의 의미를 다시 한 번 깨닫게 해준 좋은 경험이었습니다. 팀원 분들 다들 고생하셨습니다.
      
- 이영학
  - 역할
    - 최종 결제 페이지
    - 이용권 예약 페이지
    - 스플래시 스크린
    - UI 레이아웃 및 디자인 보조
  - 회고
    - 이번 프로젝트는 의지와 열정이 넘치는 팀원들과 함께한 행복한 경험이었습니다.
      팀원 모두가 서로를 도우며 부족한 부분을 함께 고민하고 해결해 나가는 과정은 매우 의미 있는 시간이었습니다. 누군가 오류를 마주했을 때도 주저하지 않고 달려와 함께 머리를 맞대고 문제를 풀어나갔으며, 심지어 사소해 보일 수 있는 부분조차 먼저 제안하며 논의하는 분위기 덕분에 원활한 소통이 가능했습니다.
      이 과정을 통해 서로의 부족한 점을 채워주고, 열린 대화를 나누며 많은 것을 배울 수 있었습니다.  또한 로그인 기능의 구현 방식, 결제 시스템의 적용 방법, 그리고 Flutter에서 위젯을 그리는 기술에 대해서도 익숙해질 수 있었던 점이 큰 수확이었습니다.
      이번 프로젝트는 많은 것을 배울 수 있던 소중한 시간으로 기억될 것입니다.
