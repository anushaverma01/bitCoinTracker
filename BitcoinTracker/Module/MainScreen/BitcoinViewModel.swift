//
//  BitcoinViewModel.swift
//  BitcoinTracker
//
//  Created by Anusha Verma on 13/07/21.
//

import Foundation
protocol BitcoinListable {
    var viewRouter: ErrorRoutable? { get set }
    func getCountryListApi()
    var responseData: Dynamic<CoinDesk?>{get}
}
class BitcoinViewModel: BitcoinListable {
    var responseData: Dynamic<CoinDesk?>
    weak var viewRouter: ErrorRoutable?
    
    init() {
       responseData = Dynamic(nil)
        getCountryListApi()
    }
    
    func getCountryListApi() {
        let requestURL = String(format: "https://api.coindesk.com/v1/bpi/currentprice.json")
        let session = URLSession.shared
        var request =  URLRequest(url: URL(string: requestURL)!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "accept")

        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            // Serialize the data into an object
            do {
                let response = try JSONDecoder().decode(CoinDesk.self, from: data!)
                print(response)
                DispatchQueue.main.async {
                    self.responseData.value = response
                }
            }catch let error as NSError {
                print(error.localizedDescription, error.description)
                DispatchQueue.main.async {
                self.viewRouter?.showError(message: error.description)
                }
            }
        })
            task.resume()
    }
    
    func getRowTitle(row: Int) -> Details {
        let currencyArray =  ["EUR","GBP","USD"]
        let key = currencyArray[row]
        return self.responseData.value?.bpi[key] ?? Details()
    }
}
