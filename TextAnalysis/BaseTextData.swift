//
//  BaseTextData.swift
//  TextAnalysis
//
//  Created by Saharat Rodjanamongkol on 6/2/16.
//  Copyright © 2016 Saharat Rodjanamongkol. All rights reserved.
//

import Foundation

class BaseTextData: NSObject {
    var wordFrequencyMap = CountingDictionary<String>()
    var sentenceLengthFrequencyMap = CountingDictionary<Int>()
    var numWord: Int = 0
    var numSentence: Int = 0
}
