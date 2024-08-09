# Gwasuwon iOS

**[Project Description]**  
Class management services used by tutors  

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

### Clean Architecture + TCA

`TCA(The Composable Architecture)`  

![tca-architecture](/gwasuwon/tca_architecture.png)  

- `View`
- `Action`
- `Reducer`
- `State`
- `Effect`
- `Dependency`

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

---  

### App Images  



---  

### Resources  

- [tca image](https://blog.naver.com/naverfinancial/223160757757)  