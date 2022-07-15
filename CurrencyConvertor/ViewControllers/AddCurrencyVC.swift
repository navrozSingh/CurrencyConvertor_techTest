//
//  AddCurrencyViewController.swift
//  CurrencyConvertor
//
//  Created by Navroz on 21/08/21.
//

import UIKit

class AddCurrencyVC: UIViewController {

    // MARK: Constant

    private enum Constant {
        static let containerHeight: CGFloat = UIScreen.main.bounds.width
        static let labelHeight: CGFloat = 32
        static let totalBalanceFont = UIFont.preferredFont(forTextStyle: .headline)
        static let currenciesLabelFont = UIFont.preferredFont(forTextStyle: .body)
        static let amountFont = UIFont.preferredFont(forTextStyle: .largeTitle)
        static let padding: CGFloat = 16
        static let top: CGFloat = 80

        static let amountPlaceholder = "Enter amount"
        static let currencyPlaceholder = "Select currency"
        static let saveButtonTitle = "Save"
        static let cancelButtonTitle = "Cancel"

    }

    // MARK: UI COMPONENTS

    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = Constant.padding
        containerView.addShadow()
        return containerView
    }()

    private lazy var amountTextfield: UITextField = {
        let txt = UITextField.createTextField(with: Constant.amountPlaceholder)
        txt.keyboardType = .numberPad
        txt.addTarget(self, action: #selector(amountTextfieldDidChange), for: .editingChanged)
        return txt
    }()
    
    private lazy var currencyTextfield: UITextField = {
        let txt = UITextField.createTextField(with: Constant.currencyPlaceholder)
        txt.inputView = currencyPicker
        return txt
    }()
    
    private lazy var currencyPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        return picker
    }()

    
    private lazy var saveButton: UIButton = {
        let saveBtn = UIButton.createButton(with: Constant.saveButtonTitle)
        saveBtn.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        return saveBtn
    }()

    private lazy var cancelButton: UIButton = {
        let cancelButton = UIButton.createButton(with: Constant.cancelButtonTitle)
        cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        return cancelButton
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.spacing = 10
        stackView.addArrangedSubview(currencyTextfield)
        stackView.addArrangedSubview(amountTextfield)
        stackView.addArrangedSubview(buttonStackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = Constant.padding
        stackView.addArrangedSubview(saveButton)
        stackView.addArrangedSubview(cancelButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return stackView
    }()

    private lazy var buttonFieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = Constant.padding
        stackView.addArrangedSubview(currencyTextfield)
        stackView.addArrangedSubview(amountTextfield)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let viewModal: AddCurrencyViewModal
    
    init(_ presenter: AddCurrencyViewModal) {
        self.viewModal = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activateContraints()
        setupPresenter()
    }

    @objc func amountTextfieldDidChange(_ textField: UITextField) {
        if let amountString = amountTextfield.text?.currencyInputFormatting() {
            amountTextfield.text = amountString
        }
    }

    @objc func saveAction() {
        viewModal.save(with: currencyTextfield.text, amount: amountTextfield.text)
    }
    
    @objc func cancelAction() {
        dismiss()
    }

}

// MARK: UI SETUP

private extension AddCurrencyVC {
    
    func activateContraints() {
        view.addSubview(containerView)
        containerView.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Constant.padding),
            containerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -Constant.padding),
            containerView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: Constant.top),
            containerView.heightAnchor.constraint(equalToConstant: Constant.containerHeight),
            
            mainStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constant.padding),
            mainStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constant.padding),
            mainStackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            mainStackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
    }
    
    // MARK: VIEW MODAL BINDING

    func setupPresenter() {
        viewModal.requirement = self
        amountTextfield.text = viewModal.selectedModal.amount
        currencyTextfield.text = viewModal.selectedModal.currency
    }
}

// MARK: CURRENCY PICKER

extension AddCurrencyVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        viewModal.currencyList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        viewModal.currencyList[row].currency
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currencyTextfield.text = viewModal.currencyList[row].currency
    }
}

// MARK: INIT CONTROLLER

extension AddCurrencyVC {
    
    static func controller(with viewModal: AddCurrencyViewModal) -> AddCurrencyVC {
        let controller = AddCurrencyVC(viewModal)
        controller.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        controller.modalPresentationStyle = .overFullScreen
        return controller
    }
}

// MARK: VIEW MODAL DEPENDENCY

extension AddCurrencyVC: AddCurrencyRequirement {

    func dismiss() {
        dismiss(animated: false)
    }
}
