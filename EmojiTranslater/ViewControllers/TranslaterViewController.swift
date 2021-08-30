//
//  ViewController.swift
//  EmojiTranslater
//
//  Created by Антон Бобрышев on 30.08.2021.
//

import UIKit

class TranslaterViewController: UIViewController {

    @IBOutlet weak var textForTranslation: UITextView!
    @IBOutlet weak var translatedText: UITextView!
    @IBOutlet weak var translateButtonLabel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }

    
    @IBAction func translateButton() {
        
    }
    
    private func setupView() {
        
        textForTranslation.layer.cornerRadius = 10
        translatedText.layer.cornerRadius = 10
        translateButtonLabel.layer.cornerRadius = 10
        translateButtonLabel.backgroundColor = .white
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}


extension TranslaterViewController {
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height / 3
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}
