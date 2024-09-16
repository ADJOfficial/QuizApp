//
//  Subject.swift
//  QuizApp
//
//  Created by Arsalan Daud on 16/09/2024.
//

import Foundation

struct Subject {
    let name: String
    let questions: [Question]
}
let subjects: [Subject] = [
    Subject(name: "Maths", questions: [
        Question(text: "2 + 2 = ", option: [
            Option(text: "10", isCorrect: false),
            Option(text: "2", isCorrect: false),
            Option(text: "4", isCorrect: true),
            Option(text: "6", isCorrect: false)
        ]),
        Question(text: "3 * 9 = ", option: [
            Option(text: "27", isCorrect: true),
            Option(text: "20", isCorrect: false),
            Option(text: "15", isCorrect: false),
            Option(text: "32", isCorrect: false)
        ]),
    ]),
    Subject(name: "Computer", questions: [
        Question(text: "OOP Stands For", option: [
            Option(text: "Object Operating Program", isCorrect: false),
            Option(text: "Object Oriented Programming", isCorrect: true),
            Option(text: "Object Operational Paradian", isCorrect: false),
            Option(text: "Object Optional Program", isCorrect: false),
        ]),
        Question(text: "Swift is an ______ Programming", option: [
            Option(text: "Apple Programming Language", isCorrect: false),
            Option(text: "C++ Programming Language", isCorrect: true),
            Option(text: "OOP Programming Language", isCorrect: false),
            Option(text: "Responsive Programming Language", isCorrect: false),
        ]),
    ])
]
