>  OCR: Optical Character Recognition
> Vision 프레임워크를 사용하여 이미지에서 텍스트를 인식하는 역할을 수행하는 클래스 
```
//
//  OCRManager.swift
//  chukapoka
//
//  Created by jenki on 6/8/25.
//

import UIKit
import Vision

class OCRManager {
    func recognizeText(from image: UIImage) async -> [String] {
        guard let cgImage = image.cgImage else {
            print("CGImage 변환 실패")
            return []
        }

        return await withCheckedContinuation { continuation in
            let request = VNRecognizeTextRequest { request, error in
                if let error = error {
                    print("OCR 에러: \(error)")
                    continuation.resume(returning: [])
                    return
                }

                let texts = (request.results as? [VNRecognizedTextObservation])?
                    .compactMap { $0.topCandidates(1).first?.string } ?? []
                continuation.resume(returning: texts)
            }

            request.recognitionLanguages = ["ko-KR", "en-US"]
            request.recognitionLevel = .accurate

            let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            do {
                try handler.perform([request])
            } catch {
                print("OCR 실행 에러: \(error)")
                continuation.resume(returning: [])
            }
        }
    }
}
```
##### 전체흐름
1. 이미지 -> CGImage 로 변환
2. VNRecognizeTextRequest 생성
3. VNImageRequestHandler를 통해 이미지 분석 요청 수행
4. 결과는 VNRecognizedTextObservation 배열로 반환


## 톺아보기

##### UIImage를 받아서 String 배열로 반환하는 비동기 함수 (async)
```
class OCRManager {
    func recognizeText(from image: UIImage) async -> [String]
}
```
**비동기 함수** (async/await)
- 결과가 바로 나오지 않고, 시간이 걸리는 작업을 기다렸다가 처리하는 함수, 
- 요청을 보내놓고 결과가 오면 알려주는 방식
- 효율적인 작업 분산을 위한 방식으로 부드럽게 작동하게 하기위함 
-> 텍스트 인식이 끝날때까지 기다린 후에 결과 [String]을 리턴 

##### UIImage를 CGImage로반환 
```
guard let cgImage = image.cgImage else {
    print("CGImage 변환 실패")
    return []
}
```
- VNImageRequestHandler 라는 Vision 프레임워크의 클래스는 CGImage 형식만 입력받음
- UIimage 안에 있는 CGImage를 꺼내오는 것 
- 항상 가지고 있는 것은 아니라서 optional로 반환되고 guard let으로 안전하게 처리 

**이미지 타입**
- UIImage 
	- SwiftUI나 UIKit에서 일반적으로 사용하는 이미지 타입
	- 내부적으로 CGImage, CIImage 중 하나 혹은 둘 다 가질 수 있다
- CGImage
	- Core Graphics 레벨의 저수준 이미지 (픽셀 단위)
	- 빠르고 정밀한 이미지 렌더링이 필요한 경우에 적합
- CIImage
	- Core Image 프레임워크의 이미지 타입
	- 필터, 블러, 색상 조정 등 이미지 처리나 효과에 최적화 
	- 실제 픽셀 데이터를 가지고 있지 않고, 연산 정의만 가지고 있다가 필요할 때 렌더링 됨 (lazy processing)

##### VNRecognizeTextRequest
https://developer.apple.com/documentation/vision/vnrecognizetextrequest
```
let request = VNRecognizeTextRequest { request, error in ... }
```
이미지에서 글자를 찾아주는 요청 객체 
사진이나 이미지에 있는 한글, 영어 등의 텍스트를 감지하고 추출할 수 있다.
인식된 결과를 VNRecognizeTextRequest로 받고, 각 줄에서 가장 신뢰도 높은 후보만 추출하여 String 배열로 만든다
```
request.recognitionLanguages = ["ko-KR", "en-US"]
request.recognitionLevel = .accurate
```
한국어와 영어 인식 
속도보다는 정확도를 우선함 (.fast는 속도 )
```
let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
try handler.perform([request])
```
OCR 요청을 실행하고, 실패 시 에러출력하고 빈 배열 반환

##### VNImageRequestHandler
```
let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
```
Vision 프레임워크에서 이미지 데이터를 분석요청에 전달하여 실제로 처리하게 해주는 것 
이미지에서 글자, 얼굴, 바코드 등을 찾아낼 때 사용
이미지 한장을 Vision 에게 분석 요청할 때 필수적으로 사용됨
VNRecognizeTextRequest, VNDetectFaceRectanglesRequest 등과 함께 자주 사용됨

##### VNRecognizedTextObservation 
```
let texts = (request.results as? [VNRecognizedTextObservation])?
                    .compactMap { $0.topCandidates(1).first?.string } ?? []
                continuation.resume(returning: texts)
```
Vision이 인식한 텍스트 영역 하나에 대한 정보를 담고 있는 관찰결과 객체
topCandidates(1)을 사용하면 가장 신뢰도 높은 텍스트 하나만 추출
이미지에 여러 줄의 텍스트가 있으면, VNRecognizedTextObservation이 여러 개 생김