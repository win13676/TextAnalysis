//
//  ParagraphStatisticView.swift
//  TextAnalysis
//
//  Created by Saharat Rodjanamongkol on 5/7/16.
//  Copyright © 2016 Saharat Rodjanamongkol. All rights reserved.
//

import UIKit

class ParagraphStatisticView: ExpandableView {

    private var _didSetConstraint = false

    let paragraphData: ParagraphData
    let paragraphNumber: Int

    let statisticView: StatisticView

    let paragraphLabel: UILabel 
//        = {
//        self.paragraphLabel = UILabel()
//        self.paragraphLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        self.paragraphLabel.numberOfLines = 0
//        return self.paragraphLabel
//    }()

    init(paragraphNumber: Int, paragraphData: ParagraphData) {
        self.paragraphData = paragraphData
        self.paragraphNumber = paragraphNumber

        statisticView = StatisticView(paragraphData: self.paragraphData)
        paragraphLabel = UILabel()
//                paragraphLabel.translatesAutoresizingMaskIntoConstraints = false

        paragraphLabel.numberOfLines = 1
        paragraphLabel.text = paragraphData.paragraph
        paragraphLabel.lineBreakMode = .ByTruncatingTail

        super.init(baseView: paragraphLabel, expandedView: statisticView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
