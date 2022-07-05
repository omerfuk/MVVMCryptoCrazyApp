//
//  ViewController.swift
//  MVVMCryptoCrazyApp
//
//  Created by Ömer Faruk Kılıçaslan on 5.07.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var cryptoListViewModel: CryptoListViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        getData()
        
        //NOTHING
//        let myString = "Zzzz"
//        myString.printMyName()
 

    }
    
    func getData() {
        let url = URL(string: "https://api.nomics.com/v1/currencies/ticker?key=b760370c98bdc091cc18193a60b69598e3d12ae1")!
        
        WebService().downloadCurrencies(url: url) { cryptos in
            
            if let cryptos = cryptos {
                
                self.cryptoListViewModel = CryptoListViewModel(cryptoCurrencyList: cryptos)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
               
            }
        }
    }


}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return self.cryptoListViewModel == nil ? 0 : self.cryptoListViewModel!.numberOfRowsInSection()
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CryptoTableViewCell
        let cryptoViewModel = self.cryptoListViewModel?.cryptoAtIndex(indexPath.row)
        
        cell.priceText.text = cryptoViewModel?.price
        cell.currencyText.text = cryptoViewModel?.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}
