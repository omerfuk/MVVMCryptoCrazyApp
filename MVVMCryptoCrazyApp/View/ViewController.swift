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
    
    var colorArray = [UIColor]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        self.colorArray = [
            
            UIColor(red: 75/255, green: 17/255, blue: 170/255, alpha: 1.0),
            UIColor(red: 15/255, green: 32/255, blue: 170/255, alpha: 1.0),
            UIColor(red: 34/255, green: 150/255, blue: 43/255, alpha: 1.0),
            UIColor(red: 58/255, green: 44/255, blue: 32/255, alpha: 1.0),
            UIColor(red: 76/255, green: 53/255, blue: 170/255, alpha: 1.0),
            UIColor(red: 23/255, green: 21/255, blue: 170/255, alpha: 1.0)
        
        
        ]

        
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
        cell.backgroundColor = self.colorArray[indexPath.row % 6]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 6
    }
}
