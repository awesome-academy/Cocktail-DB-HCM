//
//  APIService.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 17/12/2022.
//

import Foundation
import Alamofire
import ObjectMapper
import RxSwift

final class APIService {
    static let shared = APIService()
    
    private init() {}

    func request<T: Mappable>(url: String, responseType: T.Type) -> Observable<T> {
        return Observable.create { observer in
            AF.request(url, parameters: [:], encoding: URLEncoding.default)
            .validate(statusCode: 200 ..< 300)
            .responseJSON { (response) in
                switch response.result {
                case .success(let data):
                    guard let object = Mapper<T>().map(JSONObject: data) else { return }
                    observer.onNext(object)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
