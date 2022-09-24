//
//  ViewController.swift
//  Aisle
//
//  Created by Gokul A S on 22/09/22.
//

import UIKit

class NumberVerificationViewController: UIViewController {
    
    @IBOutlet weak var countryCodeTextField: NumberTextField!
    @IBOutlet weak var phoneNumberTextField: NumberTextField!
    
    let networkManager = NetworkManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func continueButtonTapped(_ sender: Any) {
        self.verifyPhoneNtmber { phoneNumber in
            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: Constants.main, bundle: nil)
                if let otpVerificationVC = storyboard.instantiateViewController(withIdentifier: Constants.otpVerificationVC) as? OTPVerificationViewController {
                    otpVerificationVC.phoneNumber = phoneNumber
                    otpVerificationVC.modalPresentationStyle = .fullScreen
                    self.present(otpVerificationVC, animated: true)
                }
            }
        }
    }
    
    func verifyPhoneNtmber(completion: @escaping (_ phoneNumber: String) -> ()) {
        if let countrycode = self.countryCodeTextField.text, let phoneNumber = self.phoneNumberTextField.text {
            if countrycode != "" && phoneNumber != "" {
                let parameter = [Constants.number : "\(countrycode)\(phoneNumber)"]
                networkManager.fetchData(endPoint: Constants.phone_number_login, headers: nil, parameters: parameter, httpMethod: .post) { data, status, error in
                    if let data = data {
                        print(self.networkManager.dataToJSON(data: data) ?? "")
                        completion("\(countrycode) \(phoneNumber)")
                    }
                }
            }
        }
    }
}

