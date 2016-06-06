//
//  SentenceLengthStatisticCalculator.swift
//  TextAnalysis
//
//  Created by Saharat Rodjanamongkol on 5/23/16.
//  Copyright © 2016 Saharat Rodjanamongkol. All rights reserved.
//

import Foundation

struct SentenceLengthStatisticCalculator {

    private(set) var average: Double
    private(set) var median: Double
    let mode: Int
//    private(set) var std: Double
//    private(set) var variance: Double
    private(set) var min: Int
    private(set) var max: Int

    init(baseTextData: BaseTextData) {
        let sentenceLengthFrequencyMap = baseTextData.sentenceLengthFrequencyMap

        let sortedDict = sentenceLengthFrequencyMap.dict.sort { $0.0 < $1.0 }

//        let totalLength = sortedDict.reduce(0) { (sum: Int, countTuple: (Int, Int)) -> Int in
//            return sum + countTuple.0 * countTuple.1
//        }

        average = Double(baseTextData.numWord) / Double(baseTextData.numSentence)
        median = 0

        var prevLength = 0
        var medianPosition = Int(ceil(Double(baseTextData.numSentence) / 2))
        var maxCount = 0
        var mode = 0

        for (length, count) in sortedDict {
            if medianPosition < 0 {
                median = Double(prevLength)
            } else if medianPosition == 0 {
                if baseTextData.numSentence % 2 == 0 {
                    median = Double(prevLength)
                } else {
                    median = Double(length + prevLength) / 2
                }
            }
            medianPosition -= count
            prevLength = length

            if count > maxCount {
                maxCount = count
                mode = length
            }
        }

        if median == 0 {
            median = Double(prevLength)
        }

        self.mode = mode

        let checkAvg = Double(baseTextData.numWord) / Double(baseTextData.numSentence)

        if (average == checkAvg) {
            print("All is good")
        }

        if sortedDict.count > 0 {
            min = sortedDict.first!.0
            max = sortedDict.last!.0
        } else {
            min = 0
            max = 0
        }
    }
}