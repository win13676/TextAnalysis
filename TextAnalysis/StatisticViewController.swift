//
//  StatisticViewController.swift
//  TextAnalysis
//
//  Created by Saharat Rodjanamongkol on 5/5/16.
//  Copyright © 2016 Saharat Rodjanamongkol. All rights reserved.
//

import UIKit

class StatisticViewController: UIViewController {

    private var _didSetConstraint = false

    private let textAnalyzer: TextAnalyzer

    private let overallStatisticView: StatisticView
    private var paragraphStatsViews: [UIView] = []

    init(textAnalyzer: TextAnalyzer) {
        self.textAnalyzer = textAnalyzer
        self.overallStatisticView = StatisticView(textAnalyzer: textAnalyzer)
        super.init(nibName: nil, bundle: nil)

//        self.overallStatisticView.titleText = "Overall Statistic"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        edgesForExtendedLayout = .None

        view.backgroundColor = UIColor.whiteColor()
        title = "Statistics"

        setUpViewHeirarchy()
        setUpStaticConstraint()
        view.setNeedsUpdateConstraints()
    }

    func setUpViewHeirarchy() {
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(overallStatisticLabel)
        mainStackView.addArrangedSubview(overallStatisticView)
        mainStackView.addArrangedSubview(paragraphStatisticLabel)
        for (index, paragraphData) in textAnalyzer.paragraphDatas.enumerate() {
            let paragraphStatsView = ParagraphStatisticView(paragraphNumber: index, paragraphData: paragraphData)
            paragraphStatsViews.append(paragraphStatsView)
            mainStackView.addArrangedSubview(paragraphStatsView)
        }
    }

    func setUpStaticConstraint() {
        if (!_didSetConstraint) {
            _didSetConstraint = true

            mainScrollView.e_attatchWithMargin(Spacing.Default.rawValue)
            mainStackView.e_attatchWithMargin(0.0)

            mainStackView.e_equalWidth(mainScrollView)
        }
    }

    private lazy var mainScrollView: UIScrollView = {
        self.mainScrollView = UIScrollView()
        self.mainScrollView.translatesAutoresizingMaskIntoConstraints = false

        return self.mainScrollView
    }()

    private lazy var mainStackView: UIStackView = {
        self.mainStackView = UIStackView()
        self.mainStackView.translatesAutoresizingMaskIntoConstraints = false
        self.mainStackView.axis = .Vertical
        self.mainStackView.distribution = .EqualSpacing
        self.mainStackView.spacing = Spacing.Half.rawValue

        return self.mainStackView
    }()

    private lazy var overallStatisticLabel: UILabel = {
        self.overallStatisticLabel = UILabel()
        self.overallStatisticLabel.translatesAutoresizingMaskIntoConstraints = false
        self.overallStatisticLabel.numberOfLines = 1
        self.overallStatisticLabel.textAlignment = .Center
        self.overallStatisticLabel.text = "Overall Statistic"

        return self.overallStatisticLabel
    }()

    private lazy var paragraphStatisticLabel: UILabel = {
        self.paragraphStatisticLabel = UILabel()
        self.paragraphStatisticLabel.translatesAutoresizingMaskIntoConstraints = false
        self.paragraphStatisticLabel.numberOfLines = 1
        self.paragraphStatisticLabel.textAlignment = .Center
        self.paragraphStatisticLabel.text = "Paragraph Statistic"

        return self.paragraphStatisticLabel
    }()
}
