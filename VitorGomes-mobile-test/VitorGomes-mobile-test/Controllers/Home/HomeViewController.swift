//
//  HomeViewController.swift
//  VitorGomes-mobile-test
//
//  Created by Vitor Gomes on 06/05/21.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {

    var homeData: [HomeData] = []
    var homeManager = HomeManager()
    
    @IBOutlet weak var cvSpecialty: UICollectionView!
    @IBOutlet weak var cvNeed: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cvSpecialty.dataSource = self
        cvSpecialty.delegate = self
        
        cvNeed.dataSource = self
        cvNeed.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        homeManager.homeRequest { (homeData) in
            
            self.homeData = homeData
            
            DispatchQueue.main.async {
                self.cvSpecialty.reloadData()
            }
        } onError: { (error) in
            
            print(error)
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "homeToSpecialtySegue" {
            
            let vc = segue.destination as! SpecialistsViewController
            
            vc.modalPresentationStyle = .fullScreen
            
            // Sending data to specialists screen
            let indexPath = cvSpecialty.indexPathsForSelectedItems?.first
            let homeResult = homeData[indexPath!.row]
            
            vc.receivedSpecialtyName = homeResult.name
        }
    }
}

//MARK: - EXTENSIONS
extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if(collectionView == cvNeed) {
            
            return 6
        }
        
        return homeData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(collectionView == cvNeed) {
            
            let cell2 = cvNeed.dequeueReusableCell(withReuseIdentifier: "NeedCollectionViewCell", for: indexPath) as! NeedCollectionViewCell

            return cell2
        }
        
        let cell = cvSpecialty.dequeueReusableCell(withReuseIdentifier: "SpecialtyCollectionViewCell", for: indexPath) as! SpecialtyCollectionViewCell
        let specialty = homeData[indexPath.row]

        // Still pending to implement the specialty logo using KingFisher pod
        cell.lbSpecialtyName.text = specialty.name
        
        switch specialty.name {
        case "Heart Specialist":
            
            cell.backgroundColor = UIColor(hexString: "#e5495e", alpha: 1.0)
        case "Dental Care":
            
            cell.backgroundColor = UIColor(hexString: "#f6af3d", alpha: 1.0)
        case "Dermatology Specialist":
            
            cell.backgroundColor = UIColor(hexString: "#7349e5", alpha: 1.0)
        default:
            
            cell.backgroundColor = .white
        }
        
        if specialty.total > 1 {

            cell.lbQuantity.text = "\(specialty.total) Doctors"
        } else {

            cell.lbQuantity.text = "\(specialty.total) Doctor"
        }

        return cell
    }
    
    
}

extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if(collectionView == cvNeed) {
            
            // Setting purple color when user click in any item o cvNeed
            let selectedCell:UICollectionViewCell = cvNeed.cellForItem(at: indexPath)!
            selectedCell.contentView.backgroundColor = UIColor(hexString: "ca49e5", alpha: 1.0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        if(collectionView == cvNeed) {
            
            // Cleaning the color of the cell when it is deselected
            let cellToDeselect:UICollectionViewCell = cvNeed.cellForItem(at: indexPath)!
            cellToDeselect.contentView.backgroundColor = UIColor.clear
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    // Working with static value, needs to change for dynamic
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if(collectionView == cvNeed) {
            
            return CGSize(width: 80, height: 80)
        }
        
        return CGSize(width: 150, height: 200)
    }
}
