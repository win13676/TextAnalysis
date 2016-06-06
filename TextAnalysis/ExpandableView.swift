//
//  ExpandableView.swift
//  TextAnalysis
//
//  Created by Saharat Rodjanamongkol on 5/7/16.
//  Copyright © 2016 Saharat Rodjanamongkol. All rights reserved.
//

import UIKit

class ExpandableView: UIView {

    private var _didSetConstraint = false

    let baseView: UIView
    let expandedView: UIView

    var hideBottomConstraint: NSLayoutConstraint = NSLayoutConstraint()
    var expandBottomConstraint: NSLayoutConstraint = NSLayoutConstraint()

    init(baseView: UIView, expandedView: UIView) {
        // TODO: create container view
        self.baseView = baseView
        self.expandedView = expandedView

        super.init(frame: CGRectZero)
        self.baseView.translatesAutoresizingMaskIntoConstraints = false
        self.expandedView.translatesAutoresizingMaskIntoConstraints = false

        self.expandedView.hidden = true
        self.seperator.hidden = true

        layer.borderColor = UIColor.blackColor().CGColor
        layer.borderWidth = 0.5
        layer.cornerRadius = 4.0

//        backgroundColor = UIColor.redColor()

        setUpViewHeirarchy()
        setUpStaticConstraint()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpStaticConstraint() {
        if (!_didSetConstraint) {
            _didSetConstraint = true

            showHideButton.rightAnchor.constraintEqualToAnchor(self.rightAnchor).active = true
            showHideButton.topAnchor.constraintEqualToAnchor(self.topAnchor).active = true

//            baseView.e_attatchWithHorizontalMargin(Spacing.Half.rawValue)

            baseView.leftAnchor.constraintEqualToAnchor(self.leftAnchor, constant: Spacing.Half.rawValue).active = true
            baseView.rightAnchor.constraintEqualToAnchor(showHideButton.leftAnchor, constant: -Spacing.Half.rawValue).active = true

            expandedView.e_attatchWithHorizontalMargin(Spacing.Half.rawValue)
            seperator.e_attatchWithHorizontalMargin(0.0)

            baseView.topAnchor.constraintEqualToAnchor(self.topAnchor, constant: Spacing.Half.rawValue).active = true

            seperator.topAnchor.constraintEqualToAnchor(baseView.bottomAnchor, constant: Spacing.Half.rawValue).active = true
            expandedView.topAnchor.constraintEqualToAnchor(seperator.bottomAnchor, constant: Spacing.Half.rawValue).active = true

            hideBottomConstraint = self.bottomAnchor.constraintEqualToAnchor(baseView.bottomAnchor, constant: Spacing.Half.rawValue)
            hideBottomConstraint.active = true

            expandBottomConstraint = self.bottomAnchor.constraintEqualToAnchor(expandedView.bottomAnchor, constant: Spacing.Half.rawValue)
            expandBottomConstraint.active = false
        }
    }

    func hideShow(_: UITapGestureRecognizer) {
        if hideBottomConstraint.active {
            showHideButton.setTitle("Hide", forState: .Normal)
            hideBottomConstraint.active = false
            expandBottomConstraint.active = true
            expandedView.hidden = false
            seperator.hidden = false
        } else {
            showHideButton.setTitle("Show", forState: .Normal)
            expandBottomConstraint.active = false
            hideBottomConstraint.active = true
            expandedView.hidden = true
            seperator.hidden = true
        }
//        UIView.animateWithDuration(0.5, animations: {
//            self.layoutIfNeeded()
//            }, completion: { (_: Bool) in
//                if self.hideBottomConstraint.active {
//                    self.showHideButton.setTitle("Show", forState: .Normal)
//                } else {
//                    self.showHideButton.setTitle("Hide", forState: .Normal)
//                    self.expandedView.hidden = false
//                }
//        })
    }

    private func setUpViewHeirarchy() {
        addSubview(baseView)
        addSubview(seperator)
        addSubview(expandedView)
        addSubview(showHideButton)
    }

    private lazy var seperator: UIView = {
        self.seperator = UIView()
        self.seperator.translatesAutoresizingMaskIntoConstraints = false
        self.seperator.e_setHeight(1)
        self.seperator.backgroundColor = UIColor.grayColor()

        return self.seperator
    }()

    private lazy var showHideButton: UIButton = {
        self.showHideButton = UIButton()
        self.showHideButton.translatesAutoresizingMaskIntoConstraints = false

        self.showHideButton.titleLabel!.font = UIFont.systemFontOfSize(10.0)
//        self.showHideButton.numberOfLines = 1
        self.showHideButton.setTitleColor(LinkColor, forState: .Normal)
        self.showHideButton.backgroundColor = UIColor.whiteColor()
        self.showHideButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)

        //        layer.borderColor = UIColor.blackColor().CGColor
        //        layer.borderWidth = 0.5
        //        layer.cornerRadius = 4.0

//        let pressGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ExpandableView.hideShow(_:)))
        self.showHideButton.addTarget(self, action: #selector(ExpandableView.hideShow(_:)), forControlEvents: .TouchUpInside)

        self.showHideButton.setTitle("Show", forState: .Normal)

        self.showHideButton.setContentHuggingPriority(UILayoutPriorityRequired, forAxis: .Horizontal)
        self.showHideButton.setContentCompressionResistancePriority(UILayoutPriorityRequired, forAxis: .Horizontal)

        return self.showHideButton
    }()
}
