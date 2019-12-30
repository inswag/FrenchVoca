# FrenchVoca Project


## Inswag's first iOS App 'FrenchVoca'


## [App Store Link](https://apps.apple.com/kr/app/frenchvoca/id1484363534?l=en)


### Summary
- This app is for learning french words. (KR-FR)
- Can find your schedule of exam(FLEX, DELF) very easily.
- Can hear the pronounciation of words and examples (+ control the rate of voice)
- Can receive your notification of the daily words (+ control your time)


### Skills
- Based : Swift 5.0
- Library : FMDB(MIT Licensed)
- Database : MySQL
- UserNotification, AVSynthesizer, WKWebview
- Design : Sketch & Jeplin


### Screen Shots
![inscription](https://user-images.githubusercontent.com/39002173/56110425-5dca1e80-5f8f-11e9-8d5b-aa791b56775f.gif)
![accueil](https://user-images.githubusercontent.com/39002173/56110426-5dca1e80-5f8f-11e9-917e-cf22d34a85f1.gif)

![vocabulaire](https://user-images.githubusercontent.com/39002173/56110423-5d318800-5f8f-11e9-9358-ed76e78e4653.gif)
![paramètre](https://user-images.githubusercontent.com/39002173/56110424-5d318800-5f8f-11e9-977c-5707e9332766.gif)


### Thanks to
- Yeong Eun Lee (Participate in Design, Database)
- Seung Jin Kim (iOS Developer)
- Tae hyeong Um (iOS Developer)
- Young Min Cho (Back-end Developer)
- Jeong Woo Cho (Designer)


### Design Parttern

#### MVC + Coordinator

##### 개요

- MVC 디자인 패턴은 유용하지만 확장성 면에서 떨어진다. 프로젝트의 규모와 복잡성이 증가하면서 확장성 또한 비례하여 떨어진다. 이러한 문제를 해결하기 위해 Coordinator 라는 것을 사용하고자 한다.

##### What's problem ?

- A 에서 B 로 Segue 를 통해서 연결이 되어있고, 또 B 에서 A 로 Segue 를 통해 연결이 되어있다고 치자, 사실 겉으로는 큰 문제가 없어 보이지만 Segue 는 이 두 View Controller 를 묶어두고(Binding) 있다. 이것은 View Controller 를 재사용(reuse) 하는데 있어 큰 어려움이 있다.

##### Coordinator

- Coordinator Pattern 의 핵심 아이디어는 Coordinator 라는 개별 엔티티(seperate entity) 를 생성하는 것이다. Coordinator 는 어플리케이션의 흐름(Flow) 를 책임진다. Coordinator 는 앱의 일부를 캡슐화(encapsulate)한다.  Coordinator 는 자신의 부모 Coordinator 에 대해 아무것도 알지 못하지만 그럼에도 자식 Coordinator 를 시작할 수 있다.

- 즉, Coordinator 는 UIViewController 들을 create, present, dismiss 한다. 동시에 UIViewController 들은 분리되고 독립된 상태를 유지한다. UIViewController 가 UIView 를 관리하는 것과 유사하게 Coordinator 들은 UIViewController 들을 관리한다.


### MVVM (will apply to this project 1.1.0 ver)

#### Introduction

##### MVVM(Model - View - ViewModel) 패턴은 구조적 디자인 패턴으로 객체를 다음과 같이 3개의 분리된 객체로 구분한다.

- Model 은 앱의 Data 를 가지고(hold) 있다. 보통 구조체나 클래스로 구현되어 있다.

- View 는 스크린 상에 시각적 요소나 컨트롤들(버튼, 스위치 등)을 표시한다. 일반적으로 UIView 의 서브클래스들.

- View Model 은 model 이 가진 정보(information)를 뷰 상에 표시될 수 있는 값(value)로 바꾼다. 보통 클래스로 정의되어 있어 뷰 모델은 참조로서 전달 될 수 있다. 

##### MVC 와 유사하기는 하나, MVVM 에서는 VC의 역할이 최소화된다는 것이 포인트다.

#### Why  ?

##### MVC 에서는 VC가 Model 에서 View 로의 변환하는 코드를 모두 담당한다.  뷰의 라이프사이클 이벤트도 담당해야 하고... 뷰의 콜백도 담당해야 하고... 너무나 거대해진다(Massive). MVVM 패턴이 이를 해결하기에는 꽤 적합한 솔루션이다.


