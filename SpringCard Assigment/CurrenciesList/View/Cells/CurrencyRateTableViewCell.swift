//
//  CurrencyRateTableViewCell.swift
//  SpringCard Assigment
//
//  Created by Mina Wefky on 01/03/2022.
//

import UIKit

class CurrencyRateTableViewCell: UITableViewCell {

    @IBOutlet weak var currencySymbol: UILabel!
    @IBOutlet weak var dateStamp: UILabel!
    @IBOutlet weak var currencyRate: UILabel!
    
    var currency: CurrencyRatesModelDTO? {
        didSet {
            currencySymbol.text = currency?.currencySymbol ?? ""
            currencyRate.text = "\(currency?.currencyRate ?? 0.0)"
            dateStamp.text = currency?.formatedDate ?? ""
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
