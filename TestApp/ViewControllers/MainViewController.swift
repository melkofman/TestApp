//
//  MainViewController.swift
//  TestApp
//
//  Created by Melanie Kofman on 26.08.2022.
//

import UIKit
import Foundation
class MainViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var service: Services?
    var scrollView = UIScrollView()
    var uploadedAvatar: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setUpElements()
    }
    
    private func setUpElements() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo:view.topAnchor, constant: 75).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.backgroundColor = .clear
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        scrollView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 70).isActive = true
        imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: light).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        if !(uploadedAvatar ?? false) {
            imageView.image = UIImage(named: "default.jpeg")
        }
        
        scrollView.addSubview(pickPhotoBtn)
        pickPhotoBtn.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 20).isActive = true
        pickPhotoBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -light).isActive = true
        pickPhotoBtn.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        
        scrollView.addSubview(lastnameField)
        lastnameField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        lastnameField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: light).isActive = true
        lastnameField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -light).isActive = true
        lastnameField.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        scrollView.addSubview(firstnameField)
        firstnameField.topAnchor.constraint(equalTo: lastnameField.bottomAnchor, constant: 20).isActive = true
        firstnameField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: light).isActive = true
        firstnameField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -light).isActive = true
        firstnameField.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        scrollView.addSubview(patronymicField)
        patronymicField.topAnchor.constraint(equalTo: firstnameField.bottomAnchor, constant: 20).isActive = true
        patronymicField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: light).isActive = true
        patronymicField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -light).isActive = true
        patronymicField.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        scrollView.addSubview(birthPlaceField)
        birthPlaceField.topAnchor.constraint(equalTo: patronymicField.bottomAnchor, constant: 20).isActive = true
        birthPlaceField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: light).isActive = true
        birthPlaceField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -light).isActive = true
        birthPlaceField.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        scrollView.addSubview(dateBirthField)
        dateBirthField.topAnchor.constraint(equalTo: birthPlaceField.bottomAnchor, constant: 20).isActive = true
        dateBirthField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: light).isActive = true
        dateBirthField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -light).isActive = true
        dateBirthField.inputView = datePicker
        dateBirthField.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneBtnTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([doneBtn,flexibleSpace], animated: true)
        dateBirthField.inputAccessoryView = toolBar
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureDone))
        self.view.addGestureRecognizer(tapGesture)
        
        scrollView.addSubview(companyField)
        companyField.topAnchor.constraint(equalTo: dateBirthField.bottomAnchor, constant: 20).isActive = true
        companyField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: light).isActive = true
        companyField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -light).isActive = true
        companyField.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        scrollView.addSubview(positionField)
        positionField.topAnchor.constraint(equalTo: companyField.bottomAnchor, constant: 20).isActive = true
        positionField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: light).isActive = true
        positionField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -light).isActive = true
        positionField.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        //        var table = ThemesTableViewController()
        //        scrollView.addSubview(table.view)
        //        table.view.translatesAutoresizingMaskIntoConstraints = false
        //        table.view.topAnchor.constraint(equalTo: positionField.bottomAnchor, constant: 20).isActive = true
        //        table.view.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        //        table.view.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        ////        table.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        //        table.view.backgroundColor = .red
        
        scrollView.addSubview(saveBtn)
        saveBtn.topAnchor.constraint(equalTo: positionField.bottomAnchor, constant: 20).isActive = true
        saveBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: light).isActive = true
        saveBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -light).isActive = true
        saveBtn.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20).isActive = true
        
    }
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 75
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var pickPhotoBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Загрузить фото", for: .normal)
        button.styleBtn()
        button.addTarget(self, action: #selector(pickPhoto), for: .touchUpInside)
        return button
    }()
    
    var lastnameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Фамилия"
        field.customField()
        return field
    }()
    
    var firstnameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Имя"
        field.customField()
        return field
    }()
    
    var patronymicField: UITextField = {
        let field = UITextField()
        field.placeholder = "Отчество"
        field.customField()
        return field
    }()
    
    var birthPlaceField: UITextField = {
        let field = UITextField()
        field.placeholder = "Место рождения"
        field.customField()
        return field
    }()
    
    var datePicker: UIDatePicker = {
        let datePicker =  UIDatePicker()
        datePicker.datePickerMode = .date
        let localeID = Locale.preferredLanguages.first
        datePicker.locale = Locale(identifier: localeID!)
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(changeDate), for: .valueChanged)
        return datePicker
    }()
    
    var dateBirthField: UITextField = {
        let field = UITextField()
        field.placeholder = "Дата рождения"
        field.customField()
        return field
    }()
    
    var companyField: UITextField = {
        let field = UITextField()
        field.customField()
        field.placeholder = "Организация"
        return field
    }()
    
    var positionField: UITextField = {
        let field = UITextField()
        field.customField()
        field.placeholder = "Должность"
        return field
    }()
    
    //    var tableView: UITableView = {
    //        let tableView = UITableView()
    //
    //        tableView.translatesAutoresizingMaskIntoConstraints = false
    //        tableView.allowsMultipleSelectionDuringEditing = true
    //        return tableView
    //    }()
    
    var saveBtn: UIButton = {
        let button = UIButton()
        button.styleBtn()
        button.setTitle("Сохранить", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc
    private func pickPhoto() {
        let alert = UIAlertController(title: "Выберите фото", message: "загрузить из", preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "камера", style: .default, handler: { [weak self]
            (_) in self?.showImagePicker(selectedSource: .camera)
        })
        let library = UIAlertAction(title: "галерея", style: .default, handler: { [weak self]
            (_) in self?.showImagePicker(selectedSource: .photoLibrary)
        })
        let cancel = UIAlertAction(title: "отменить", style: .cancel, handler: nil)
        alert.addAction(camera)
        alert.addAction(library)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showImagePicker(selectedSource: UIImagePickerController.SourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(selectedSource) else {
            print("способ недоступ")
            return
            
        }
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = selectedSource
        imagePickerController.allowsEditing = false
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            imageView.image = selectedImage
            self.uploadedAvatar = true
        } else {
            print("not selected")
        }
        picker.dismiss(animated: true, completion: {
            self.service?.uploadAvatar(image: (self.imageView.image?.pngData()!) as! Data)
        })
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc
    private func doneBtnTapped() {
        view.endEditing(true)
    }
    
    @objc
    private func changeDate() {
        getDate()
        
    }
    
    private func getDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        dateBirthField.text = formatter.string(from: datePicker.date)
    }
    
    @objc
    private func tapGestureDone() {
        view.endEditing(true)
    }
    
    @objc
    private func saveButtonTapped() {
        if validate() {
            service?.updateProfile(viewController: self, firstname: firstnameField.text!,
                                   lastname: lastnameField.text!, birthdate: birthPlaceField.text!,
                                   preferences: ["qw", "kj"], organization: companyField.text!,
                                   position: positionField.text!, birth_place: birthPlaceField.text!, middlename: patronymicField.text!)
        }
    }
    
    private func validate() -> Bool {
        var flag = true
        if (!firstnameField.notEmpty()) {
            firstnameField.error()
            flag = false
        }
        else {
            firstnameField.customField()
        }
        
        if (!lastnameField.notEmpty()) {
            lastnameField.error()
            flag = false
        }
        else {
            lastnameField.customField()
        }
        
        if (!birthPlaceField.notEmpty()) {
            birthPlaceField.error()
            flag = false
        }
        else {
            birthPlaceField.customField()
        }
        
        
        return flag
    }
    
}
private let height = Brandbook.Paddings.height //40
private let light = Brandbook.Paddings.light //10
private let normal = Brandbook.Paddings.normal //15
