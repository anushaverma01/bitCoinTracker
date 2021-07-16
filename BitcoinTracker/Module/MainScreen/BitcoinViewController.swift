//
//  BitcoinViewController.swift
//  BitcoinTracker
//
//  Created by Anusha Verma on 13/07/21.
//

import UIKit

class BitcoinViewController: UIViewController {
    private var viewModel: BitcoinViewModel
    private var xibName = "BitcoinViewController"
   
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!{
        didSet{
            pickerView.setValue(UIColor.black, forKeyPath: "textColor")
        }
    }
    
    init() {
        viewModel = BitcoinViewModel()
        super.init(nibName: xibName, bundle: nil)
        viewModel.viewRouter = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        pickerView.delegate = self
        // Do any additional setup after loading the view.
    }

    func bindViewModel()  {
        viewModel.responseData.bindAndFire{ [weak self] (data) in
            //load picker view.
            DispatchQueue.main.async {
                self?.pickerView.reloadAllComponents()
            }
        }
    }
}
extension BitcoinViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.responseData.value?.bpi.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        priceLabel.text = String(viewModel.getRowTitle(row: row).rate_float ?? 0.0)
        return viewModel.getRowTitle(row: row).code
    }
    
}
extension BitcoinViewController: ErrorRoutable {
    func showError(message: String) {
        self.showAlert(title: title ?? "Error", message: message)
    }
}
