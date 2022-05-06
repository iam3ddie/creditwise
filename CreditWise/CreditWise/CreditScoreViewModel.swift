//
//  CreditScoreViewModel.swift
//  CreditWise
//
//  Created by Edward Seshoka on 2022/05/05.
//

import Foundation

protocol CreditScoreViewModel {
    func fetchCreditScore()
    var creditScore: Dynamic<MultilineProvider?>? { get }
    var noInternetErrorMessage: Dynamic<String?>? { get }
    var generalErrorMessage: Dynamic<String?>? { get }
}

class CreditScoreViewModelImpplementation: CreditScoreViewModel {
    let creditValuesRepository: CreditValuesRepository = CreditValuesRepositoryImplementation()
    
    let creditScore: Dynamic<MultilineProvider?>? = Dynamic(nil)
    let noInternetErrorMessage: Dynamic<String?>? = Dynamic(nil)
    let generalErrorMessage: Dynamic<String?>? = Dynamic(nil)
    
    func fetchCreditScore() {
        creditValuesRepository.fetchCreditValues { creditValues, error in
            DispatchQueue.main.async() {
                if let error = error {
                    self.handle(error: error)
                }
                
                if let creditScore = creditValues?.creditReportInfo.score {
                    self.creditScore?.value = MultilineProvider(line1: "Your credit score is\n", line2: "\(creditScore)\n", line3: "out of 700")
                }
            }
        }
    }
    
    func handle(error: NetworkClientError) {
        switch error {
        case .notConnectedToTheInternet:
            self.noInternetErrorMessage?.value = "It seems you are not connected to the internet.\n\nPlease check your network settings and try again."
        case .parseError, .general(_):
            self.generalErrorMessage?.value = "We are really sorry but we are unable to get your score at this time.\n\nPlease try again later."
        }
        self.creditScore?.value = MultilineProvider(line1: "Your credit score is\n", line2: "???\n", line3: "out of 700")
    }
}
