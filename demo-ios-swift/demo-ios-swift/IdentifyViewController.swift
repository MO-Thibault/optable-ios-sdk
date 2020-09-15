//
//  IdentifyViewController.swift
//  demo-ios-swift
//
//  Created by Bosko Milekic on 2020-08-06.
//  Copyright © 2020 Bosko Milekic. All rights reserved.
//

import UIKit

class IdentifyViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var identifyInput: UITextField!
    @IBOutlet weak var identifyButton: UIButton!
    @IBOutlet weak var identifyIDFA: UISwitch!
    @IBOutlet weak var identifyOutput: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: Actions
    
    // dispatchIdentify() is the action invoked on a click on the "Identify" UIButton in our demo app. It initiates
    // a call to the OptableSDK.identify() API and prints debugging information to the UI and debug console.
    @IBAction func dispatchIdentify(_ sender: UIButton) {
        do {
            let email = identifyInput.text! as String
            let aaid = identifyIDFA.isOn as Bool

            identifyOutput.text = "Calling /identify API with:\n\n"
            if (email != "") {
                identifyOutput.text += "Email: " + email + "\n"
            }
            identifyOutput.text += "IDFA: " + String(aaid) + "\n"

            try OPTABLE!.identify(email: email, aaid: aaid) { result in
                switch result {
                case .success(let response):
                    print("[OptableSDK] Success on /identify API call: response.statusCode = \(response.statusCode)")
                    DispatchQueue.main.async {
                        self.identifyOutput.text += "\nSuccess."
                    }

                case .failure(let error):
                    print("[OptableSDK] Error on /identify API call: \(error)")
                    DispatchQueue.main.async {
                        self.identifyOutput.text += "\nError: \(error)"
                    }
                }
            }

        } catch {
            print("[OptableSDK] Exception: \(error)")
            identifyOutput.text += "EXCEPTION: \(error)"
        }
    }
}
