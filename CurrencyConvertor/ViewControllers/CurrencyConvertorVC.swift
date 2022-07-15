//
//  ViewController.swift
//  CurrencyConvertor
//
//  Created by Navroz on 20/08/21.
//

import UIKit

class CurrencyConvertorVC: UIViewController {
    
    //MARK: Constant

    private enum Constant {
        static let cellID = "CurrencyCellCell"
        static let plusIcon = UIImage(systemName: "plus.circle")
        static let padding: CGFloat = 32
        static let buttonSize: CGFloat = 60
    }
    
    //MARK: UI COMPONENTS
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(CurrencyCell.self, forCellReuseIdentifier: Constant.cellID)
        return table
    }()
    
    private let tableHeader: BalanceHeaderCard = {
        let header = BalanceHeaderCard()
        header.configure(with: "", totalSelectedCurrency: 0)
        return header
    }()

    
    private let addButton: UIButton = {
        let addButton = UIButton()
        addButton.tintColor = .black
        addButton.setBackgroundImage(Constant.plusIcon, for: .normal)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.addTarget(self, action: #selector(addBtnAction), for: .touchUpInside)
        return addButton
    }()

    private var viewModal: CurrencyConvertorViewModal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        setupTableView()
        setupAddButton()
        setupViewModal()
    }
    
    @objc func addBtnAction() {
        viewModal?.getAllCurrencies()
    }
}

//MARK: UI COMPONENTS SETUP

private extension CurrencyConvertorVC {
    
    func setupTableView() {
        view = tableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
    }
    
    func setupAddButton() {
        view.addSubview(addButton)
        NSLayoutConstraint.activate([
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constant.padding),
            addButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Constant.padding),
            addButton.heightAnchor.constraint(equalToConstant: Constant.buttonSize),
            addButton.widthAnchor.constraint(equalToConstant: Constant.buttonSize)
        ])
        addButton.layer.cornerRadius = Constant.buttonSize/2
        view.bringSubviewToFront(addButton)
    }
    
    func setupViewModal() {
        //Binding via Proctol
        viewModal = CurrencyConvertorViewModal()
        viewModal?.requirement = self
    }
}

//MARK: VIEW MODAL DEPENDENCY

extension CurrencyConvertorVC: CurrencyConvertorRequirement {
    func showAddCurrency(with viewModal: AddCurrencyViewModal) {
        let vc = AddCurrencyVC.controller(with: viewModal)
        navigationController?.present(vc, animated: false)
    }
    
    func reloadDataSource() {
        tableView.reloadData()
    }
    
    func updateWalletCard(amount: String, selectedCurrencyCount: Int) {
        tableHeader.configure(with: amount, totalSelectedCurrency: selectedCurrencyCount)
    }
}

//MARK: TABLE VIEW

extension CurrencyConvertorVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModal?.dataSource.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCellCell") as? CurrencyCell,
              let modal = viewModal?.dataSource[indexPath.row]
        else { fatalError("Nil Cell") }
        cell.configureCell(with: modal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        tableHeader
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") {  [weak self] (contextualAction, view, boolValue) in
            self?.viewModal?.deleteDataSourceAt(indexPath.row)
            self?.tableView.deleteRows(at: [indexPath], with: .fade)
        }
        let edit = UIContextualAction(style: .normal, title: "Edit") {  [weak self] (contextualAction, view, boolValue) in
            self?.viewModal?.editDataSourceAt(indexPath.row)
            self?.tableView.reloadData()
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [edit, delete])
        swipeActions.performsFirstActionWithFullSwipe = false

        return swipeActions
    }
}
