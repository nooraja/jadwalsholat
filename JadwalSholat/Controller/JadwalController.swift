//
//  JadwalController.swift
//  JadwalSholat
//
//  Created by NOOR on 19/12/19.
//  Copyright © 2019 NOOR. All rights reserved.
//

import UIKit

class JadwalController: UITableViewController {
    
    //MARK:- Public Property
    
    var province: String?

    //MARK:- Private Property
    
    private var viewModel: JadwalViewModel?
    private var myTimer = Timer()
    
    override func viewDidDisappear(_ animated: Bool) {
        myTimer.invalidate()
    }

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
        self.province = province
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLayoutSubviews() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func bindViewModel() {
        
        viewModel?.changeHandler = { [weak self] change in
            
            guard let self = self else {
                return
            }
            
            switch change {
                
            case .didChangeNetworkActivityStatus(let isActive):
                self.setLoading(isActive)
                
            case .didUpdateJadwal:
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            case .didEncounterError(let error):
                print(error.debugDescription)
            }
        }
    }
    
    func setLoading(_ flag: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = flag
    }
    
    //MARK:- Private Method
    
    private func createHeaderCell(for indexPath: IndexPath) -> HomeHeaderCell {
        
        let cell =  tableView.dequeueReusableCell(for: indexPath) as HomeHeaderCell
        
        myTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            
            let currentTime = DateFormatter.localizedString(from: Date().addingTimeInterval(0.5), dateStyle: .none, timeStyle: .short)
            
            if let data = self.viewModel?.getCellHeaderViewModel() {
                cell.bind(time: currentTime, viewModel: data)
            }
            
        }
        
        cell.reloadButtonTapped = { [weak self] in
            self?.viewModel?.reloadJadwal()
        }
        
        RunLoop.current.add(myTimer, forMode: .common)
        
        return cell
    }
    
    private func createInfoCell(for indexPath: IndexPath) -> AppCell {
        
        let cell =  tableView.dequeueReusableCell(for: indexPath) as AppCell
        
        if let data = viewModel?.getCellViewModel(at: indexPath.row) {
            cell.bind(title: data.time ?? "", subtitle: data.pray ?? "", icon: data.icon ?? "")
        }
        
        return cell
    }

}

extension JadwalController {
    
    //MARK:- TableViewDataSource & TableViewDelegate
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let count = viewModel?.getNumberOfRows(forSection: section) else {
            return 0
        }
        
        return count
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
            return self.view.frame.height * 0.2
        case 1:
            return ((self.view.frame.height) * 0.7 ) / 8 - 16
        default:
            return 0
        }
    }
}
