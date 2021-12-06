//
//  PickerView.swift
//  SuperApp
//
//  Created by Mac on 03/12/21.
//

import UIKit

protocol CustomPickerViewDelegate: AnyObject {
    func confirmSelectedValue(value: Any)
}


class CustomPickerView: UIViewController {
    
    private lazy var backgroundView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = nil
        view.alpha = 0.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var mainView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 15.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.textAlignment = .center
        view.numberOfLines = 0
        view.textColor = .black
        view.font = .systemFont(ofSize: 18, weight: .bold)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var pickerView: UIPickerView = {
        let view = UIPickerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15.0
        view.backgroundColor = nil
        return view
    }()
    
    private lazy var confirmButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle("Confirmar", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = UIColor(withHex: "#003E8C")
        view.titleLabel?.font = .systemFont(ofSize: 16)
        view.layer.cornerRadius = 15.0
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(close), for: .touchUpInside)
        return view
    }()
    
    var titleText: String? {
        didSet { self.titleLabel.text = titleText }
    }
    
    var list: [String] = [String]() {
        didSet {
            self.pickerView.reloadAllComponents()
        }
    }
    
    var selectedOption: String?
    weak var delegate: CustomPickerViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    @objc private func close(sender: UIButton) {
        sender.zoomIn()
        if let selectedOption = self.selectedOption {
            self.delegate?.confirmSelectedValue(value: selectedOption)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func setup() {
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.selectedOption = list[0]
        
        self.view.addSubview(self.backgroundView)
        self.view.addSubview(self.mainView)
        self.mainView.addSubview(self.confirmButton)
        self.mainView.addSubview(self.titleLabel)
        self.mainView.addSubview(self.pickerView)
        
        NSLayoutConstraint.activate([self.backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     self.backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
                                     self.backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     self.backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        
        NSLayoutConstraint.activate([self.mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     self.mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     self.mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                     self.mainView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6)])
        
        NSLayoutConstraint.activate([self.confirmButton.centerXAnchor.constraint(equalTo: self.mainView.centerXAnchor),
                                     self.confirmButton.widthAnchor.constraint(equalTo: self.mainView.widthAnchor, multiplier: 0.5),
                                     self.confirmButton.bottomAnchor.constraint(equalTo: self.mainView.bottomAnchor, constant: -30),
                                     self.confirmButton.heightAnchor.constraint(equalToConstant: 50)])
        
        NSLayoutConstraint.activate([self.titleLabel.centerXAnchor.constraint(equalTo: self.mainView.centerXAnchor),
                                     self.titleLabel.widthAnchor.constraint(equalTo: self.mainView.widthAnchor, multiplier: 0.8),
                                     self.titleLabel.topAnchor.constraint(equalTo: self.mainView.topAnchor, constant: 10),
                                     self.titleLabel.heightAnchor.constraint(equalToConstant: 40)])

        NSLayoutConstraint.activate([self.pickerView.centerXAnchor.constraint(equalTo: self.mainView.centerXAnchor),
                                     self.pickerView.widthAnchor.constraint(equalTo: self.mainView.widthAnchor, multiplier: 0.8),
                                     self.pickerView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10),
                                     self.pickerView.bottomAnchor.constraint(equalTo: self.confirmButton.topAnchor, constant: -10)])
    }
}


extension CustomPickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.list[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedOption = self.list[row]
    }
}
