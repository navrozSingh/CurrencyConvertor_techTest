//
//  Locale+Extension .swift
//  CurrencyConvertor
//
//  Created by Navroz on 22/08/21.
//

import Foundation
//https://stackoverflow.com/questions/40270754/get-currency-symbol-based-on-country-code-or-country-name-using-nslocale
struct CurrencyToRegionMapper {
    
    static let locales = Locale.availableIdentifiers.map(Locale.init)
    
    static func locales(currencyCode: String) -> Set<Locale> {
        let localesWithCode = self.locales.filter { locale in
            locale.currencyCode == currencyCode
        }
        return Set(localesWithCode)
    }
    
    static func locales(currencySymbol: String) -> Set<Locale> {
        let localesWithSymbol = self.locales.filter { locale in
            locale.currencySymbol == currencySymbol
        }
        return Set(localesWithSymbol)
    }
    
    static func regionNames(currencyCode: String, forLocale locale: Locale = Locale.autoupdatingCurrent) -> Set<String> {
        let locale = Locale(identifier: locale.identifier) // .current and .autoupdatingCurrent doesn't work without this hack for some reason
        let localesForCode = self.locales(currencyCode: currencyCode)
        let names: [String] = localesForCode.flatMap { loc in
            if let regionCode = loc.regionCode {
                return locale.localizedString(forRegionCode: regionCode)
            } else {
                return locale.localizedString(forIdentifier: loc.identifier)
            }
        }
        return Set(names)
    }
    
    static func regionNames(currencySymbol: String, forLocale locale: Locale = Locale.autoupdatingCurrent) -> Set<String> {
        let locale = Locale(identifier: locale.identifier) // .current and .autoupdatingCurrent doesn't work without this hack for some reason
        let localesForSymbol = self.locales(currencySymbol: currencySymbol)
        let names: [String] = localesForSymbol.flatMap { loc in
            if let regionCode = loc.regionCode {
                return locale.localizedString(forRegionCode: regionCode)
            } else {
                return locale.localizedString(forIdentifier: loc.identifier)
            }
        }
        return Set(names)
    }
    
}

