//
//  TextAnalyzer.swift
//  TextAnalysis
//
//  Created by Saharat Rodjanamongkol on 4/20/16.
//  Copyright © 2016 Saharat Rodjanamongkol. All rights reserved.
//

import Foundation

class TextAnalyzer: BaseTextData {

    let paragraphDatas: [ParagraphData]

//    private(set) var wordFrequencyMap = CountingDictionary<String>()
//    private(set) var sentenceLengthFrequencyMap = CountingDictionary<Int>()
//    private(set) var numWord: Int = 0
//    private(set) var numSentence: Int = 0
    private(set) var numParagraph: Int = 0

    init(text: String) {
        paragraphDatas = text.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet()).filter { $0 != "" && !$0.isEmpty }.map(ParagraphData.init)
    }

    func analyzeText() {
        for paragraphData in paragraphDatas {
            paragraphData.processParagraph()
            wordFrequencyMap.combineWithDict(paragraphData.wordFrequencyMap)
            sentenceLengthFrequencyMap.combineWithDict(paragraphData.sentenceLengthFrequencyMap)
            numWord += paragraphData.numWord
            numSentence += paragraphData.numSentence
        }

        numParagraph = paragraphDatas.count
    }

    override var description: String {
        return "numWord \(numWord) \n" +
            "numSentence \(numSentence) \n" +
            "numParagraph \(numParagraph) \n"
    }
}
