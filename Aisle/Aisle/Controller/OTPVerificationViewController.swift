//
//  OTPVerificationViewController.swift
//  Aisle
//
//  Created by Gokul A S on 23/09/22.
//

import UIKit

class OTPVerificationViewController: UIViewController {

    var phoneNumber: String = ""
    var totalSecond = 60
    var timer:Timer?
    let networkManager = NetworkManager.shared
    
    @IBOutlet weak var otpTextField: NumberTextField!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startTimer()
        self.phoneNumberLabel.text = self.phoneNumber
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func startTimer(){
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
    }
    
    @objc func countdown() {
        var minutes: Int
        var seconds: Int
        
        if self.totalSecond == 1 {
            self.timer?.invalidate()
        }
        self.totalSecond = self.totalSecond - 1
        minutes = (self.totalSecond % 3600) / 60
        seconds = (self.totalSecond % 3600) % 60
        self.timerLabel.text = String(format: "%02d:%02d", minutes, seconds)
    }
    
    @IBAction func editNumberButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func continueButtonAction(_ sender: Any) {
        if self.otpTextField.text != "", let otp = self.otpTextField.text {
            let number = self.phoneNumber.components(separatedBy: .whitespaces).joined()
            self.verifyOTP(phoneNumber: number, otp: otp) { token in
                DispatchQueue.main.async {
                    let storyboard = UIStoryboard(name: Constants.main, bundle: nil)
                    if let notesVC = storyboard.instantiateViewController(withIdentifier: Constants.notesVC) as? NotesViewController {
                        notesVC.token = token
                        notesVC.modalPresentationStyle = .fullScreen
                        self.present(notesVC, animated: true)
                    }
                }
            }
        }
    }
    
    func verifyOTP(phoneNumber: String, otp: String, completion: @escaping (_ token: String) -> ()) {
        let parameters = [Constants.number: phoneNumber, Constants.otp: otp]
        networkManager.fetchData(endPoint: Constants.verify_otp, headers: nil, parameters: parameters, httpMethod: .post) { data, status, error in
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                let token = json?[Constants.token] as? String
                completion(token ?? "")
            }
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
