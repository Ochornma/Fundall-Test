//
//  Extensions.swift
//  Fundall
//
//  Created by Promise Ochornma on 14/04/2021.
//

import Foundation
import UIKit

extension UITextField{
    func toogglepassword(){
        isSecureTextEntry = !isSecureTextEntry
        if let existingtext = text, isSecureTextEntry{
            deleteBackward()
            if let textRange = textRange(from: beginningOfDocument, to: endOfDocument) {
                replace(textRange, withText: existingtext)
            }
        }
        
        if let existingtextrange = selectedTextRange {
            selectedTextRange = nil
            selectedTextRange = existingtextrange
        }
    }
    
}
