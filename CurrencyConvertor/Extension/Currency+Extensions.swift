//
//  Currency+Extensions.swift
//  CurrencyConvertor
//
//  Created by Navroz on 22/08/21.
//

import Foundation
// https://stackoverflow.com/questions/29782982/how-to-input-currency-format-on-a-text-field-from-right-to-left-using-swift
extension String {
    
    func currencyInputFormatting() -> String {
        
        var number: NSNumber!
        let formatter = NumberFormatter.formatter()
        number = removeCurrencySymbols()
        guard number != 0 as NSNumber else {
            return ""
        }
        return formatter.string(from: number)!
    }
    
    // remove from String: "$", ".", ","
    func removeCurrencySymbols() -> NSNumber {
        var amountWithPrefix = self
        let regex = try! NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
        amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix,
                                                          options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                                          range: NSMakeRange(0, self.count), withTemplate: "")
        let double = (amountWithPrefix as NSString).doubleValue
        return NSNumber(value: (double / 100))
        
    }
}

extension Double {
    
    // formatting text for currency textField
    func currencyInputFormatting() -> String {
        let formatter = NumberFormatter.formatter()
        let number = NSNumber(value: self)
        guard number != 0 as NSNumber else {
            return ""
        }
        return formatter.string(from: number)!
    }
}


extension NumberFormatter {
    
    static func formatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = ""
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter
    }
}
