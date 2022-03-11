//
//  CurrenciesListViewController.swift
//  SpringCard Assigment
//
//  Created by Mina Wefky on 01/03/2022.
//

import UIKit
import RxSwift

class CurrenciesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //MARK: - Outlets
    @IBOutlet weak var CurrenciesTableView: UITableView!
    
    //MARK: - Constants
    let disposeBag = DisposeBag()
    let CurrencyRateIDENTIFIER = "CurrencyRateTableViewCell"
    
    //MARK: - Variables
    var currenciesList: [CurrencyRatesModelDTO]? {
        didSet {
            CurrenciesTableView.reloadData()
        }
    }
    
    var viewModel = CurrenciesListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        viewModel.fetchCurrenciesList()
        setUpVCConfigs()
    }
    
    // MARK: - setup configurations for ViewController
    func setUpVCConfigs(){
        self.title = "Currencies"
        CurrenciesTableView.register(UINib(nibName: CurrencyRateIDENTIFIER, bundle: nil), forCellReuseIdentifier: CurrencyRateIDENTIFIER)
    }
    
    // MARK: - binding View Model
    func bindViewModel() {
        
        viewModel.currencyList.subscribe {[weak self] currencies in
            self?.currenciesList = currencies
        }.disposed(by: disposeBag)

        viewModel.customeError.subscribe {[weak self] err in
            self?.showAlert(with: "Error", message: "Network error")
        }.disposed(by: disposeBag)
    }
    
    func didSelectCurrency(currency: CurrencyRatesModelDTO?) {
        let CurrenciesConverterVC = CurrenciesConverterViewController()
        let bundle = Bundle(for: type(of: CurrenciesConverterVC))
        bundle.loadNibNamed("CurrenciesConverterViewController", owner: CurrenciesConverterVC, options: nil)
        CurrenciesConverterVC.currencyTo = currency
        navigationController?.pushViewController(CurrenciesConverterVC, animated: true)
    }
}


//MARK: - TableView delegates and datasource
extension CurrenciesListViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currenciesList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyRateIDENTIFIER) as! CurrencyRateTableViewCell
        cell.currency = currenciesList?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectCurrency(currency: currenciesList?[indexPath.row])
    }
}
