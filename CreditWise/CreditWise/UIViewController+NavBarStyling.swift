//
//  UIViewController+NavBarStyling.swift
//  CreditWise
//
//  Created by Edward Seshoka on 2022/05/06.
//

import Foundation
import UIKit

extension UIViewController {
    func styleNavigationBar() {
        let navigationBar = self.navigationController?.navigationBar
        
        navigationBar?.isHidden = false
        navigationBar?.isTranslucent = false
        navigationBar?.backgroundColor = UIColor.black
        navigationBar?.barStyle = UIBarStyle.black
        navigationBar?.tintColor = UIColor.white
        navigationBar?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}
