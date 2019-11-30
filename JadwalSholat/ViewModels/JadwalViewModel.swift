//
//  JadwalViewModel.swift
//  ZatWal
//
//  Created by NOOR on 03/08/19.
//  Copyright © 2019 Muhammad Noor. All rights reserved.
//

import Foundation
import RxSwift

final class JadwalViewModel {

	enum Section: Int {
		case header
		case cell
	}

	var reloadDataObservable: Observable<Void> {
		return reloadDataSubject
			.asObservable()
			.observeOn(MainScheduler.instance)
	}

	var showErrorObservable: Observable<Error> {
		return showErrorSubject
			.asObservable()
			.observeOn(MainScheduler.instance)
	}

	private var jadwalDetailViewModel = [JadwalCellViewModel]()
	private var jadwalHeaderViewModel: JadwalHeaderViewModel?

	private let networkModel: JadwalNetworkModel?
	private let disposeBag = DisposeBag()
    
    private let listIcons: [String] = ["clock", "sunrise", "sun", "loader", "sunset", "moon", "message"]
    private let nameOfPray: [String] = ["Subuh", "Shurooq", "Dhuhur", "Ashar", "Magrib", "Isya", "Tengah Malam"]

	private let reloadDataSubject = PublishSubject<Void>()
	private let showErrorSubject = PublishSubject<Error>()

    init(networkModel: JadwalNetworkModel, name: String) {
		self.networkModel = networkModel
        self.retreiveJadwal(name: name)
	}

    func retreiveJadwal(name: String) {

        networkModel?.retreiveJadwal(city: name).subscribe(onNext: { [weak self] (jadwal: Jadwal) in

			guard let times = jadwal.results.datetime.first?.times else {
				return
			}

            self?.jadwalDetailViewModel.append(contentsOf: [
                JadwalCellViewModel(time: times.fajr, icon: self?.listIcons[0], pray: self?.nameOfPray[0]),
                JadwalCellViewModel(time: times.imsak, icon: self?.listIcons[1], pray: self?.nameOfPray[1]),
                JadwalCellViewModel(time: times.dhuhr, icon: self?.listIcons[2], pray: self?.nameOfPray[2]),
                JadwalCellViewModel(time: times.asr, icon: self?.listIcons[3], pray: self?.nameOfPray[3]),
                JadwalCellViewModel(time: times.maghrib, icon: self?.listIcons[4], pray: self?.nameOfPray[4]),
                JadwalCellViewModel(time: times.isha, icon: self?.listIcons[5], pray: self?.nameOfPray[5]),
                JadwalCellViewModel(time: times.midnight, icon: self?.listIcons[6], pray: self?.nameOfPray[6])
				])

            self?.jadwalHeaderViewModel = JadwalHeaderViewModel(name: name)

			self?.reloadDataSubject.onNext(())

			}, onError: { [weak self] (error: Error) in
				self?.showErrorSubject.onNext(error)
			})
			.disposed(by: disposeBag)
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

	func getDetailJadwalHeaderViewModel() -> JadwalHeaderViewModel? {
		return jadwalHeaderViewModel
	}

	func getDetailJadwalCellViewModel(atIndex index: Int) -> JadwalCellViewModel? {

		guard index < jadwalDetailViewModel.count else {
			return nil
		}

		return jadwalDetailViewModel[index]
	}
}
