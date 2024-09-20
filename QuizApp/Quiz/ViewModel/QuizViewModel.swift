//
//  QuizViewModel.swift
//  QuizApp
//
//  Created by Arsalan Daud on 19/09/2024.
//

class QuizViewModel {
    
    func startQuiz(selectedSubject: Subject? ,isQuizStarted: inout Bool, questionText: ((String) -> Void)) {
        guard let subject = selectedSubject else {
            return
        }
        if !isQuizStarted {
            if let firstQuestion = subject.questions.first {
                questionText(firstQuestion.text)
                isQuizStarted = true
            } else {
                questionText("\(subject.name) has no question yet!")
            }
        }
    }
    func showNextQuestion(selectedSubject: Subject? , currentQuestionIndex: inout Int, onNextQuestion: ((String) -> Void)) {
        guard let subject = selectedSubject else {
            return
        }
        if currentQuestionIndex < subject.questions.count {
            let nextQuestion = subject.questions[currentQuestionIndex]
            onNextQuestion(nextQuestion.text)
            currentQuestionIndex += 1
        } else {
            let message = "Quiz Completed! You answered  out of \(subject.questions.count) questions Correctly, Your percentage is"
            onNextQuestion(message)
        }
    }
    func showQuestionOptions(for question: Question, buttons: (([UIButton]) -> Void)) {
        let options = question.option
        let optionButtons = buttons([])
        optionButtons.forEach { $0.isHidden = true }

         for (index, option) in options.enumerated() {
             if index < optionButtons.count {
                 let button = optionButtons[index]
                 button.setTitle("  \(option.text)", for: .normal)
                 button.isHidden = false
                 button.tag = index
//                 button.addTarget(self, action: #selector(didQuizFinished), for: .touchUpInside)
             }
         }
    }
    func didQuizFinished(selectedSubject: Subject?, currentQuestionIndex: Int, correctAnswersCount: inout Int, sender: () -> Void) {
        guard let subject = selectedSubject else {
            return
        }
        let currentQuestion = subject.questions[currentQuestionIndex]
        let selectedOption = currentQuestion.option.sender()
        if selectedOption.isCorrect {
            correctAnswersCount += 1
        }
    }
}
