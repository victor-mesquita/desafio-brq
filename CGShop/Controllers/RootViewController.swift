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
    
    @IBOutlet weak var cvCars: UICollectionView!
    @IBOutlet weak var searchBarFilterCars: UISearchBar!
    
    fileprivate let disposeBag = DisposeBag();
    var cars = [CarViewModel]()
    var viewModel: RootViewModel?
    fileprivate let refreshControl = UIRefreshControl()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return self.cars.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productitem", for: indexPath) as! UICarCellView
        
        setCellData(cell: cell, indexPath: indexPath)
        
        return cell;
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        guard let vm = viewModel else { return }
        
        self.view.showLoading()
        
        vm.getCar(id: cars[indexPath.item].id)
            .subscribe(onNext: { [weak self] data in
                let carDetailViewController = self?.createCarDetailControllerWithVM(carViewModel: data)
                
                self?.view.closeLoading()
                
                self?.checkCarIsAvailable(carViewModel: data, callback: {
                    
                    self?.navigationController?.pushViewController(carDetailViewController!, animated: true)
                    self?.present(carDetailViewController!, animated: true, completion: nil)
                })
                
            }).disposed(by: disposeBag)
    }
    
    func checkCarIsAvailable(carViewModel: CarViewModel,  callback: (() -> Swift.Void)? = nil){
        
        if(carViewModel.carroIndisponivel){
            let alert = UIAlertController(title: "Carro indisponível", message: "O carro selecionado não está disponível para compra!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
        
        if(callback != nil) {
            callback!()
        }
    }
    
    func setCellData(cell: UICarCellView, indexPath: IndexPath){
        let car:CarViewModel = cars[indexPath.row]
        
        cell.lbCarName.text = car.nome
        
        cell.ivCarImage.kf.setImage(with: URL(string: car.imagem), placeholder: UIImage(named: "placeholder"))
        
        let preco = String(car.preco)
        
        cell.lbCarPrice.text = "R$ \(preco)"
    }
    
    func createCarDetailControllerWithVM(carViewModel: CarViewModel) -> CarDetailViewController {
        let carDetailViewController = UIStoryboard.main.carDetailViewController;
        carDetailViewController.viewModel = carViewModel;
        
        return carDetailViewController;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        self.view.showLoading()
        
        bindRx()
        configureUiCollectionLayout()
    }
    
    func bindRx(){
        guard let vm = viewModel else { return }
        
        searchBarFilterCars.rx.text.orEmpty.bind(to: vm.searchText).disposed(by: disposeBag);
        
        vm.result.subscribe(onNext: { [weak self] data in
            self?.cars = data;
            self?.cvCars.reloadData()
            self?.view.closeLoading()
        }).disposed(by: disposeBag)
        
        vm.searchResult.subscribe(onNext: { [weak self] filteredData in
            self?.cars = filteredData
            self?.cvCars.reloadData()
        }).disposed(by: disposeBag)
    }
    
    
    fileprivate func configureUiCollectionLayout(){
        cvCars.collectionViewLayout = CarGridFlowLayout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

