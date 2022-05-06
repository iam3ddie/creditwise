//
//  CreditValuesModels.swift
//  CreditWise
//
//  Created by Edward Seshoka on 2022/05/05.
//

struct CreditValues: Codable {
    let accountIDVStatus: String
    let creditReportInfo: CreditReportInfo
    let dashboardStatus, personaType: String
    let coachingSummary: CoachingSummary
    let augmentedCreditScore: Int?
}

struct CoachingSummary: Codable {
    let activeTodo, activeChat: Bool
    let numberOfTodoItems, numberOfCompletedTodoItems: Int
    let selected: Bool
}

struct CreditReportInfo: Codable {
    let score, scoreBand: Int
    let clientRef, status: String
    let maxScoreValue, minScoreValue, monthsSinceLastDefaulted: Int
    let hasEverDefaulted: Bool
    let monthsSinceLastDelinquent: Int
    let hasEverBeenDelinquent: Bool
    let percentageCreditUsed, percentageCreditUsedDirectionFlag, changedScore, currentShortTermDebt: Int
    let currentShortTermNonPromotionalDebt, currentShortTermCreditLimit, currentShortTermCreditUtilisation, changeInShortTermDebt: Int
    let currentLongTermDebt, currentLongTermNonPromotionalDebt: Int
    let currentLongTermCreditLimit, currentLongTermCreditUtilisation: Int?
    let changeInLongTermDebt, numPositiveScoreFactors, numNegativeScoreFactors, equifaxScoreBand: Int
    let equifaxScoreBandDescription: String
    let daysUntilNextReport: Int
}
