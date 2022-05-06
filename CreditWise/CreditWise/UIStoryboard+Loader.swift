//
//  UIStoryboard+Loader.swift
//  CreditWise
//
//  Created by Edward Seshoka on 2022/05/05.
//

import UIKit

fileprivate enum Storyboard : String {
    case creditScore = "CreditScore"
}

fileprivate extension UIStoryboard {
    static func load(from storyboard: Storyboard, identifier: String) -> UIViewController {
        let uiStoryboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
        return uiStoryboard.instantiateViewController(withIdentifier: identifier)
    }
}

extension UIStoryboard {
    static func creditScoreViewController() -> CreditScoreViewController {
        return load(from: .creditScore, identifier: "CreditScoreViewController") as! CreditScoreViewController
    }
}
