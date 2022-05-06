//
//  CreditScoreViewController.swift
//  CreditWise
//
//  Created by Edward Seshoka on 2022/05/05.
//

import UIKit

class CreditScoreViewController: UIViewController {
    
    @IBOutlet weak var creditScoreView: CreditScoreView!
    
    var viewModel: CreditScoreViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Dashboard"
        
        self.styleNavigationBar()
        update()
        creditScoreView.startAnimating()
        viewModel?.fetchCreditScore()
    }
}

private extension CreditScoreViewController {
    func update() {
        if !isViewLoaded {
            return
        }
        
        setupCreditScore()
        setupNoInternetMessage()
        setupGeneralMessage()
    }
    
    func setupCreditScore() {
        guard let viewModel = viewModel else {
            return
        }
        
        viewModel.creditScore?.bindAndFire { [unowned self] in
            self.creditScoreView.stopAnimating()
            self.creditScoreView.setText(with: $0)
        }
    }
    
    func setupNoInternetMessage() {
        guard let viewModel = viewModel else {
            return
        }
        
        viewModel.noInternetErrorMessage?.bindAndFire { [unowned self] in
            self.creditScoreView.stopAnimating()
            
            if let message = $0 {
                let alert = UIAlertController(title: "Internet connectivity", message: message, preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: "Try again?", style: UIAlertAction.Style.default, handler: { action in
                    switch action.style{
                    case .default:
                        self.creditScoreView.startAnimating()
                        viewModel.creditScore?.value = nil
                        viewModel.fetchCreditScore()
                    default:
                        break
                    }
                }))
                
                alert.addAction(UIAlertAction(title: "Got it", style: UIAlertAction.Style.default, handler: { action in
                    switch action.style{
                    case .cancel:
                        print("default")
                    default:
                        break
                    }
                }))
                
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func setupGeneralMessage() {
        guard let viewModel = viewModel else {
            return
        }
        
        viewModel.generalErrorMessage?.bindAndFire { [unowned self] in
            self.creditScoreView.stopAnimating()
            
            if let message = $0 {
                let alert = UIAlertController(title: "Something went wrong", message: message, preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}

