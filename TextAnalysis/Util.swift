//
//  Util.swift
//  SplitAndTip
//
//  Created by Saharat Rodjanamongkol on 11/10/15.
//  Copyright © 2015 Win. All rights reserved.
//

import UIKit

func afterDecimalLength(number: String) -> Int {
    let ch: Character = "."
    if let index = number.characters.indexOf(ch) {
        return number.substringFromIndex(index.advancedBy(1)).characters.count
    } else {
        return -1
    }
}

func roundDownToDecimalPlace(number: Double, decimalPlace: Int) -> Double {
    let basePow = pow(10.0, Double(decimalPlace))
    return Double(floor(basePow*number)/basePow)
}

func roundToDecimalPlace(number: Double, decimalPlace: Int) -> Double {
    let basePow = pow(10.0, Double(decimalPlace))
    return Double(round(basePow*number)/basePow)
}

func stringPresent(s: String?) -> Bool {
    return s != nil && s != ""
}

func addBorder(view: UIView) {
    view.layer.borderWidth = 0.5
    view.layer.borderColor = UIColor.blackColor().CGColor
    view.layer.cornerRadius = 4.0
}
