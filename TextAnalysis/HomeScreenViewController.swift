//
//  HomeScreenViewController.swift
//  SplitAndTip
//
//  Created by Saharat Rodjanamongkol on 11/5/15.
//  Copyright © 2015 Win. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {

    private var _didSetConstraint = false

    private var textAnalyzer = TextAnalyzer(text: "")

    private var viewNormalHeight: CGFloat = 0

    private let buttonHeight: CGFloat = 60.0

    private var bottomConstraint: NSLayoutConstraint = NSLayoutConstraint()

    override func viewDidLoad() {
        super.viewDidLoad()

        edgesForExtendedLayout = .None

        title = "Input Text"

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HomeScreenViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HomeScreenViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)

        setUpViewHeirarchy()
        setUpStaticConstraint()
        view.setNeedsUpdateConstraints()

        viewNormalHeight = self.view.frame.size.height
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        view.layoutIfNeeded()
        textView.becomeFirstResponder()
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

        textView.resignFirstResponder()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    func setUpStaticConstraint() {
        if (!_didSetConstraint) {
            _didSetConstraint = true

            mainStackView.e_attatchWithHorizontalMargin(Spacing.Default.rawValue)

            mainStackView.topAnchor.constraintEqualToAnchor(view.topAnchor, constant: Spacing.Default.rawValue).active = true

            bottomConstraint = NSLayoutConstraint(item: mainStackView,
                               attribute: .Bottom,
                               relatedBy: .Equal,
                               toItem: view,
                               attribute: .Bottom,
                               multiplier: 1,
                               constant: -Spacing.Default.rawValue)
            bottomConstraint.active = true

            analyzeButton.e_setHeight(buttonHeight)
        }
    }

    func setUpViewHeirarchy() {
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(textView)
        mainStackView.addArrangedSubview(bottomStackView)
        bottomStackView.addArrangedSubview(analyzeButton)
    }

    func keyboardWillShow(notification: NSNotification) {
//        NSDictionary *userInfo = note.userInfo;
//        NSTimeInterval duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//        UIViewAnimationCurve curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
//
//        CGRect keyboardFrameEnd = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//        keyboardFrameEnd = [self.view convertRect:keyboardFrameEnd fromView:nil];
//
//        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionBeginFromCurrentState | curve animations:^{
//            self.contentView.frame = CGRectMake(0, 0, keyboardFrameEnd.size.width, keyboardFrameEnd.origin.y);
//            } completion:nil];
//        if let userInfo = notification.userInfo {
//            let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey]!.doubleValue
//            let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey]!.unsignedIntegerValue
//
//            let keyboardFrameEnd = userInfo[UIKeyboardFrameEndUserInfoKey]!.CGRectValue()
//            UIView.animateWithDuration(duration, delay: 0, options: UIViewAnimationOptions(rawValue: curve),
//                                       animations: {
//                                        self.view.frame = CGRectMake(0, 0, keyboardFrameEnd.size.width, keyboardFrameEnd.origin.y)
//                }, completion: nil)
//        }

        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue() {
//            self.bottomConstraint.constant = -(keyboardSize.height + Spacing.Default.rawValue)
//            view.setNeedsLayout()
            UIView.animateWithDuration((notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey]!.doubleValue)!, animations: {
//                self.view.frame.size.height = self.viewNormalHeight - keyboardSize.height
//                self.view.frame = CGRectOffset(self.view.frame, 0, -keyboardSize.height)
//                self.view.layoutIfNeeded()
                self.bottomConstraint.constant = -(keyboardSize.height + Spacing.Default.rawValue)
                self.view.layoutIfNeeded()
            })
        }
//        view.setNeedsLayout()
    }

    func keyboardWillHide(notification: NSNotification) {
//        self.bottomConstraint.constant = -Spacing.Default.rawValue
//        view.setNeedsLayout()
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue() {
            UIView.animateWithDuration((notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey]!.doubleValue)!, animations: {
                //                self.view.frame.size.height = self.viewNormalHeight - keyboardSize.height
//                self.view.frame = CGRectOffset(self.view.frame, 0, keyboardSize.height)
//                self.view.layoutIfNeeded()
                self.bottomConstraint.constant = -Spacing.Default.rawValue
                self.view.layoutIfNeeded()
            })
//        }
//        view.setNeedsLayout()
    }

    func analyzePressed() {
        textAnalyzer = TextAnalyzer(text: textView.text)
        textAnalyzer.analyzeText()
        let paragraphStats = StatisticViewController(textAnalyzer: textAnalyzer)
        self.navigationController?.pushViewController(paragraphStats, animated: true)
    }

    private lazy var mainStackView: UIStackView = {
        self.mainStackView = UIStackView()
        self.mainStackView.translatesAutoresizingMaskIntoConstraints = false
        self.mainStackView.axis = .Vertical
        self.mainStackView.distribution = .Fill
        self.mainStackView.spacing = Spacing.Half.rawValue

        return self.mainStackView
    }()

    private lazy var textView: UITextView = {
        self.textView = UITextView()
        self.textView.translatesAutoresizingMaskIntoConstraints = false
        self.textView.layer.borderColor = UIColor.blackColor().CGColor
        self.textView.layer.borderWidth = 1.0

        return self.textView
    }()

    private lazy var bottomStackView: UIStackView = {
        self.bottomStackView = UIStackView()
        self.bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        self.bottomStackView.axis = .Horizontal
        self.bottomStackView.distribution = .EqualSpacing

        return self.bottomStackView
    }()

    private lazy var analyzeButton: UIButton = {
        self.analyzeButton = UIButton(type: .System)
        self.analyzeButton.translatesAutoresizingMaskIntoConstraints = false
        self.analyzeButton.setTitle("Analyze", forState: .Normal)
        self.analyzeButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        self.analyzeButton.backgroundColor = UIColor.blueColor().colorWithAlphaComponent(0.5)
        self.analyzeButton.addTarget(self, action: #selector(HomeScreenViewController.analyzePressed), forControlEvents: .TouchUpInside)

        return self.analyzeButton
    }()
}
