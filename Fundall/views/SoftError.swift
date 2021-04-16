//
//  SoftError.swift
//  Fundall
//
//  Created by Promise Ochornma on 16/04/2021.
//

import Foundation
import UIKit
import TransitionButton

class SoftError {
    
    static func errorReturned(button: TransitionButton? , error422message: String, error: Error, soft: SoftViews, vc: UIViewController){
        button?.stopAnimation(animationStyle: .shake, completion: {
            switch error{
            case    ApiError.unauthenticated:
                soft.unauntenticated("", message: "Session Expired", vc: vc)
            case ApiError.notFound(let message):
                soft.showOkayableMessage("Error!", message: message, vc: vc)
            default:
                soft.showOkayableMessage("Error!", message: "Try Again", vc: vc)
            }
        })
       
    }
    
}
