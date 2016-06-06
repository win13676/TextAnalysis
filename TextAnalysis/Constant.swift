//
//  Constant.swift
//  SplitAndTip
//
//  Created by Saharat Rodjanamongkol on 11/6/15.
//  Copyright © 2015 Win. All rights reserved.
//

import UIKit

public enum TextFieldInputType: Int {
    case Number
    case String
}

public enum TextFieldType: Int {
    case Title
    case BasePrice
    case SplitPrice
    case SplitSum
    case Tax
    case TaxPercent
    case Tip
    case TipPercent
    case Total
    case NumPeople
    case PerPerson
    case Remain
    case PlusShare
    case None
}

public enum TextToggleType: Int {
    case TipBeforeTax
    case IncludeShare
    case None
}

public enum Spacing: CGFloat {
    case Default = 10.0
    case Half = 5.0
    case Double = 20.0
}

public let standardMetrics = ["spacing": Spacing.Default.rawValue,
    "half": Spacing.Half.rawValue,
    "double": Spacing.Double.rawValue]

public let PriceDecimal = 2
public let TaxDecimal = 4
public let TipDecimal = 2
public let PercentDecimal = 4

public let LinkColor = UIColor(red: 51/255.0, green: 102/255.0, blue: 187/255.0, alpha: 1)
