//
//  RootViewController.swift
//  CGShop
//
//  Created by mac on 16/07/2018.
//  Copyright © 2018 cg. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
import RxSwift
import RxCocoa

class RootViewController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var searchBarFilterCars: UISearchBar!
    @IBOutlet weak var cvCars: UICollectionView!
    
    fileprivate let disposeBag = DisposeBag();
    var cars = [CarViewModel]()
    var viewModel: RootViewModel?
    fileprivate let refreshControl = UIRefreshControl()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return self.cars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productitem", for: indexPath) as! ProductItemUICollectionViewCell
        
        let car:CarViewModel = cars[indexPath.row]
        
        cell.lbCarName.text = car.nome
        
        cell.ivCar.kf.setImage(with: URL(string: car.imagem))
        
        let preco = String(car.preco)
        cell.lbCarPrice.text = "R$ \(preco)"
        
        return cell;
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindRx()
        configureRefreshControl()
        configureUiCollectionLayout()
        
    }
    
    func bindRx(){
        guard let vm = viewModel else { return }
        
        vm.carListResult.drive(onNext: { [weak self] data in
            self?.cars = data
            self?.cvCars.reloadData()
        }).disposed(by: disposeBag)

        searchBarFilterCars.rx.text.orEmpty.bind(to: vm.searchText).disposed(by: disposeBag);
        
        let tapGestureRecognizer = UITapGestureRecognizer()
        
        _ = Observable.of(refreshControl.rx_animating.asObservable(), tapGestureRecognizer.rx.event.map { _ in () })
            .merge()
            .bind(to: vm.triggerRefresh)
            .disposed(by: disposeBag)
        
        vm.carListResultRefresh.drive(onNext: { [weak self] data in
            self?.refreshControl.endRefreshing()
            self?.cars = data
            self?.cvCars.reloadData()
        }).disposed(by: disposeBag)
    }
    
    fileprivate func configureRefreshControl() {
        refreshControl.backgroundColor = UIColor.clear
        refreshControl.tintColor = UIColor.lightGray
        
        cvCars.addSubview(refreshControl)
    }
    
    fileprivate func configureUiCollectionLayout(){
        cvCars.collectionViewLayout = CarGridFlowLayout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

