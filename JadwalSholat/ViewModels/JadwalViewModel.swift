//
//  JadwalViewModel.swift
//  JadwalSholat
//
//  Created by NOOR on 19/12/19.
//  Copyright © 2019 NOOR. All rights reserved.
//

import Foundation

enum JadwalViewModelChange {
    case didUpdateJadwal
    case didEncounterError(DataResponseError?)
    case didChangeNetworkActivityStatus(Bool)
}

final class JadwalViewModel {
    
    enum Section: Int {
        case header
        case cell
    }
    
    private var jadwalDetailViewModel = [JadwalCellViewModel]()
    private var jadwalHeaderViewModel: JadwalHeaderViewModel?
    
    private let networkModel: JadwalNetworkModel?
    
    var changeHandler: ((JadwalViewModelChange) -> Void)?

    private let listIcons: [String] = ["clock", "sunrise", "sun", "loader", "sunset", "moon", "message"]
    private let nameOfPray: [String] = ["Subuh", "Shurooq", "Dhuhur", "Ashar", "Magrib", "Isya", "Tengah Malam"]
    
    init(networkModel: JadwalNetworkModel) {
        self.networkModel = networkModel
        fetchJadwal(lat: "4.180220", long: "97.491173")
    }
    
    func reloadJadwal() {
        fetchJadwal(lat: "46.079747", long: "2.911622")
    }
    
    func fetchJadwal(lat: String, long: String) {

        self.networkModel?.retreiveJadwal(.jadwalList(lat: lat, long: long), { [weak self] result in
            
            guard let self = self else {
                return
            }
            
            switch result {

            case .failure(let error):
                
                DispatchQueue.main.async { [unowned self] in
                    self.emit(.didEncounterError(error))
                }
                
            case .success(let response):
        
                guard let times = response.results?.datetime?.first?.times,
                    let date = response.results?.datetime?.first?.date?.gregorian,
                    let timezone = response.results?.location?.timezone else {
                        return
                }

                self.jadwalDetailViewModel = [
                    JadwalCellViewModel(time: times.fajr,       icon: self.listIcons[0], pray: self.nameOfPray[0]),
                    JadwalCellViewModel(time: times.imsak,      icon: self.listIcons[1], pray: self.nameOfPray[1]),
                    JadwalCellViewModel(time: times.dhuhr,      icon: self.listIcons[2], pray: self.nameOfPray[2]),
                    JadwalCellViewModel(time: times.asr,        icon: self.listIcons[3], pray: self.nameOfPray[3]),
                    JadwalCellViewModel(time: times.maghrib,    icon: self.listIcons[4], pray: self.nameOfPray[4]),
                    JadwalCellViewModel(time: times.isha,       icon: self.listIcons[5], pray: self.nameOfPray[5]),
                    JadwalCellViewModel(time: times.midnight,   icon: self.listIcons[6], pray: self.nameOfPray[6])
                    ]

                self.jadwalHeaderViewModel = JadwalHeaderViewModel(name: timezone, date: date)

                self.emit(.didUpdateJadwal)
            }
        })
    }
    
    func getNumberOfRows(forSection section: Int) -> Int {
        
        switch Section(rawValue: section) {
        case .some(.header):
            return 1
            
        case .some(.cell):
            return jadwalDetailViewModel.count
            
        case .none:
            return 0
        }
    }
    
    func getJadwalCount() -> Int {
        return jadwalDetailViewModel.count
    }
    
    func getCellHeaderViewModel() -> JadwalHeaderViewModel? {
        return jadwalHeaderViewModel
    }
    
    func getCellViewModel(at indexAt: Int) -> JadwalCellViewModel? {
        
        guard indexAt < jadwalDetailViewModel.count else {
            return nil
        }
        
        return jadwalDetailViewModel[indexAt]
    }
    
    func emit(_ change: JadwalViewModelChange) {
        changeHandler?(change)
    }
}
