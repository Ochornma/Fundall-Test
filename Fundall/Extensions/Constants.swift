//
//  Constants.swift
//  Fundall
//
//  Created by Promise Ochornma on 14/04/2021.
//

import Foundation
import UIKit

class Constants{
    

    
    func addPasswordToggle(field: UITextField, eyebutton: UIButton) {
        eyebutton.setImage(UIImage(systemName: "eye"), for: .normal)
        eyebutton.imageEdgeInsets = UIEdgeInsets(top: 5, left: -24, bottom: 5, right: 15)
        eyebutton.frame = CGRect(x: CGFloat(field.frame.size.width - 25), y: CGFloat(5), width: CGFloat(15), height: CGFloat(25))
        eyebutton.tintColor = .black
       
        field.rightViewMode = .always
        field.rightView = eyebutton
    }
    
    func presentVC(presenter: UIViewController, identifier: String) {
        let stoaryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainVc = stoaryboard.instantiateViewController(withIdentifier: identifier)
        mainVc.modalPresentationStyle = .fullScreen
        presenter.present(mainVc, animated: true, completion: nil)
    }
    
 
}
