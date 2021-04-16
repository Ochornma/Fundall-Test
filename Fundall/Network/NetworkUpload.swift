//
//  NetworkUpload.swift
//  Fundall
//
//  Created by Promise Ochornma on 16/04/2021.
//

import Foundation
import MobileCoreServices
import Alamofire
import UIKit
import RxSwift

class NetworkUpload {
    
    struct RequestBody {
        var key: String
        var value: String
        var blob:  Data
        
    }
    
    var url = "https://campaign.fundall.io/api/v1/base/avatar"
   
    var generaldelegate: UploadErrorMessage?
    var uploadDelegate: UploadSuccess?
    var unaunthenticateDelegae: Unaunthenticated?
    //var session: Session
    static let shared = NetworkUpload()
    
    let sessionManager: Session = {
        //2
        let configuration = URLSessionConfiguration.af.default
        //3
        configuration.timeoutIntervalForRequest = 60
        let evaluators: [String: ServerTrustEvaluating] = [
            // By default, certificates included in the app bundle are pinned automatically.
            // NetworkConstants.baseUrl : PinnedCertificatesTrustEvaluator(),
            // By default, public keys from certificates included in the app bundle are used automatically.
            "softkash-api.herokuapp.com" : PublicKeysTrustEvaluator()
        ]
        
        //   ServerTrustManager(evaluators: evaluators)
        //configuration.waitsForConnectivity = true
        
        //4
        return Session(configuration: configuration, serverTrustManager: ServerTrustManager( allHostsMustBeEvaluated: true, evaluators: evaluators))
        // return Session(configuration: configuration, serverTrustManager: ServerTrustManager(evaluators: evaluators))
    }()
    
    
    func returnMimeType(fileExtension: String) -> String{
        if let oUTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, fileExtension as NSString, nil)?.takeRetainedValue(){
            if let mimeType = UTTypeCreatePreferredIdentifierForTag(oUTI, kUTTagClassMIMEType, nil)?.takeRetainedValue(){
                return mimeType as String
            }
        }
        return ""
    }
    
    func uploadDocument(image: UIImage,imageUrl: NSURL) {
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: "token")
        let filename = imageUrl.absoluteString
        let arrayofName = filename?.components(separatedBy: ".")
        let mimeType = returnMimeType(fileExtension: arrayofName![1])
        let headers: HTTPHeaders = ["Content-type" : "multipart/form-data",
                                    "Authorization" : "Bearer \(token ?? " ")"]
        
        if let data = image.jpegData(compressionQuality: 1.0){
           
         
            
            AF.upload(multipartFormData: { multipartFormData in
                
                multipartFormData.append(data, withName: "avatar", fileName: filename!, mimeType: mimeType)
                
            }, to: url, usingThreshold: UInt64.init(), method: .post, headers: headers).uploadProgress{
                progres in
               
            }.responseJSON(completionHandler: { [self]
                response in
                switch response.result {
                case .success:
                    print(response)
                    if response.response?.statusCode == 200 {
                        let data = response.data
                        var value: AvatarResponse
                        do {
                            value = try JSONDecoder().decode(AvatarResponse.self, from: data!)
                            // observer.onNext(value)
                            print(value)
                            uploadDelegate?.upload(respone: value)
                        } catch  let error{
                            // print("error catch")
                            print("error decode \(error.localizedDescription)")
                            generaldelegate?.uploadError()
                            // observer.onError(error)
                        }
                    }else{
                        guard let error1 = (response.error?.underlyingError as? URLError) else { return }
                        print(response.response?.statusCode ?? 00)
                        switch response.response?.statusCode {
                        case 401:
                            unaunthenticateDelegae?.errow()
                        default:
                            generaldelegate?.uploadError()
                        }
                    }
                case .failure(let error):
                    guard let error1 = (error.underlyingError as? URLError) else { return }
                    print(response.response?.statusCode ?? 00)
                    switch response.response?.statusCode {
                    case 401:
                        unaunthenticateDelegae?.errow()
                    default:
                        generaldelegate?.uploadError()
                    }
                }
            })
      
        }
    }
}

protocol UploadSuccess {
    func upload(respone: AvatarResponse)
}
protocol UploadErrorMessage {
    func uploadError()
}
protocol Unaunthenticated {
    func errow()
}



