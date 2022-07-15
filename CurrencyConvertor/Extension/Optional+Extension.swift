//
//  Optional+Extension.swift
//  CurrencyConvertor
//
//  Created by Navroz on 22/08/21.
//

import Foundation

 extension Optional {
    func unwrapped(or defaultValue: Wrapped) -> Wrapped {
        // http://www.russbishop.net/improving-optionals
        return self ?? defaultValue
    }
 }
