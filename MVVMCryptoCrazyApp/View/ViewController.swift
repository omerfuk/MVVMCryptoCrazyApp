//
//  ViewController.swift
//  MVVMCryptoCrazyApp
//
//  Created by Ömer Faruk Kılıçaslan on 5.07.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let url = URL(string: "https://api.nomics.com/v1/currencies/ticker?key=b760370c98bdc091cc18193a60b69598e3d12ae1")!
        
        WebService().downloadCurrencies(url: url) { cryptos in
            
            if let cryptos = cryptos {
                
               
            }
        }

    }


}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CryptoTableViewCell
        
        
        return cell
    }
}
