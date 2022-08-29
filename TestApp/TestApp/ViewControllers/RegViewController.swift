//
//  ViewController.swift
//  TestApp
//
//  Created by Melanie Kofman on 26.08.2022.
//

import UIKit

class RegViewController: UIViewController {
    var service: Services?
    var pswdClick = false
    var email: String?
    
    init(service: Services) {
        super.init(nibName: nil, bundle: nil)
        self.service = service
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setUpFields()
    }
    
    private func setUpFields() {
        view.addSubview(surnameField)
        surnameField.topAnchor.constraint(equalTo: view.topAnchor, constant: 140).isActive = true
        surnameField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: light).isActive = true
        surnameField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 2*light).isActive = true
        surnameField.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        view.addSubview(nameField)
        nameField.topAnchor.constraint(equalTo: surnameField.bottomAnchor, constant: normal).isActive = true
        nameField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: light).isActive = true
        nameField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 2*light).isActive = true
        nameField.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        view.addSubview(partonymicField)
        partonymicField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: normal).isActive = true
        partonymicField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: light).isActive = true
        partonymicField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 2*light).isActive = true
        partonymicField.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        view.addSubview(emailField)
        emailField.topAnchor.constraint(equalTo: partonymicField.bottomAnchor, constant: normal).isActive = true
        emailField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: light).isActive = true
        emailField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 2*light).isActive = true
        emailField.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        view.addSubview(passwordField)
        passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: normal).isActive = true
        passwordField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: light).isActive = true
        passwordField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 2*light).isActive = true
        passwordField.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        view.addSubview(subPasswordField)
        subPasswordField.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: normal).isActive = true
        subPasswordField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: light).isActive = true
        subPasswordField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 2*light).isActive = true
        subPasswordField.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        view.addSubview(showPasswordBtn)
        showPasswordBtn.topAnchor.constraint(equalTo: subPasswordField.bottomAnchor, constant: normal).isActive = true
        showPasswordBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: light).isActive = true
        showPasswordBtn.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 2*light).isActive = true
        showPasswordBtn.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        view.addSubview(registerBtn)
        registerBtn.topAnchor.constraint(equalTo: showPasswordBtn.bottomAnchor, constant: normal).isActive = true
        registerBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: light).isActive = true
        registerBtn.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 2*light).isActive = true
        registerBtn.heightAnchor.constraint(equalToConstant: height).isActive = true
        
    }
    
    var surnameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Фамилия"
        field.customField()
        return field
    }()
    
    var nameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Имя"
        field.customField()
        return field
    }()
    
    var partonymicField: UITextField = {
        let field = UITextField()
        field.placeholder = "Отчество"
        field.customField()
        return field
    }()
    
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
    
    var subPasswordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Подтвердить пароль"
        field.customField()
        field.isSecureTextEntry = true
        return field
    }()
    
    var showPasswordBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Показать пароль", for: .normal)
        button.styleBtn()
        button.addTarget(self, action: #selector(showPassword), for: .touchUpInside)
        return button
    }()
    
    var registerBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Зарегистрироваться", for: .normal)
        button.styleBtn()
        button.addTarget(self, action: #selector(register), for: .touchUpInside)
        return button
    }()
    
    @objc
    private func register() {
        if validate() {
            service?.registerUser(email: emailField.text!, firstname: nameField.text!, lastname: surnameField.text!, password: passwordField.text!, comletion: { [weak self] in
                if $0 {
                    DispatchQueue.main.async {
                        self?.push()
                    }
                }
                
            },
                                  viewController: self)
            self.email = emailField.text!
        }
    }
    
    @objc
    private func showPassword() {
        passwordField.isSecureTextEntry = pswdClick
        subPasswordField.isSecureTextEntry = pswdClick
        pswdClick = !pswdClick
    }
    
    private func validate() -> Bool {
        var flag = true
        if (!surnameField.notEmpty()) {
            surnameField.error()
            flag = false
        }
        else {
            surnameField.customField()
        }
        
        if (!nameField.notEmpty()) {
            nameField.error()
            flag = false
        }
        else {
            nameField.customField()
        }
        
        if (!emailField.notEmpty()) {
            emailField.error()
            flag = false
        } else {
            emailField.customField()
        }
        
        if (!(service?.validateEmail(email: emailField.text!))!) {
            emailField.error()
            flag = false
        } else {
            emailField.customField()
        }
        
        if (!passwordField.notEmpty()) {
            passwordField.error()
            flag = false
        }
        else {
            passwordField.customField()
        }
        
        if (!subPasswordField.notEmpty()) {
            subPasswordField.error()
            flag = false
        }
        else {
            subPasswordField.customField()
        }
        
        if (passwordField.text != subPasswordField.text) {
            passwordField.error()
            subPasswordField.error()
            flag = false
        } else {
            passwordField.customField()
            subPasswordField.customField()
        }
        
        return flag
    }
    
    
    private func push() {
        let nevc = LogInViewController()
        nevc.service = service
        navigationController?.pushViewController(nevc, animated: true)
    }
    
}

private let height = Brandbook.Paddings.height
private let light = Brandbook.Paddings.light
private let normal = Brandbook.Paddings.normal
