### 🔍 어떤 문제가 발생했나요?

## 현상
[Feat/#43 onboarding lottie] PR 이후 dev로부터 생성된 [[feat/#63-preview-image](https://github.com/DeveloperAcademy-POSTECH/2025-C3-M13-TeamGyeongjosa/tree/feat/%2363-preview-image)] branch가 xcode에서 열리지 않음. 에러 메시지에서 chukapoka.xcodeproj 충돌 문제로 나타남. dev branch는 xcode에서 열리는 것으로 보아 로컬 문제는 아니라고 판단.
    
    ```sql
    The project ‘chukapoka’ is damaged and cannot be opened due to a parse error. Examine the project file for invalid edits or unresolved source control conflicts.
    
    Path: /Users/jenki/Developer/2025-C3-M13-TeamGyeongjosa/chukapoka/chukapoka.xcodeproj
    ```
    


## 원인
    
 가장 최신 PR 이었던 [**[[Feat] customNavigation View 구현](https://github.com/DeveloperAcademy-POSTECH/2025-C3-M13-TeamGyeongjosa/pull/64)**] 에서 chukapoka.xcodeproj 에서  [[feat/#63-preview-image] branch가 포함하는 파일에 해당하는 부분이 삭제됨.

<img width="1217" alt="Image" src="https://github.com/user-attachments/assets/8c17c391-16f5-4058-9e7f-4c4407477e06" />

    
 dev branch 에서 파일을 열면 최신 수정부분은 반영되었지만, 상당수의 파일들이 없어진 것이 확인됨. github의 dev branch에서는 해당 파일들을 확인할 수 있지만 chukapoka.xcodeproj 에서 없어져서 xcode에서 인식을 못하는 것으로 추정. 
    
  
<img width="868" alt="Image" src="https://github.com/user-attachments/assets/c96a8db7-48b6-4dfc-955d-76fa8d1e5ce4" />

## 해결
    
 이전에 팀에서 해결했던 방식대로 이슈 생성하고, 직전 PR 이었던 [[Feat/#43 onboarding lottie](https://github.com/DeveloperAcademy-POSTECH/2025-C3-M13-TeamGyeongjosa/pull/62)](https://github.com/DeveloperAcademy-POSTECH/2025-C3-M13-TeamGyeongjosa/pull/62) 에서의  chukapoka.xcodeproj 로 수정하여 dev에 merge할 예정.
    
     [feat/#63-preview-image] branch 삭제하고, 최신 dev 기준으로 branch 다시 생성할 예정

-> 그러나 그렇게 하면 또 달라져서... 결국 마지막 dev 버전에서 xcode에서 없는 파일 하나씩 불러오고, 변경된 xcodeproj 를 merge 한 것으로 해결... 