# Gwasuwon iOS

**[Project Description]**  
과수원 : 과외 수업을 원하는 학생들  
과외 선생님과 학생을 매칭 및 모니터링 서비스 제공 앱.  

---  

### Development Environment

Minimum Deployments: iOS `16.0`  
Xcode Version: `15.0.1`  
Tuist Version: `4.12.1`  
mise Version: `2024.3.9 macos-x64`  
git Version: `2.39.3 (Apple Git-145)`  

---  

### External Dependency  

- [TCA 1.8.0 >=](https://github.com/pointfreeco/swift-composable-architecture)  
- [TCACoordinators 0.8.0](https://github.com/johnpatrickmorgan/TCACoordinators)  
- [FlowStacks 0.4.0](https://github.com/johnpatrickmorgan/FlowStacks)  
- [Swinject 2.9.1](https://github.com/Swinject/Swinject)  
- [kakao-ios-sdk 2.20.0 >=](https://github.com/kakao/kakao-ios-sdk)  

---  

### Skill Stack

Skill: TCA + Tuist + SwiftUI  
Architecture: Clean Architecture + Modular Architecture  

`기술 스택 선정 이유`  

1. `단방향 패턴`  

TCA를 사용한 것은 MVVM 패턴보단 `단방향 패턴`인 MVI를 사용하고 싶었고, TCA가 MVI와 유사했기 때문에 사용함.  
TCA는 action 하나 하나를 다 컨트롤할 수 있어 side effect까지 다 핸들링할 수 있는 장점이 있었음.  

2. `SwiftUI + MVI`  

SwiftUI는 `@State`, `@StateObject` 등 View에서 상태 관리 및 데이터 바인딩으로 View를 새로 그려주는 작업이 쉬워졌다.  
View에서 자체적으로 데이터 바인딩을 수행해주는 녀석들이 있어 View가 참조할 State 데이터 관리가 되므로 MVVM의 ViewModel 패턴이 필요없게 된다. (물론 business logic 분리는 view로부터 분리하긴 해야함)  
따라서, MVVM보단 MVI 패턴과 유사한 TCA가 적합하다 생각했다.  

3. `Tuist`  

많은 사람들과 협업할 때, Tuist로 프로젝트 관리를 하면 되게 큰 이점이 됨을 회사에서 느꼈다.  
또한, 모듈화를 하기 위해서도 Tuist를 사용하여 관리하면 매우 편하다는 것을 알게 되어, Tuist를 더 공부해보고자 사용함.  

4. `Trendy`  

최신 기술들을 왕창 써보며 최신 트렌드를 따라가보고 싶었음.  

5. `AtoZ 개발`  

구조 설계부터 앱 개발까지 협업 + 개발을 프로젝트 처음부터 끝까지 전담해보고 싶었음.  

---  

### TCA

`TCA(The Composable Architecture)`  

![tca-architecture](/gwasuwon/tca_architecture.png)  

- `View`
    - UI 처리 담당.
    - ViewStore의 State가 변경됨을 감지하고 UI 업데이트에 관여.  
- `Action`
    - 하나의 액션에 대한 정의.
    - MVI Pattern의 Intent와 같음.
    - TCA에서 Action은 하나의 action에 대해 하나의 행동을 정의해줌.
- `Reducer`
    - Action을 전달받고 해당 action에 대한 일을 수행함.
    - 주로 State변경이 일어나고, UI 업데이트를 위한 로직이 여기서 수행됨.
    - API 요청과 같은 action들 또한 이 곳에서 처리.
- `State`
    - 상태를 나타냄. 보통 UI를 그릴 때 관련된 데이터 혹은 UI에서 감지해야 할 변수들로 초기화.
- `Effect`
    - Reducer의 return값.
    - 어떠한 action을 수행했을 때의 기대하는 효과.
    - Side Effect도 여기 포함될 수 있다고 생각
        - TCA에서는 모든 Side Effect역시 다 Action으로 정의하여 핸들링을 할 수 있음.
- `Dependency`
    - 외부 시스템과 상호 작용하는 유형과 기능.

---  

### Clean Architecture

`Clean Architecture + TCA`  

![clean-architecture](/gwasuwon/clean-architecture.png)  

- `책임 분리`  
각 layer들의 책임을 분리하고 유지보수를 용이하게 가져가기 위해 도입.  
각 layer는 각 layer의 행동에만 집중. 나머지는 몰라도 됨.  
- `확장성 증가`  
프로토콜을 나누며 새로운 기능이나 요구사항이 추가될 때, 기존 코드를 최소한으로 수정하며 쉽게 확장할 수 있게 함.  
- `의존성 관리`  
DI(Dependnency Injection)으로 모듈 간 의존성 관리 용이  
- `장기적인 코드 퀄리티`  
코드 규모가 커져도 대응이 쉽게 됨.  

---  

### Modularization With Tuist

`Tuist Graph`  

![Tuist Graph](/gwasuwon/graph.png)  

- `App Module`
    - DI Register
    - AppDelegate, SceneDelegate 위치
    - App 전반적인, 실행부분에서 초기화해줄 부분들 위치
    - RootFeature init
- `Features`
    - Clean Architecture의 Presentation Layer + TCA가 혼합된 각각의 기능 단위의 모듈이 존재
    - 각종 View + Feature(Reducer)
    - 하나의 기능, 기능을 하는 화면 단위로 구성
- `Domain Module`
    - Clean Architecture의 Domain Layer를 위한 모듈
    - UseCase와 Repository Protocol 위치
    - View에서 사용될 Model이 존재
    - Manager 위치 (유저 정보와 같이 싱글톤으로 가져갈 모델)
- `Data Module`
    - Clean Architecture의 Data Layer
    - Domain Layer에서 선언한 프로토콜의 구현부(의존성 역전)
    - API Service 위치
    - 순수 API의 응답 Request, Response Model 위치
    - Data Model -> Domain Model로 변환해주는 Mapper 위치
        - Data Layer만이 import Domain을 할 수 있기 때문에 이 곳에 변환해주는 맵퍼 위치
    - Local Storage Service 위치
- `DI Module`
    - 의존성 역전을 위해 Swinject를 사용해서 resolve, DI Container init을 담당해주는 코드 위치
- `DesignSystem Module`
    - 각종 디자인과 관련된 파일, 소스들이 모여져있는 모듈
    - 해당 모듈에서는 비즈니스 로직은 관심 없고, 딱 디자인만 정의
- `Utils`
    - 본 프로젝트에서 유틸성 파일들이 정의되어 있는 곳
    - `Util Module`
        - DateFormat이나, Int Extension과 같은 것들이 정의되어 있음.
    - `QRScanner Module`
        - QRScan만을 사용하기 위한 모듈.
        - QR 기능을 사용하는 Feature에서만 본 모듈을 import해서 사용

`이점`  

- `빌드 시간 단축`  
모듈화를 해놓으면 코드 수정이 일어났을 경우, 변경된 모듈만 다시 빌드하면 되므로 빌드 시간이 단축됨.  
- `코드 재사용성 증가`  
QR Scanner와 같이 기능 단위로 모듈을 분리하면 공통 기능을 다양한 프로젝트에서 재사용 가능.  
- `유지보수 용이`  
각 모듈에 대해 독립적 개발 가능  
모듈 경계를 명확히 나누었기 때문에, 코드 리뷰나 테스트, 수정 등이 쉬워지고 책임이 구분됨.  
- `테스트 용이`
각 모듈을 독립적으로 테스트할 수 있어 테스트에 용이.  
- `각 모듈간의 의존성 관리`
각 모듈간 의존성을 가시적으로 명확히 관리할 수 있음.  

---  

### App Images  

|**`로그인 메인`**|**`선생님 홈`**|**`학생 홈`**|**`수업 추가하기`**|**`수업 추가하기`**|
|:-------------:|:-------------:|:-------------:|:-------------:|:-------------:|
|<img src="https://github.com/prography-team8/gwasuwon-ios/blob/master/gwasuwon/images/login-main.jpeg?raw=true" width="143" height="300">|<img src="https://github.com/prography-team8/gwasuwon-ios/blob/master/gwasuwon/images/teacher-home.jpeg?raw=true" width="143" height="300">|<img src="https://github.com/prography-team8/gwasuwon-ios/blob/master/gwasuwon/images/student-home.jpeg?raw=true" width="143" height="300">| <img src="https://github.com/prography-team8/gwasuwon-ios/blob/master/gwasuwon/images/class-add1.jpeg?raw=true" width="143" height="300">|<img src = "https://github.com/prography-team8/gwasuwon-ios/blob/master/gwasuwon/images/class-add2.jpeg?raw=true" width="143" height="300" >|
|**`수업 생성 완료`**|**`수업 목록`**|**`수업 정보 보기`**|**`수업 정보 수정`**|**`수업 정보 삭제`**|  
|<img src="https://github.com/prography-team8/gwasuwon-ios/blob/master/gwasuwon/images/class-create-done.jpeg?raw=true" width="143" height="300">|<img src="https://github.com/prography-team8/gwasuwon-ios/blob/master/gwasuwon/images/class-list.jpeg?raw=true" width="143" height="300">|<img src="https://github.com/prography-team8/gwasuwon-ios/blob/master/gwasuwon/images/class-detail.jpeg?raw=true" width="143" height="300">| <img src="https://github.com/prography-team8/gwasuwon-ios/blob/master/gwasuwon/images/class-edit.jpeg?raw=true" width="143" height="300">|<img src = "https://github.com/prography-team8/gwasuwon-ios/blob/master/gwasuwon/images/class-delete.jpeg?raw=true" width="143" height="300" >|
|**`수업 초대 QR`**|**`학생 방 입장(QR)`**|**`학생 출석체크(QR)`**|**`수업 인증 생성(QR)`**|**`선생님 전체 Flow`**|
|<img src="https://github.com/prography-team8/gwasuwon-ios/blob/master/gwasuwon/images/student-invitation-qr.jpeg?raw=true" width="143" height="300">|<img src="https://github.com/prography-team8/gwasuwon-ios/blob/master/gwasuwon/images/student-enter-class.gif?raw=true" width="143" height="300">|<img src="https://github.com/prography-team8/gwasuwon-ios/blob/master/gwasuwon/images/student-class-attendance.gif?raw=true" width="143" height="300">|<img src="https://github.com/prography-team8/gwasuwon-ios/blob/master/gwasuwon/images/teacher-qr-generator.gif?raw=true" width="143" height="300">|<img src="https://github.com/prography-team8/gwasuwon-ios/blob/master/gwasuwon/images/teacher-all-flow.gif?raw=true" width="143" height="300">|

---  

### Resources  

- [tca image](https://blog.naver.com/naverfinancial/223160757757)  