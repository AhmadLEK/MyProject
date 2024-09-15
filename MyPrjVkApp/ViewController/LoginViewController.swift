//
//  LoginViewController.swift
//  MyPrjVkApp
//
//  Created by Ахмад Амирович on 11.08.2024.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBAction func logInButtonPressed(_ sender: Any) {
//        print(userNameTextField.text)
//        print(userPasswordTextField.text)
        //saveToCoreData()
        //loadFromCoreData()
    }
    
    @IBAction func unwindToMain(unwindSegue: UIStoryboardSegue) {
        navigationController?.popToRootViewController(animated: true)
    }
    
//    private let keychainSwift = KeychainSwift()
    private let appDelegate = UIApplication.shared.delegate as? AppDelegate
    

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView
            .addGestureRecognizer(
                UITapGestureRecognizer(
                    target: self,
                    action: #selector(hideKeyboard)))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(#function)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWasShown),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillBeHidden(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: Actions
    @objc func keyboardWasShown(notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue)
            .cgRectValue
            .size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        UIView.animate(withDuration: 1) {
            self.scrollView.constraints
                .first(where: { $0.identifier == "keyboardShown" })?
                .priority = .required
            self.scrollView.constraints
                .first(where: { $0.identifier == "keyboardHide" })?
                .priority = .defaultHigh
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        UIView.animate(withDuration: 1) {
            self.scrollView.constraints
                .first(where: { $0.identifier == "keyboardShown" })?
                .priority = .defaultHigh
            self.scrollView.constraints
                .first(where: { $0.identifier == "keyboardHide" })?
                .priority = .required
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        switch identifier {
        case "goToMain":
            if !checkUser() {
                presentAlert()
                return false
            } else {
                 clearData()
                return true
            }
        default:
            return false
        }
        
    }
    
    // MARK: Private methods
    private func checkUser() -> Bool {
        userNameTextField.text == "" && userPasswordTextField.text == ""
    }
    
    private func presentAlert() {
        let alertController = UIAlertController(
            title: "Error",
            message: "Uncorrect username or password",
            preferredStyle: .alert)
        let action = UIAlertAction(title: "Close", style: .cancel)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
    private func clearData() {
        userNameTextField.text = nil
        userPasswordTextField.text = nil
    }
    
//    // MARK: User Defaults
//    private func saveToUserDefaults() {
//        UserDefaults.standard.set(
//            userNameTextField.text,
//            forKey: UserDefaults.Keys.usernameString.rawValue)
//        UserDefaults.standard.set(
//            userPasswordTextField.text,
//            forKey: UserDefaults.Keys.passwordString.rawValue)
//    }
//    
//    private func loadFromUserDefaults() {
//        let username = UserDefaults.standard.string(
//            forKey: UserDefaults.Keys.usernameString.rawValue)
//        let password = UserDefaults.standard.string(
//            forKey: UserDefaults.Keys.passwordString.rawValue)
//        print(username, password)
//    }
//    
//    private func removeFromUserDefaults() {
//        UserDefaults.standard.removeObject(forKey: UserDefaults.Keys.passwordString.rawValue)
//        UserDefaults.Keys.allCases.forEach{ UserDefaults.standard.removeObject(forKey: $0.rawValue)}
//    }
//    
//    // MARK: Keychain
//    private func saveToKeychan() {
//        guard
//            let username = userNameTextField.text,
//            let password = userPasswordTextField.text
//        else { return }
//        keychainSwift.set(username, forKey: UserDefaults.Keys.usernameString.rawValue)
//        keychainSwift.set(password, forKey: UserDefaults.Keys.usernameString.rawValue)
//    }
//    
//    private func loadFromKeychain() {
//        let username = keychainSwift.get(UserDefaults.Keys.usernameString.rawValue)
//        let password = keychainSwift.get(UserDefaults.Keys.passwordString.rawValue)
//    }
//    
//    private func removeKeychain() {
//        keychainSwift.delete(UserDefaults.Keys.usernameString.rawValue)
//        keychainSwift.clear()
//    }
    
//    // MARK: File manager
//    private func saveFile() {
//        guard
//            let url = FileManager.default
//                .urls(
//                    for: .documentDirectory,
//                       in: .userDomainMask)
//                .first,
//            let someImage = UIImage(named: "bmw")?.pngData()
//        else { return }
//        
//        let someFileUrl = url.appendingPathComponent("bmw")
//        do {
//            try someImage.write(to: someFileUrl)
//        } catch {
//            print(error)
//        }
//    }
//    
//    @discardableResult
//    private func loadFromDisk() -> UIImage {
//        guard
//            let url = FileManager.default
//                .urls(for: .documentDirectory, in: .userDomainMask).first
//        else { return nil }
//        let someFileURL = url.appendingPathComponent("bmw.png")
//        
//        guard
//            let imageData = try? Data(contentsOf: someFileURL),
//            let image = UIImage(data: imageData)
//        else { return nil}
//        return image
//    }

    // MARK:Core Data
    private func saveToCoreData() {
        guard let currentContex = appDelegate?.persistentContainer.viewContext else { return }
        let userCD = UserCD(context: currentContex)
        userCD.id = UUID()
        userCD.name = userNameTextField.text
        userCD.password = userPasswordTextField.text
        do {
            try currentContex.save()
        } catch {
            print(error)
        }
    }
    
    private func loadFromCoreData() {
        guard let currentContext = appDelegate?.persistentContainer.viewContext else { return }
        do {
            let usersCD = try currentContext.fetch(UserCD.fetchRequest())
            print(usersCD)
        } catch {
            let nserror = error as NSError
            printContent(nserror.userInfo)
        }
    }
}
