//
//  ViewController.swift
//  EmojiTranslater
//
//  Created by Антон Бобрышев on 30.08.2021.
//

import UIKit

class TranslatorViewController: UIViewController {
    
    @IBOutlet weak var textForTranslation: UITextView!
    @IBOutlet weak var translatedText: UITextView!
    
    @IBOutlet weak var translateButtonLabel: UIButton!
    
    var translation = TranslaterManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        textForTranslation.delegate = self
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func translateButton() {
        textViewDidEndEditing(textForTranslation)
        view.endEditing(true)
    
    }
    
    private func setupView() {
        
        textForTranslation.layer.cornerRadius = 10
        translatedText.layer.cornerRadius = 10
        translateButtonLabel.layer.cornerRadius = 10
        translateButtonLabel.backgroundColor = .black
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}


extension TranslatorViewController {
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height / 2
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}

extension TranslatorViewController: UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        guard let text = textView.text else {return}
        var translationResult = ""
        
        for match in translation.getTranslate(text) {
            translationResult += "\(match.emoji)"
        }
        print(translationResult)
        translatedText.text = translationResult
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
