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
