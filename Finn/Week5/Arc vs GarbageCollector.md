1. ARC(Automatic Reference Counting)
- 객체가 몇 번 참조되고 있는지를 카운트세서 계속 추적해준다. 
- 참조 카운트가 0이 되면 바로 메모리에서 날려버림 
- 즉각적으로 동작: 필요 없어지면 바로바로 치워줌
- 개발자가 강한 참조 사이클(서로가 서로를 계속 붙잡고 있는 상황)만 조심하면 됨

예시
1. 가비지 컬렉터  
- 얘도 큰 의미에서는 같다. 메모리 관리해주는 시스템 ? 정도? 
- Java, C#, JavaScript, Python 등 다른 언어에서 많이 사용  (JS는 정확히 JS는 아니고 이걸 돌리는 브라우저에 js엔진(v8같은거)이 있어서 거기서해줌)
- 주기적으로 프로그램 전체를 훑으면서 더 이상 접근할 수 없는 객체를 찾아서 한꺼번에 치움
- 즉각적이지 않음: 언제 치울지(수거할지)는 시스템이 결정 -> 그래서 이게 결국 해제되어도 아직 남아있을 수 있음...
- stop-the-world라 해서 GC돌아갈때 잠간 프로그램 멈출 수 있음  (GC 관련 쓰레드 빼고 다 멈추기 때문 ) - windowExploror는 이 친구가 너무 자주돌아가서 악명이 높았다고 한다...!



### 그럼 GC는  <더이상접근할 수 없는 객체>를  어떻게 판단하지?? 
- 루트객체에서 출발해 도달할 수 없는 객체

#### 루트 객체는 뭔데 ???
- 프로그램이 실행될 때 항상 접근 가능한 객체
- 예를 들면, 전역 변수, 스택에 있는 지역 변수, 실행 중인 스레드

그래서 이 루트에서 출발해서 어디까지 도달할 수 있는지 참조 그래프를 그려보고 아무도 못만나면 컷!!!

#### 이걸 정리하면 Mark and Sweep이라고한다!!
가비지 컬렉션이 될 대상 객체를 식별(Mark)하고 제거(Sweep)하며 객체가 제거되어 파편화된 메모리 영역을 앞에서부터 채워나가는 작업(Compaction)을 수행하게 된다.

![[Pasted image 20250622145230.png]]

>**Mark 과정**
>	먼저 Root Space로부터 그래프 순회를 통해 연결된 객체들을 찾아내어 각각 어떤 객체를 참조하고 있는지 찾아서 마킹한다.
>	
>**Sweep 과정**
>	참조하고 있지 않은 객체 즉 Unreachable 객체들을 Heap에서 제거한다.
>	
>**Compact 과정**
>	Sweep 후에 분산된 객체들을 Heap의 시작 주소로 모아 메모리가 할당된 부분과 그렇지 않은 부분으로 압축한다. (가비지 컬렉터 종류에 따라 하지 않는 경우도 있음)

![[Kapture 2025-06-22 at 14.52.58.gif]]


- 가비지컬렉터 -> 날려주는거 비정기적이고 언제댈지 모름. 주도권이 프로그램에 있음 
- ARC -> 참조 0 될때마다 그냥 뻥뻥 날려버림 


 [https://inpa.tistory.com/entry/JAVA-☕-가비지-컬렉션GC-동작-원리-알고리즘-💯-총정리](https://inpa.tistory.com/entry/JAVA-%E2%98%95-%EA%B0%80%EB%B9%84%EC%A7%80-%EC%BB%AC%EB%A0%89%EC%85%98GC-%EB%8F%99%EC%9E%91-%EC%9B%90%EB%A6%AC-%EC%95%8C%EA%B3%A0%EB%A6%AC%EC%A6%98-%F0%9F%92%AF-%EC%B4%9D%EC%A0%95%EB%A6%AC) [Inpa Dev 👨‍💻:티스토리]
