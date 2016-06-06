//
//  ParagraphData.swift
//  TextAnalysis
//
//  Created by Saharat Rodjanamongkol on 5/2/16.
//  Copyright © 2016 Saharat Rodjanamongkol. All rights reserved.
//

import Foundation

class ParagraphData: BaseTextData {
    let paragraph: String
//    let sentences: [String] = []
//    private(set) var wordFrequencyMap = CountingDictionary<String>()//: [String: Int] = [:]
//    private(set) var sentenceLengthFrequencyMap = CountingDictionary<Int>()//: [Int: Int] = [:]
//    private(set) var numWord: Int = 0
//    private(set) var numSentence: Int = 0

    let words: [String]

    let abbreviatedWord = Set(["mr", "ms", "mrs", "dr", "phd", "jr", "sr", "st", "am", "pm", "etc", "eg", "rd", "ct"])
    let nonAlphaCharacter = NSCharacterSet.alphanumericCharacterSet().invertedSet

    init(paragraph: String) {
        self.paragraph = paragraph
        self.words = paragraph.lowercaseString.componentsSeparatedByString(" ").filter { $0 != "" && !$0.isEmpty }
    }

    func processParagraph() {
        var tempSentence: [String] = []

        for word in words {
            let lastChar = word.characters.last
            let trimmedWord = word.stringByTrimmingCharactersInSet(nonAlphaCharacter)
            if trimmedWord != "" {
//                wordFrequencyMap.addObject(trimmedWord)
//                addCountToKey(trimmedWord, inMap: &wordFrequencyMap)
                wordFrequencyMap.addCountToKey(trimmedWord)
                tempSentence.append(trimmedWord)
                numWord += 1
                if lastChar == "." {
                    if !abbreviatedWord.contains(trimmedWord) {
                        processSentence(&tempSentence)
                    }
                } else if lastChar == "!" || lastChar == "?" {
                    processSentence(&tempSentence)
                }
            } else if (word == "." || word == "!" || word == "?") && !tempSentence.isEmpty {
                processSentence(&tempSentence)
            }
        }

        if !tempSentence.isEmpty {
            processSentence(&tempSentence)
        }
    }

//    private func addCountToKey<T>(key: T, inout inMap map: [T: Int]) {
//        map[key] = (map[key] != nil) ? map[key]! + 1 : 0
//    }

    func processSentence(inout tempSentence: [String]) {
//        sentenceLengthFrequencyMap.addObject(tempSentence.count)
//        addCountToKey(tempSentence.count, inMap: &sentenceLengthFrequencyMap)
        sentenceLengthFrequencyMap.addCountToKey(tempSentence.count)
        numSentence += 1
        tempSentence = []
    }

    override var description: String {
        return "numWord \(numWord) \n" +
            "numSentence \(numSentence) \n" +
            wordFrequencyMap.description + "\n" +
        sentenceLengthFrequencyMap.description + "\n"
    }
}
