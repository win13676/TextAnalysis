//
//  StatisticView.swift
//  TextAnalysis
//
//  Created by Saharat Rodjanamongkol on 5/7/16.
//  Copyright © 2016 Saharat Rodjanamongkol. All rights reserved.
//

import UIKit

class StatisticView: UIView {

    private var _didSetConstraint = false

    private(set) var baseTextData: BaseTextData
    private(set) var sentenceLengthStats: SentenceLengthStatisticCalculator

    private(set) var wordFrequencyMap = CountingDictionary<String>()//: [String: Int] = [:]
    private(set) var sentenceLengthFrequencyMap = CountingDictionary<Int>()//: [Int: Int] = [:]
    private(set) var numWord: Int = 0 {
        didSet {
            numWordLabel.text = "Word Count : \(numWord)"
        }
    }
    private(set) var numSentence: Int = 0 {
        didSet {
            numSentenceLabel.text = "Sentence Count : \(numSentence)"
        }
    }

    private(set) var numParagraph: Int = 0 {
        didSet {
            numParagraphLabel.text = "Paragraph Count : \(numParagraph)"
        }
    }

    var titleText: String? {
        didSet {
            titleLabel.text = titleText
        }
    }

    init(baseTextData: BaseTextData) {
        self.baseTextData = baseTextData
        sentenceLengthStats = SentenceLengthStatisticCalculator()

        super.init(frame: CGRectZero)

        setProperties()
        setUpViewHeirarchy()
        setUpStaticConstraint()
    }

//    init(paragraphData: ParagraphData) {
//        self.paragraphData = paragraphData
//
//        super.init(frame: CGRectZero)
//
//        commonInit()
//    }

//    private func commonInit() {
//        layer.borderColor = UIColor.blackColor().CGColor
//        layer.borderWidth = 1.0
//        layer.cornerRadius = 4.0

//    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setProperties() {
//        if let textAnalyzer = textAnalyzer {
            wordFrequencyMap = baseTextData.wordFrequencyMap
            sentenceLengthFrequencyMap = baseTextData.sentenceLengthFrequencyMap
            numWord = baseTextData.numWord
            numSentence = baseTextData.numSentence

        if let textAnalyzer = baseTextData as? TextAnalyzer {
            numParagraph = textAnalyzer.numParagraph
        }
//            numParagraph = textAnalyzer.numParagraph
//        } else if let paragraphData = paragraphData {
//            wordFrequencyMap = paragraphData.wordFrequencyMap
//            sentenceLengthFrequencyMap = paragraphData.sentenceLengthFrequencyMap
//            numWord = paragraphData.numWord
//            numSentence = paragraphData.numSentence
//        }
    }

    private func setUpStaticConstraint() {
        if (!_didSetConstraint) {
            _didSetConstraint = true

            mainStackView.e_attatchWithMargin(0.0)
        }
    }

    private func setUpViewHeirarchy() {
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(numWordLabel)
        mainStackView.addArrangedSubview(numSentenceLabel)
        if numParagraph != 0 {
            mainStackView.addArrangedSubview(numParagraphLabel)
        }
        mainStackView.addArrangedSubview(wordFrequencyLabel)
    }

    private lazy var mainStackView: UIStackView = {
        self.mainStackView = UIStackView()
        self.mainStackView.translatesAutoresizingMaskIntoConstraints = false
        self.mainStackView.axis = .Vertical
        self.mainStackView.distribution = .Fill
        self.mainStackView.spacing = Spacing.Half.rawValue

        return self.mainStackView
    }()

    private lazy var titleLabel: UILabel = {
        self.titleLabel = UILabel()
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false

        self.titleLabel.numberOfLines = 1
        self.titleLabel.textAlignment = .Center
//        self.titleLabel.text = "Overall Statistic"

        return self.titleLabel
    }()

    private lazy var numWordLabel: UILabel = {
        self.numWordLabel = UILabel()
        self.numWordLabel.translatesAutoresizingMaskIntoConstraints = false

        self.numWordLabel.numberOfLines = 1

        return self.numWordLabel
    }()

    private lazy var numSentenceLabel: UILabel = {
        self.numSentenceLabel = UILabel()
        self.numSentenceLabel.translatesAutoresizingMaskIntoConstraints = false

        self.numSentenceLabel.numberOfLines = 1

        return self.numSentenceLabel
    }()

    private lazy var numParagraphLabel: UILabel = {
        self.numParagraphLabel = UILabel()
        self.numParagraphLabel.translatesAutoresizingMaskIntoConstraints = false

        self.numParagraphLabel.numberOfLines = 1

        return self.numParagraphLabel
    }()

    private lazy var wordFrequencyLabel: ExpandableView = {
        let wordFrequencyTitleLabel = UILabel()
        wordFrequencyTitleLabel.text = "Word Frequency:"
        let wordFrequency = UILabel()
                wordFrequency.numberOfLines = 0
        wordFrequency.text = self.wordFrequencyMap.description
        self.wordFrequencyLabel = ExpandableView(baseView: wordFrequencyTitleLabel, expandedView: wordFrequency)
        self.wordFrequencyLabel.translatesAutoresizingMaskIntoConstraints = false

        return self.wordFrequencyLabel
    }()

    private lazy var sentenceLengthDataLabel: ExpandableView = {
        let averageSentenceLengthlabel = UILabel()
        averageSentenceLengthlabel.text = "Word Frequency:"
        let wordFrequency = UILabel()
        wordFrequency.numberOfLines = 0
        wordFrequency.text = self.wordFrequencyMap.description
        self.wordFrequencyLabel = ExpandableView(baseView: averageSentenceLengthlabel, expandedView: wordFrequency)
        self.wordFrequencyLabel.translatesAutoresizingMaskIntoConstraints = false

        return self.wordFrequencyLabel
    }()
}
