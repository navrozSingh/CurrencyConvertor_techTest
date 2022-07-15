// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class ConversitionsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query conversitions($forArray: [String!]!) {
      latest(quoteCurrencies: $forArray) {
        __typename
        date
        baseCurrency
        quoteCurrency
        quote
      }
    }
    """

  public let operationName: String = "conversitions"

  public var forArray: [String]

  public init(forArray: [String]) {
    self.forArray = forArray
  }

  public var variables: GraphQLMap? {
    return ["forArray": forArray]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("latest", arguments: ["quoteCurrencies": GraphQLVariable("forArray")], type: .nonNull(.list(.nonNull(.object(Latest.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(latest: [Latest]) {
      self.init(unsafeResultMap: ["__typename": "Query", "latest": latest.map { (value: Latest) -> ResultMap in value.resultMap }])
    }

    /// Returns the latest rates
    public var latest: [Latest] {
      get {
        return (resultMap["latest"] as! [ResultMap]).map { (value: ResultMap) -> Latest in Latest(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Latest) -> ResultMap in value.resultMap }, forKey: "latest")
      }
    }

    public struct Latest: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Rate"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("date", type: .nonNull(.scalar(String.self))),
          GraphQLField("baseCurrency", type: .nonNull(.scalar(String.self))),
          GraphQLField("quoteCurrency", type: .nonNull(.scalar(String.self))),
          GraphQLField("quote", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(date: String, baseCurrency: String, quoteCurrency: String, quote: String) {
        self.init(unsafeResultMap: ["__typename": "Rate", "date": date, "baseCurrency": baseCurrency, "quoteCurrency": quoteCurrency, "quote": quote])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var date: String {
        get {
          return resultMap["date"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "date")
        }
      }

      public var baseCurrency: String {
        get {
          return resultMap["baseCurrency"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "baseCurrency")
        }
      }

      public var quoteCurrency: String {
        get {
          return resultMap["quoteCurrency"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "quoteCurrency")
        }
      }

      public var quote: String {
        get {
          return resultMap["quote"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "quote")
        }
      }
    }
  }
}

public final class AllCurrenciesQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query allCurrencies {
      latest {
        __typename
        baseCurrency
        quoteCurrency
        quote
      }
    }
    """

  public let operationName: String = "allCurrencies"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("latest", type: .nonNull(.list(.nonNull(.object(Latest.selections))))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(latest: [Latest]) {
      self.init(unsafeResultMap: ["__typename": "Query", "latest": latest.map { (value: Latest) -> ResultMap in value.resultMap }])
    }

    /// Returns the latest rates
    public var latest: [Latest] {
      get {
        return (resultMap["latest"] as! [ResultMap]).map { (value: ResultMap) -> Latest in Latest(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: Latest) -> ResultMap in value.resultMap }, forKey: "latest")
      }
    }

    public struct Latest: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Rate"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("baseCurrency", type: .nonNull(.scalar(String.self))),
          GraphQLField("quoteCurrency", type: .nonNull(.scalar(String.self))),
          GraphQLField("quote", type: .nonNull(.scalar(String.self))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(baseCurrency: String, quoteCurrency: String, quote: String) {
        self.init(unsafeResultMap: ["__typename": "Rate", "baseCurrency": baseCurrency, "quoteCurrency": quoteCurrency, "quote": quote])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var baseCurrency: String {
        get {
          return resultMap["baseCurrency"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "baseCurrency")
        }
      }

      public var quoteCurrency: String {
        get {
          return resultMap["quoteCurrency"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "quoteCurrency")
        }
      }

      public var quote: String {
        get {
          return resultMap["quote"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "quote")
        }
      }
    }
  }
}
