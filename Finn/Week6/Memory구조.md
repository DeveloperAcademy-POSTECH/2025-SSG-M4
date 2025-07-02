

![[Pasted image 20250629221457.png]]

여기서 볼 수 있듯이 메모리구조는 다음과 같이 생겨있고, 이제 stack에는 값타입 친구들이 저장이 될 것이다. 그리고 아래로 늘어나는 구조인데, 여기서 이제 Stack이 너무 많아서 동적할당부분을 넘쳐서 자라나면, 그게 이제 stackoverflow라는것이다. 

스택은 컴파일 단계에서 할당되고 동적할당이 안됨 ! 
힙은 런타임에 동적으로 할당이 되는것임 필요하면 OS에 요청해서 더 할당받는거 
여기서 또 할당해주는 알고리즘에 대해서도 공부를 하실 수 가있습니다.. 
[메모리 할당 방식](https://wikidocs.net/232217#:~:text=%EC%9D%B4%EB%95%8C%2C%20%EC%96%B4%EB%96%A4%20%EA%B8%B0%EC%A4%80%EC%9C%BC%EB%A1%9C%20%EA%B3%B5%EA%B0%84%EC%9D%84%20%EC%84%A0%ED%83%9D%ED%95%A0%EC%A7%80%EC%97%90%20%EB%94%B0%EB%9D%BC%20%EB%8B%A4%EC%96%91%ED%95%9C,%22Worst%2DFit%22%2C%20%EA%B7%B8%EB%A6%AC%EA%B3%A0%20%22First%2DFit%22%EC%9D%B4%20%EA%B0%80%EC%9E%A5%20%EB%84%90%EB%A6%AC%20%EC%95%8C%EB%A0%A4%EC%A7%84%20%EC%A0%84%EB%9E%B5%EB%93%A4%EC%9E%85%EB%8B%88%EB%8B%A4.)


>[! 출처]
>[# RAM, ROM 그리고 메모리 구조](https://velog.io/@malrang-malrang/RAM-ROM-%EA%B7%B8%EB%A6%AC%EA%B3%A0-%EB%A9%94%EB%AA%A8%EB%A6%AC-%EA%B5%AC%EC%A1%B0)