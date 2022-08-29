//
//  LogInViewController.swift
//  TestApp
//
//  Created by Melanie Kofman on 26.08.2022.
//

import UIKit
class LogInViewController: UIViewController {
    var service: Services?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setUp()
    }
    
    private func setUp() {
        view.addSubview(emailField)
        emailField.topAnchor.constraint(equalTo: view.topAnchor, constant: 140).isActive = true
        emailField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: light).isActive = true
        emailField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 2*light).isActive = true
        emailField.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        view.addSubview(passwordField)
        passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: normal).isActive = true
        passwordField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: light).isActive = true
        passwordField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 2*light).isActive = true
        passwordField.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        view.addSubview(authBtn)
        authBtn.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: normal).isActive = true
        authBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: light).isActive = true
        authBtn.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 2*light).isActive = true
        authBtn.heightAnchor.constraint(equalToConstant: height).isActive = true
        
    }
    
    var emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email"
        field.customField()
        return field
    }()
    
    var passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Пароль"
        field.customField()
        field.isSecureTextEntry = true
        return field
    }()
    
    var authBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Авторизация", for: .normal)
        button.styleBtn()
        button.addTarget(self, action: #selector(authorize), for: .touchUpInside)
        return button
    }()
    
    @objc
    private func authorize() {
        if validate() {
            service?.checkLogin(email: emailField.text!, password: passwordField.text!, comletion: {
                [weak self] in
                if $0 {
                    DispatchQueue.main.async {
                        self?.pushMainViewController()
                    }
                }
            }, viewController: self )
        }
    }
    
    private func validate() -> Bool {
        var flag = true
        if (service?.email != emailField.text) {
            emailField.error()
            flag = false
            self.showToast(message: "Неверный логин или пароль")
        } else {
            emailField.customField()
        }
        
        if (service?.pswd != passwordField.text) {
            passwordField.error()
            flag = false
            self.showToast(message: "Неверный логин или пароль")
        } else {
            passwordField.customField()
        }
        
        if (!(service?.validateEmail(email: emailField.text!))!) {
            emailField.error()
            flag = false
            print("flag=\(flag)")
            print("email-\(emailField.text!)")
            
        }
        else {
            emailField.customField()
        }
        if (emailField.text == "") {
            emailField.error()
            flag = false
            
        }
        else {
            emailField.customField()
        }
        
        if (passwordField.text == "") {
            passwordField.error()
            flag = false
            
        }
        else {
            passwordField.customField()
        }
        return flag
    }
    
    private func pushMainViewController() {
        let mainVC = MainViewController()
        mainVC.service = service
        navigationController?.pushViewController(mainVC, animated: true)
    }
}
private let height = Brandbook.Paddings.height
private let light = Brandbook.Paddings.light
private let normal = Brandbook.Paddings.normal
