//
//  BaseController.swift
//  QuizApp
//
//  Created by Arsalan Daud on 16/09/2024.
//

import UIKit
import CoreData

class BaseViewController: UIViewController {
    let backButton = BackButton()
    let actionButton = Button(setTitle: "Quiz")
    let titleLabel = Label(text: "Start")
    
    private var screenTitle: String
    private var actionTitle: String
    private var isBackButtonVisible: Bool
    private var isActionButtonVisible: Bool
    private var layoutContraints: CGFloat
    private var actionButtonBottomConstraints: NSLayoutConstraint?
    
    init(screenTitle: String = "", actionTitle: String = "", isBackButtonVisible: Bool = true, isActionButtonVisible: Bool = true, layoutContraints: CGFloat = -25) {
        self.screenTitle = screenTitle
        self.actionTitle = actionTitle
        self.isActionButtonVisible = isActionButtonVisible
        self.isBackButtonVisible = isBackButtonVisible
        self.layoutContraints = layoutContraints
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addTargets()
        addObserver()
        setupTitle()
        configureActionButtonVisibility()
        view.backgroundColor = .white
    }
    func setupViews() {
        view.addSubview(titleLabel)
        view.addSubview(backButton)
        view.addSubview(actionButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10.widthRatio),
            
            actionButton.heightAnchor.constraint(equalToConstant: 50),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25.widthRatio),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25.widthRatio),
        ])
        actionButtonBottomConstraints = actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25.autoSized)
        actionButtonBottomConstraints?.isActive = true
    }
    func addTargets() {
        backButton.addTarget(self, action: #selector(didBackButtonTapped), for: .touchUpInside)
    }
    
    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    private func setupTitle() {
        titleLabel.text = screenTitle
        actionButton.setTitle(actionTitle, for: .normal)
    }
    private func configureActionButtonVisibility() {
        backButton.isHidden = !isBackButtonVisible
        actionButton.isHidden = !isActionButtonVisible
    }
    @objc func didBackButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    @objc func keyboardWillShow(_ notification: Notification) {
        let keyboardisShowing = view.frame.origin.y == 0
        if keyboardisShowing {
            UIView.animate(withDuration: 0.3) {
                self.actionButtonBottomConstraints?.constant = self.layoutContraints
                self.view.layoutIfNeeded()
            }
        }
    }
    @objc func keyboardWillHidden(_ notification: Notification) {
        let keyboardIsHidden = view.frame.origin.y == 0
        if keyboardIsHidden {
            UIView.animate(withDuration: 0.3) {
                self.actionButtonBottomConstraints?.constant = -25
                self.view.layoutIfNeeded()
            }
        }
    }
}
