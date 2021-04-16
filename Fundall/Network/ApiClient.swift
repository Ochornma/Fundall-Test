//
//  ApiClient.swift
//  Fundall
//
//  Created by Promise Ochornma on 16/04/2021.
//

import Foundation
import Alamofire
import RxSwift

class APIClient {
    
    static let shared = APIClient()
    
    func login(email: String, password: String) -> Observable<LoginResponse> {
        return request(ApiRouter.login(email: email, password: password))
    }
    
    
    func register(firstname: String, lastname: String, password: String, password_confirmation: String, email: String) -> Observable<RegisterResponse> {
         request(ApiRouter.register(firstname: firstname, lastname: lastname, password: password, password_confirmation: password_confirmation, email: email))
        
        
    }
    
    
    func getProfile() -> Observable<ProfileResponse>{
        return request(ApiRouter.getProfile)
    }
    
    
    private  func request<T: Codable> (_ urlConvertible: URLRequestConvertible) -> Observable<T> {
       print(urlConvertible.urlRequest!)
        
        //Create an RxSwift observable, which will be the one to call the request when subscribed to
        return Observable<T>.create { observer in
            
            //Trigger the HttpRequest using AlamoFire (AF)
            let request = AF.request(urlConvertible).responseJSON{ [self]
                
                response in
                print(response)
                print(String(response.response?.statusCode ?? 000))
                switch response.result {
                case .success:
                    if response.response?.statusCode == 200 {
                        let data = response.data
                        var value: T
                        do {
                            value = try JSONDecoder().decode(T.self, from: data!)
                            observer.onNext(value)
                        } catch  let error{
                           // print("error catch")
                            print("error decode")
                            observer.onError(error)
                        }
                    } else{
                        _ = response.error
                        let error1 = response.value
                        let errorJson = error1 as! Dictionary<String, AnyObject>
                        let message = errorJson["message"] as? String
                        
                        switch response.response?.statusCode {
                        case 401:
                            observer.onError(ApiError.unauthenticated)
                        case 400:
                            observer.onError(ApiError.notFound(message: message ?? "Unknown Error"))
                      
                        default:
                            observer.onError(ApiError.error)
                            print("unknown error")
                        }
                    }
                    //Everything is fine, return the value in onNext
                    // print(value)
                    
                    observer.onCompleted()
                case .failure( _):
                    let error1 = response.value
                    let errorJson = error1 as! Dictionary<String, AnyObject>
                    let message = errorJson["response_message"] as? String
                    switch response.response?.statusCode {
                    case 401:
                        observer.onError(ApiError.unauthenticated)
                    case 400:
                        observer.onError(ApiError.notFound(message: message ?? "Unknown Error"))
                        //delegate?.getmessage(error: message ?? "Unknown Error")
                    
                    default:
                        observer.onError(ApiError.error)
                    //delegate?.getmessage(error: message ?? "Unknown Error")
                    }
                    
                    
                    
                    
                    
                //Something went wrong, switch on the status code and return the error
                
                }
            }
            //Finally, we return a disposable to stop the request
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
