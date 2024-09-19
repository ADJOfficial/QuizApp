//
//  QuizViewModel.swift
//  QuizApp
//
//  Created by Arsalan Daud on 19/09/2024.
//

class QuizViewModel {
    
    private var selectedSubject: Subject?
    private var currentQuestionIndex: Int = 0
    private var isQuizStarted = false
    
    func showNextQuestion(onNextQuestion: ((String) -> Void)) {
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
    func startQuiz(questionText: ((String) -> Void)) {
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
}
