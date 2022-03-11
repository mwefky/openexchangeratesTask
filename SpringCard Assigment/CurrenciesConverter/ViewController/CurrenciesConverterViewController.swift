//
//  CurrenciesConverterViewController.swift
//  SpringCard Assigment
//
//  Created by Mina Wefky on 09/03/2022.
//

import UIKit
import RxSwift
import RxRelay

class CurrenciesConverterViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - Outlets
    @IBOutlet weak var currencySymbol: UILabel!
    @IBOutlet weak var currencyRate: UILabel!
    @IBOutlet weak var convertValueTF: UITextField!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var totalAmountValue: UILabel!
    @IBOutlet weak var convertBTN: UIButton!
    
    //MARK: - Variables
    var currencyTo: CurrencyRatesModelDTO? {
        didSet {
            updateUI(with: currencyTo)
        }
    }
    var viewModel = CurrenciesConverterViewModel()
    
    //MARK: - Constants
    let disposeBag = DisposeBag()
    
    //MARK: - initializaion
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        initUI()
        setUPTF()
        bindViewModel()
    }
    
    //MARK: - Init UI
    private func initUI() {
        convertBTN.backgroundColor = UIColor(named: "Dark Gray")
        convertBTN.layer.cornerRadius = convertBTN.frame.height / 2
        convertBTN.clipsToBounds = true
    }
    
    private func setUPTF(){
        
        convertValueTF.delegate = self
        
        let convertTFleftLabel = UILabel(frame: CGRect(x: 10,y: 0,width: 60,height: 21))
        convertTFleftLabel.text = "$"
        convertTFleftLabel.textColor = .black

        convertValueTF.leftView = convertTFleftLabel
        convertValueTF.leftViewMode = .always
    }
    
    //MARK: - UpdateUI
    private func updateUI(with currency: CurrencyRatesModelDTO?){
        
        self.title = currency?.currencySymbol ?? ""
        currencySymbol.text = currency?.currencySymbol ?? ""
        currencyRate.text = "\(currency?.currencyRate ?? 0.0)"
        totalAmountLabel.text = "Total Amount"
        totalAmountValue.text = "0"
    }
    
    private func updateAmount(totalAmount: Double?){
        totalAmountValue.text = "\(totalAmount ?? 0.0)"
    }
    
    //MARK: - Actions
    @IBAction func currencyBtnTapped(_ sender: Any) {
        convertValueTF.resignFirstResponder()
        viewModel.convertCurrency(amount: Double(convertValueTF.text ?? "") ?? 0.0, currency: currencyTo)
    }
    
    // MARK: - binding View Model
    func bindViewModel() {
        viewModel.currencyConversionRes.subscribe(onNext: { [weak self] (conversionRes) in
            self?.updateAmount(totalAmount: conversionRes)
        }).disposed(by: disposeBag)
        
        viewModel.customeError.subscribe(onNext: { [weak self] (err) in
            switch err {
            case.noAmount:
                self?.showAlert(with: "Error", message: "Please enter Amount to convert")
            case .networkError:
                self?.showAlert(with: "Error", message: "Network error")
            }
        }).disposed(by: disposeBag)
    }
    
}

extension CurrenciesConverterViewController {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
}
