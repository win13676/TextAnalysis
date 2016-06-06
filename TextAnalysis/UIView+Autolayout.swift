//
//  UIView+Autolayout.swift
//  SplitAndTip
//
//  Created by Saharat Rodjanamongkol on 11/9/15.
//  Copyright © 2015 Win. All rights reserved.
//

import UIKit

extension UIView {

    func e_attatchWithMargin(margin: CGFloat) -> [NSLayoutConstraint] {
        var constraints = self.e_attatchWithHorizontalMargin(margin)
        constraints.appendContentsOf(self.e_attatchWithVerticalMargin(margin))
        return constraints
    }

    func e_attatchWithHorizontalMargin(leftMargin: CGFloat, rightMargin: CGFloat) -> [NSLayoutConstraint] {
        if (self.superview == nil) {
            return []
        }
        let constraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-leftMargin-[self]-rightMargin-|",
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: ["leftMargin": leftMargin, "rightMargin": rightMargin],
            views: ["self": self])
        NSLayoutConstraint.activateConstraints(constraints)
        return constraints
    }
    func e_attatchWithHorizontalMargin(margin: CGFloat) -> [NSLayoutConstraint] {
        return e_attatchWithHorizontalMargin(margin, rightMargin: margin)
    }

    func e_attatchWithVerticalMargin(topMargin: CGFloat, botMargin: CGFloat) -> [NSLayoutConstraint] {
        if (self.superview == nil) {
            return []
        }
        let constraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-topMargin-[self]-botMargin-|",
            options: NSLayoutFormatOptions(rawValue: 0),
            metrics: ["topMargin": topMargin, "botMargin": botMargin],
            views: ["self": self])
        NSLayoutConstraint.activateConstraints(constraints)
        return constraints
    }
    func e_attatchWithVerticalMargin(margin: CGFloat) -> [NSLayoutConstraint] {
        return e_attatchWithVerticalMargin(margin, botMargin: margin)
    }

    func e_setWidth(width: CGFloat) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: width)
        NSLayoutConstraint.activateConstraints([constraint])
        return constraint
    }
    func e_setHeight(height: CGFloat) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: height)
        NSLayoutConstraint.activateConstraints([constraint])
        return constraint
    }

    func e_equalWidth(otherView: UIView) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: otherView,
            attribute: NSLayoutAttribute.Width,
            multiplier: 1.0,
            constant: 0.0)
        NSLayoutConstraint.activateConstraints([constraint])
        return constraint
    }
    func e_equalHeight(otherView: UIView) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: otherView,
            attribute: NSLayoutAttribute.Height,
            multiplier: 1.0,
            constant: 0.0)
        NSLayoutConstraint.activateConstraints([constraint])
        return constraint
    }

    func e_setMinWidth(width: CGFloat) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.GreaterThanOrEqual,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: width)
        NSLayoutConstraint.activateConstraints([constraint])
        return constraint
    }
    func e_setMinHeight(height: CGFloat) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.GreaterThanOrEqual,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1.0,
            constant: height)
        NSLayoutConstraint.activateConstraints([constraint])
        return constraint
    }

    func e_layoutLeftRight(otherView: UIView, spacing: CGFloat) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self,
            attribute: NSLayoutAttribute.Left,
            relatedBy: NSLayoutRelation.Equal,
            toItem: otherView,
            attribute: NSLayoutAttribute.Right,
            multiplier: 1.0,
            constant: spacing)
        NSLayoutConstraint.activateConstraints([constraint])
        return constraint
    }
}
