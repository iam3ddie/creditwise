//
//  View.swift
//  CreditWise
//
//  Created by Edward Seshoka on 2022/05/06.
//

import UIKit

class View: UIView {

    init() {
        super.init(frame: .zero)

        self.update()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.update()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.update()
    }

    func update() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
