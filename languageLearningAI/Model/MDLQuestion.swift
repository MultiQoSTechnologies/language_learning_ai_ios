//
//	MDLQuestion.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct MDLQuestions : Codable {

    let quiz : [Quiz]?


    enum CodingKeys: String, CodingKey {
        case quiz = "quiz"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        quiz = try values.decodeIfPresent([Quiz].self, forKey: .quiz)
    }

}

struct Quiz : Codable {

    let answer : String?
    let options : [Option]?
    let question : String?
    var selectedAns: String = ""


    enum CodingKeys: String, CodingKey {
        case answer = "answer"
        case options = "options"
        case question = "question"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        answer = try values.decodeIfPresent(String.self, forKey: .answer)
        options = try values.decodeIfPresent([Option].self, forKey: .options)
        question = try values.decodeIfPresent(String.self, forKey: .question)
    }

}

struct Option : Codable {

    let a : String?
    let b : String?
    let c : String?
    let d : String?


    enum CodingKeys: String, CodingKey {
        case a = "a"
        case b = "b"
        case c = "c"
        case d = "d"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        a = try values.decodeIfPresent(String.self, forKey: .a)
        b = try values.decodeIfPresent(String.self, forKey: .b)
        c = try values.decodeIfPresent(String.self, forKey: .c)
        d = try values.decodeIfPresent(String.self, forKey: .d)
    }

}
