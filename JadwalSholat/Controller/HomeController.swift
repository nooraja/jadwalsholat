//
//  HomeController.swift
//  JadwalSholat
//
//  Created by NOOR on 23/11/19.
//  Copyright © 2019 NOOR. All rights reserved.
//

import CoreLocation
import RxSwift
import UIKit

class HomeController: UITableViewController {
    
    var eJadwal: Jadwal?
    var province: String?
    
    private var viewModel: JadwalViewModel?
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigation()
        
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = true
        tableView.tableFooterView = UIView()
        tableView.backgroundView = StarshipsListCellBackground(frame: .zero)
        
        tableView.registerCell(AppCell.self)
        tableView.registerCell(HomeHeaderCell.self)
    }
    
    func setUpNavigation() {

        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2431372549, green: 0.7647058824, blue: 0.8392156863, alpha: 1)
        self.navigationController?.navigationBar.tintColor = .telegramBlue
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)]
    }

    convenience init(viewModel: JadwalViewModel) {
        self.init()
        
        self.viewModel = viewModel
        bindViewModel()
    }
    
    func bindViewModel() {
        
        viewModel?.reloadDataObservable.subscribe(onNext: { [weak self] in
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        viewModel?.showErrorObservable.subscribe(onNext: { [weak self] (error: Error) in
            print(error.localizedDescription)
        })
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let count = viewModel?.getNumberOfRows(forSection: section) else {
            return 0
        }
        
        return count
    }
    var testingsaja: String = ""
    private func createHeaderCell(for indexPath: IndexPath) -> HomeHeaderCell {
        
        let cell =  tableView.dequeueReusableCell(for: indexPath) as HomeHeaderCell
        
        let myTimer = Timer(timeInterval: 0.5, target: self, selector: #selector(testingLabel), userInfo: nil, repeats: true)

        RunLoop.current.add(myTimer, forMode: RunLoop.Mode.common)
        
        if let data = viewModel?.getDetailJadwalHeaderViewModel() {
            cell.bind(exactTime: testingLabel())
        }
        
        return cell
    }
    
    @objc func testingLabel() -> String {
        testingsaja = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .long)
        return testingsaja
    }
    
    
    @objc func updateTime() {
        DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .full)
    }
    
    private func createInfoCell(for indexPath: IndexPath) -> AppCell {

        let cell =  tableView.dequeueReusableCell(for: indexPath) as AppCell
        
        if let data = viewModel?.getDetailJadwalCellViewModel(atIndex: indexPath.row) {
            cell.bind(title: data.time ?? "", subtitle: data.pray ?? "", icon: data.icon ?? "")
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch JadwalViewModel.Section(rawValue: indexPath.section) {
        case .some(.header):
            return createHeaderCell(for: indexPath)
            
        case .some(.cell):
            return createInfoCell(for: indexPath)
            
        case .none:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return self.view.frame.height * 0.35
        case 1:
            return ((self.view.frame.height) * 0.7 ) / 8 - 16
        default:
            return 0
        }
    }
    
}
