//
//  Extensions.swift
//  Fundall
//
//  Created by Promise Ochornma on 14/04/2021.
//

import Foundation
import UIKit
import Charts

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

extension UIViewController{
    
    static var identifier: String{
        return String(describing: self)
    }
    
    static func instantiate() -> Self{
        let stoaryboard = UIStoryboard(name: "Main", bundle: nil)
        return stoaryboard.instantiateViewController(identifier: identifier) as Self
    }
}

extension BarChartView {
    
    private class BarChartFormatter: NSObject,IAxisValueFormatter {

           var values : [String]
           required init (values : [String]) {
               self.values = values
               super.init()
           }


           func stringForValue(_ value: Double, axis: AxisBase?) -> String {
               return values[Int(value)]
           }
       }
    
    func setBarChartData(xValues: [String], yValues1: [Double], yValues2 : [Double], yValues3: [Double], yValues4 : [Double], yValues5: [Double], yValues6 : [Double]) {
        
        var dataEntries1: [BarChartDataEntry] = []
        for i in 0..<yValues1.count {
            let dataEntry1 = BarChartDataEntry(x: Double(i), yValues:  [yValues1[i], yValues2[i], yValues3[i], yValues4[i], yValues5[i], yValues6[i]], data: "")
            dataEntries1.append(dataEntry1)
        }
        
        let chartDataSet1 = BarChartDataSet(entries: dataEntries1, label: "")
        chartDataSet1.barBorderColor = .red
        chartDataSet1.stackLabels = ["Salary", "Petty Cash", "Bonus", "Allowance", "Uncategorized", "Others"]
        chartDataSet1.colors =  [UIColor.yellow, UIColor.blue, UIColor.red, UIColor.purple, UIColor.green, UIColor.brown]
        
        let chartData = BarChartData(dataSets: [chartDataSet1])
        
        let chartFormatter = BarChartFormatter(values: xValues)
        let xAxis = XAxis()
        xAxis.valueFormatter = chartFormatter
        self.xAxis.valueFormatter = xAxis.valueFormatter
        self.data = chartData
    }
}

extension String{
    func passwordValid() -> Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[ !\"\\\\#$%&'()*+,-./:;<=>?@\\[\\]^_`{|}~])[A-Za-z\\d !\"\\\\#$%&'()*+,-./:;<=>?@\\[\\]^_`{|}~]{8,}"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self.trimmingCharacters(in: .whitespacesAndNewlines))
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    //^[0]\d{10}$
    var isValidPhone: Bool {
         // let regularExpressionForPhone = "^\\d{3}-\\d{3}-\\d{4}$"
        //Nigerian phone number
        let regularExpressionForPhone = "^[0]\\d{10}$"
          let testPhone = NSPredicate(format:"SELF MATCHES %@", regularExpressionForPhone)
          return testPhone.evaluate(with: self)
       }
}
