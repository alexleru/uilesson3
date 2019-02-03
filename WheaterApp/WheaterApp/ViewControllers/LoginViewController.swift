//
//  LoginViewController.swift
//  WheaterApp
//
//  Created by Darya Bodaykina on 23.01.2019.
//  Copyright © 2019 alexleru. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Variables
    
    @IBOutlet private weak var scrollView: UIScrollView?
    
    @IBOutlet private weak var labelApp: UILabel?
    
    @IBOutlet private weak var labelLogin: UILabel?
    @IBOutlet private weak var textEditLogin: UITextField?

    @IBOutlet private weak var labelPass: UILabel?
    @IBOutlet private weak var textEditPass: UITextField?
    
    @IBOutlet private weak var buttonLogIn: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textEditLogin?.text = "123"
        self.textEditPass?.text = "456"

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Notification
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Подписываемся на два уведомления: одно приходит при появлении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        // Второе -- когда она пропадает
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // Когда клавиатура появляется
    @objc func keyboardWasShown(notification: Notification) {
        
        // Получаем размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        
        // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    //Когда клавиатура исчезает
    @objc func keyboardWillBeHidden(notification: Notification) {
        // Устанавливаем отступ внизу UIScrollView, равный 0
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    // MARK: - Action
    
    @IBAction func buttonLogInAction() {
        
        guard let loginText = self.textEditLogin?.text else {
            print("Login is empty!")
            return
        }
        
        guard let passText = self.textEditPass?.text else {
            print("Pass is empty!")
            return
        }
        
        if loginText == "123" && passText == "456" {
            print("Correct auth data!")
            self.performSegue(withIdentifier: "openApp", sender: nil)
        } else {
            print("Incorrect login and password! Check login and password")
            self.errorAlertAction()
        }
        
    }
    
    @IBAction func errorAlertAction(){
        let errorAlertController = UIAlertController(title: "Error", message: "Incorrect login and password! Check login and password", preferredStyle: .alert)
        
        let alertCancelAction = UIAlertAction(title: "Cancel", style: .cancel)  {(action: UIAlertAction) in print("AclertIn")}
        errorAlertController.addAction(alertCancelAction)
        
        self.present(errorAlertController, animated: true, completion: nil)
    }
    
    
    
    @IBAction func closeKeyboardAction() {
        self.view.endEditing(true)
    }

}
