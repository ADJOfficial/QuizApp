//
//  ViewController.swift
//  QuizApp
//
//  Created by Arsalan Daud on 16/09/2024.
//

import UIKit

class QuizViewController: BaseViewController {
    private let quizView = GradientView()
    private let subjectName = Label(text: "", textFont: .bold(ofSize: 25))
    private let subjectTotalQuestion = Label(text: "", textFont: .regular(ofSize: 18))
    private let subjectQuizTime = Label(text: "", textFont: .regular(ofSize: 18))
    private let subjectQuestion = Label(text: "", textFont: .bold(ofSize: 18))
    private let startQuizButton = Button(setTitle: "Start Quiz")
    private let selectSubject = Button(backgroundColor: .clear, setTitle: "Select Subject", setTitleColor: .systemBlue)

    private let firstOption = SystemImageButton(image: UIImage(systemName: "circle"), setTitle: "", setTitleColor: .black)
    private let secondOption = SystemImageButton(image: UIImage(systemName: "circle"), setTitle: "", setTitleColor: .black)
    private let thirdOption = SystemImageButton(image: UIImage(systemName: "circle"), setTitle: "", setTitleColor: .black)
    private let fourthOption = SystemImageButton(image: UIImage(systemName: "circle"), setTitle: "", setTitleColor: .black)
    
    private let quizStatus = Label(text: "")
    
    private let quizViewModel = QuizViewModel()
    private var currentQuestionIndex = 0
    private var correctAnswersCount = 0
    private var isQuizStarted = false
    private var selectedSubject: Subject?
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
        showNextQuestion()
        hideAllOptionsButton()
    }
    override func setupViews() {
        super.setupViews()
        view.addSubview(selectSubject)
        view.addSubview(quizView)
        quizView.addSubview(subjectName)
        quizView.addSubview(subjectTotalQuestion)
        quizView.addSubview(subjectQuizTime)
        quizView.addSubview(subjectQuestion)
        quizView.addSubview(firstOption)
        quizView.addSubview(secondOption)
        quizView.addSubview(thirdOption)
        quizView.addSubview(fourthOption)
        quizView.addSubview(quizStatus)
        view.addSubview(startQuizButton)
        
        NSLayoutConstraint.activate([
            selectSubject.heightAnchor.constraint(equalToConstant: 50.autoSized),
            selectSubject.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25.autoSized),
            selectSubject.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25.widthRatio),
            
            quizView.heightAnchor.constraint(equalToConstant: 400.autoSized),
            quizView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            quizView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10.widthRatio),
            quizView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10.widthRatio),
            
            subjectName.topAnchor.constraint(equalTo: quizView.topAnchor, constant: 25.autoSized),
            subjectName.centerXAnchor.constraint(equalTo: quizView.centerXAnchor),
            
            quizStatus.topAnchor.constraint(equalTo: subjectName.bottomAnchor, constant: 25.autoSized),
            quizStatus.centerXAnchor.constraint(equalTo: quizView.centerXAnchor),
        
            subjectTotalQuestion.centerYAnchor.constraint(equalTo: quizView.centerYAnchor),
            subjectTotalQuestion.leadingAnchor.constraint(equalTo: quizView.leadingAnchor, constant: 25.widthRatio),
            subjectTotalQuestion.trailingAnchor.constraint(equalTo: quizView.trailingAnchor, constant: -25.widthRatio),

            subjectQuizTime.topAnchor.constraint(equalTo: subjectTotalQuestion.bottomAnchor, constant: 25.autoSized),
            subjectQuizTime.leadingAnchor.constraint(equalTo: quizView.leadingAnchor, constant: 25.widthRatio),
            subjectQuizTime.trailingAnchor.constraint(equalTo: quizView.trailingAnchor, constant: -25.widthRatio),
            
            subjectQuestion.topAnchor.constraint(equalTo: subjectName.bottomAnchor, constant: 25.autoSized),
            subjectQuestion.leadingAnchor.constraint(equalTo: quizView.leadingAnchor, constant: 10.widthRatio),
            subjectQuestion.trailingAnchor.constraint(equalTo: quizView.trailingAnchor, constant: -25.widthRatio),

            firstOption.topAnchor.constraint(equalTo: subjectQuestion.bottomAnchor, constant: 25.autoSized),
            firstOption.leadingAnchor.constraint(equalTo: quizView.leadingAnchor, constant: 25.widthRatio),
            
            secondOption.topAnchor.constraint(equalTo: firstOption.bottomAnchor, constant: 25.autoSized),
            secondOption.leadingAnchor.constraint(equalTo: quizView.leadingAnchor, constant: 25.widthRatio),
            
            thirdOption.topAnchor.constraint(equalTo: secondOption.bottomAnchor, constant: 25.autoSized),
            thirdOption.leadingAnchor.constraint(equalTo: quizView.leadingAnchor, constant: 25.widthRatio),
            
            fourthOption.topAnchor.constraint(equalTo: thirdOption.bottomAnchor, constant: 25.autoSized),
            fourthOption.leadingAnchor.constraint(equalTo: quizView.leadingAnchor, constant: 25.widthRatio),
            
            startQuizButton.widthAnchor.constraint(equalToConstant: 150.widthRatio),
            startQuizButton.heightAnchor.constraint(equalToConstant: 50.autoSized),
            startQuizButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startQuizButton.bottomAnchor.constraint(equalTo: quizView.bottomAnchor, constant: -10.autoSized),
        ])
    }
    override func addTargets() {
        super.addTargets()
        startQuizButton.addTarget(self, action: #selector(didStartQuizButtonTapped), for: .touchUpInside)
        firstOption.addTarget(self, action: #selector(didTappedRadioButton), for: .touchUpInside)
        secondOption.addTarget(self, action: #selector(didTappedRadioButton), for: .touchUpInside)
        thirdOption.addTarget(self, action: #selector(didTappedRadioButton), for: .touchUpInside)
        fourthOption.addTarget(self, action: #selector(didTappedRadioButton), for: .touchUpInside)
        
    }
    
    // MARK: For DropDown To Select Subject
    private func selectQuizSubject() {
        let action = { (action: UIAction) in
            print(action.title)
            self.selectSubject.setTitle(action.title, for: .normal)
            
            if let selectedSubject = subjects.first(where: { $0.name == action.title }) {
                self.selectedSubject = selectedSubject
                let subjectName = selectedSubject.name
                let totalQuestions = selectedSubject.questions.count
                let quizTime = selectedSubject.time
                self.subjectName.text = subjectName
                self.subjectTotalQuestion.text = "Number of Questions : \(totalQuestions)"
                self.subjectQuizTime.text = "Total Time Allotted : \(quizTime)"
            }
        }
        for subject in subjects {
            menuItem.append(UIAction(title: subject.name, handler: action))
        }
        selectSubject.menu = UIMenu(title: "Select Subject", options: .displayInline, children: menuItem)
        selectSubject.showsMenuAsPrimaryAction = true
        selectSubject.changesSelectionAsPrimaryAction = false
    }
    // MARK: For Subject Next Question
    private func showNextQuestion() {
        quizViewModel.showNextQuestion(onNextQuestion: { nextQuestion in
            self.subjectQuestion.text = nextQuestion
        })
    }
    // MARK: For Subject Question Options
    private func showQuestionOptions(for question: Question) {
        let options = question.option
         let optionButtons = [firstOption, secondOption, thirdOption, fourthOption]
         
         // Hide all buttons initially
        optionButtons.forEach { $0.isHidden = true }

         for (index, option) in options.enumerated() {
             if index < optionButtons.count {
                 let button = optionButtons[index]
                 button.setTitle("  \(option.text)", for: .normal)
                 button.isHidden = false
                 button.tag = index
                 button.addTarget(self, action: #selector(didQuizFinished), for: .touchUpInside)
             }
         }
    }
    private func hideAllOptionsButton() {
        let options = [firstOption,secondOption,thirdOption,fourthOption,quizStatus]
        options.forEach { $0.isHidden = true }
    }
    private func showAllOptionsButton() {
        let options = [firstOption,secondOption,thirdOption,fourthOption]
        options.forEach { $0.isHidden = false }
    }
    private func calculatePercentage() -> Int {
        guard let totalQuestions = selectedSubject?.questions.count else {
            return 0
        }
        let percentage = (correctAnswersCount * 100) / (totalQuestions)
        return percentage
    }
    // MARK: For Start Quiz and Show 1st Question
    @objc func didStartQuizButtonTapped() {
        if !isQuizStarted {
            quizViewModel.startQuiz { questionText in
                self.updateUILabelText(text: questionText)
                self.startQuizButton.setTitle("Next Question", for: .normal)
                self.isQuizStarted = true
            }
        } else {
            showNextQuestion()
        }
    }
    @objc func didQuizFinished(_ sender: UIButton) {
        guard let subject = selectedSubject else {
            return
        }
        let currentQuestion = subject.questions[currentQuestionIndex]
        let selectedOption = currentQuestion.option[sender.tag]
        if selectedOption.isCorrect {
            correctAnswersCount += 1
        }
        showNextQuestion()
        if calculatePercentage() >= 50 {
            quizStatus.text = "Congratulation"
            quizStatus.textColor = .systemGreen
        } else {
            quizStatus.text = "Better Luck Next Time"
            quizStatus.textColor = .systemRed
        }
    }
    @objc func didTappedRadioButton(_ sender: UIButton) {
        firstOption.isSelected = false
        secondOption.isSelected = false
        thirdOption.isSelected = false
        fourthOption.isSelected = false
        
        sender.isSelected = true
        firstOption.setImage(UIImage(systemName: firstOption.isSelected ? "circle.fill" : "circle"), for: .normal)
        secondOption.setImage(UIImage(systemName: secondOption.isSelected ? "circle.fill" : "circle"), for: .normal)
        thirdOption.setImage(UIImage(systemName: thirdOption.isSelected ? "circle.fill" : "circle"), for: .normal)
        fourthOption.setImage(UIImage(systemName: fourthOption.isSelected ? "circle.fill" : "circle"), for: .normal)
        
    }
    
    
    private func updateUILabelText(text: String) {
        self.subjectQuestion.text = text
        self.subjectTotalQuestion.isHidden = true
        self.subjectQuizTime.isHidden = true
    }
}
#Preview {
    QuizViewController(subjectRecords: Subject(name: "", questions: [], time: 0))
}




//
//    guard let subject = selectedSubject else {
//        return
//    }
//    currentQuestionIndex += 1
//    if currentQuestionIndex < subject.questions.count {
//        let nextQuestion = subject.questions[currentQuestionIndex]
//        self.subjectQuestion.text = nextQuestion.text
//        showQuestionOptions(for: nextQuestion)
//    } else {
////            self.subjectQuestion.text = "Quiz Completed! You answered \(correctAnswersCount) out of \(subject.questions.count) questions Correctly, Your percentage is \(calculatePercentage())"
//        hideAllOptionsButton()
//        quizStatus.isHidden = false
//        startQuizButton.isHidden = true
//    }
//}



//guard let subject = selectedSubject else {
//    return
//}
//if !isQuizStarted {
//    if let firstQuestion = subject.questions.first {
//        self.subjectQuestion.text = firstQuestion.text
//        self.subjectTotalQuestion.isHidden = true
//        self.subjectQuizTime.isHidden = true
//        showQuestionOptions(for: firstQuestion)
//        showAllOptionsButton()
//        startQuizButton.setTitle("Next Question", for: .normal)
//        isQuizStarted = true
//    } else {
//        self.subjectQuestion.text = "\(subject.name) has no question yet!"
//    }
//} else {
//    showNextQuestion()
//}
