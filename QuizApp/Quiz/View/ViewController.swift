//
//  ViewController.swift
//  QuizApp
//
//  Created by Arsalan Daud on 16/09/2024.
//

import UIKit

class ViewController: BaseViewController {
    private let quizView = GradientView()
    private let subjectQuestion = Label(text: "")
    private let questionOption = Label(text: "", textFont: .regular(ofSize: 18))
    private let startQuiz = Button(setTitle: "Start Quiz")
    
    private let selectSubject = Button(backgroundColor: .clear, setTitle: "Select Subject", setTitleColor: .systemBlue)
    private let subjectRecords: Subject
    private var menuItem: [UIMenuElement] = []
    
    init(subjectRecords: Subject) {
        self.subjectRecords = subjectRecords
        super.init(screenTitle: "Quiz App", isBackButtonVisible: false, isActionButtonVisible: false)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectQuizSubject()
    }
    override func setupViews() {
        super.setupViews()
        view.addSubview(selectSubject)
        view.addSubview(quizView)
        quizView.addSubview(subjectQuestion)
        quizView.addSubview(questionOption)
        view.addSubview(startQuiz)
        
        NSLayoutConstraint.activate([
            selectSubject.heightAnchor.constraint(equalToConstant: 50),
            selectSubject.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25),
            selectSubject.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            
            quizView.heightAnchor.constraint(equalToConstant: 350),
            quizView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            quizView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            quizView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            subjectQuestion.topAnchor.constraint(equalTo: quizView.topAnchor, constant: 25),
            subjectQuestion.leadingAnchor.constraint(equalTo: quizView.leadingAnchor, constant: 25),
            subjectQuestion.trailingAnchor.constraint(equalTo: quizView.trailingAnchor, constant: -25),

            questionOption.topAnchor.constraint(equalTo: subjectQuestion.topAnchor, constant: 25),
            questionOption.leadingAnchor.constraint(equalTo: quizView.leadingAnchor, constant: 25),
            questionOption.trailingAnchor.constraint(equalTo: quizView.trailingAnchor, constant: -25),

            startQuiz.widthAnchor.constraint(equalToConstant: 150),
            startQuiz.heightAnchor.constraint(equalToConstant: 50),
            startQuiz.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startQuiz.topAnchor.constraint(equalTo: quizView.bottomAnchor, constant: 25),
        ])
    }

    private func selectQuizSubject() {
        let action = { (action: UIAction) in
            print(action.title)
            self.selectSubject.setTitle(action.title, for: .normal)
            
            if let selectedSubject = subjects.first(where: { $0.name == action.title }) {
                let firstQuestion = selectedSubject.questions.first?.text ?? "No Question"
                self.subjectQuestion.text = "\(firstQuestion)"
            }
        }
        for subject in subjects {
            menuItem.append(UIAction(title: subject.name, handler: action))
        }
        selectSubject.menu = UIMenu(title: "", options: .displayInline, children: menuItem)
        selectSubject.showsMenuAsPrimaryAction = true
        selectSubject.changesSelectionAsPrimaryAction = false
    }
}
#Preview {
    ViewController(subjectRecords: Subject(name: "", questions: []))
}
