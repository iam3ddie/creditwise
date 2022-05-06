//
//  CreditScoreView.swift
//  CreditWise
//
//  Created by Edward Seshoka on 2022/05/06.
//

import UIKit

struct MultilineProvider {
    var line1, line2, line3: String
}

class CreditScoreView: View {
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var circularView: UIView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var label: UILabel!
    
    override func update() {
        super.update()
        
        let name = String(describing: type(of: self))
        let nib = UINib(nibName: name, bundle: .main)
        nib.instantiate(withOwner: self, options: nil)
        
        self.addSubview(self.containerView)
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.containerView.topAnchor.constraint(equalTo: self.topAnchor),
            self.containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        setupCircularView()
    }
    
    func startAnimating() {
        indicatorView.startAnimating()
    }
    
    func stopAnimating() {
        indicatorView.stopAnimating()
    }
    
    func setText(with multilineProvider: MultilineProvider?) {
        let attributes = [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Thin", size: 50)!,
                          NSAttributedString.Key.foregroundColor: UIColor.brown]
        let string = NSMutableAttributedString(string:multilineProvider?.line2 ?? "", attributes:attributes)
        
        label.attributedText = NSAttributedString(string: multilineProvider?.line1 ?? "") +
        string + NSAttributedString(string: multilineProvider?.line3 ?? "")
    }
    
    private func setupCircularView() {
        circularView.layer.borderColor = UIColor.black.cgColor
        circularView.layer.borderWidth = 1.0
        circularView.layer.cornerRadius = circularView.frame.size.width/2.0
    }
}
