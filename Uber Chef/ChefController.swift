//
//  ChefController.swift
//  Uber Chef
//
//  Created by Aleksander Stefanovic on 2017-09-06.
//  Copyright © 2017 Aleksander Stefanovic. All rights reserved.
//

import UIKit
import MessageUI

class ChefController: UIViewController,  MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var chefName: UILabel!
    @IBOutlet weak var chefPhone: UILabel!
    @IBOutlet weak var chefEmail: UILabel!

    var chefNameStr = ""
    var chefPhoneStr = ""
    var chefEmailStr = ""
    
    @IBAction func callChef(_ sender: Any) {
        print("Calling chef");
        if let url = URL(string: "telprompt://1-"+chefPhoneStr), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        else {
            self.showPhoneCallFailed();
        }
    }
    
    @IBAction func emailChef(_ sender: Any) {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients([chefEmailStr])
        mailComposerVC.setSubject("Chef Request")
        mailComposerVC.setMessageBody("Someone is requesting immediate chef cooking skills", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    func showPhoneCallFailed () {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Make Call", message: "Your device could not send make the call.  Please check your connection and phone configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate Method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chefName.text = chefNameStr
        chefPhone.text = chefPhoneStr
        chefEmail.text = chefEmailStr

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
