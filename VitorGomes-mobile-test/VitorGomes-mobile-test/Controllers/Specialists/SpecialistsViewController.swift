//
//  SpecialistsViewController.swift
//  VitorGomes-mobile-test
//
//  Created by Vitor Gomes on 06/05/21.
//

import UIKit
import InitialsImageView

class SpecialistsViewController: UIViewController {

    var specialistsManager = SpecialistsManager()
    var specialistsData: [SpecialistsData] = []
    var receivedSpecialtyName = ""
    var chosenURL = ""
    
    @IBOutlet weak var nbSpecialists: UINavigationBar!
    @IBOutlet weak var tvSpecialists: UITableView!
    @IBOutlet weak var lbSpecialtyTitle: UILabel!
    @IBOutlet weak var lbSpecialistsQuantity: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tvSpecialists.delegate = self
        tvSpecialists.dataSource = self
        tvSpecialists.register(UINib(nibName: "SpecialistTableViewCell", bundle: nil), forCellReuseIdentifier: "SpecialistTableViewCell")
        
        lbSpecialtyTitle.text = receivedSpecialtyName
        
        print(receivedSpecialtyName)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        switch receivedSpecialtyName {
        case "Heart Specialist":
            
            chosenURL = "https://raw.githubusercontent.com/PortalTelemedicina/mobile-test/main/api/list_specialist_heart.json"
        case "Dental Care":
            
            chosenURL = "https://raw.githubusercontent.com/PortalTelemedicina/mobile-test/main/api/list_specialist_dental_care.json"
        case "Dermatology Specialist":
            
            chosenURL = "https://raw.githubusercontent.com/PortalTelemedicina/mobile-test/main/api/list_specialist_dermatology.json"
        default:
            
            print("Some error while collecting the specialty")
        }
        
        specialistsManager.specialistsRequest(with: chosenURL) { (specialistsData) in
            
            self.specialistsData = specialistsData
            
            DispatchQueue.main.async {
                
                self.tvSpecialists.reloadData()
            }
        } onError: { (error) in
            
            print(error)
        }

        // Not working properly
        if specialistsData.count <= 1 {
            
            lbSpecialistsQuantity.text = "\(specialistsData.count) doctor was found"
        } else {
            
            lbSpecialistsQuantity.text = "\(specialistsData.count) doctors were found"
        }
    }
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func filter(_ sender: UIBarButtonItem) {
        
        //No implementation needed.
    }
}

extension SpecialistsViewController: UITableViewDelegate {
    
}

extension SpecialistsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return specialistsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tvSpecialists.dequeueReusableCell(withIdentifier: "SpecialistTableViewCell", for: indexPath) as! SpecialistTableViewCell
        let doctor = specialistsData[indexPath.row]
        
        cell.lbName.text = doctor.name
        cell.ivInitials.setImageForName(doctor.name, circular: true, textAttributes: nil)
        
        if doctor.distance == nil {
            
            cell.lbDistance.text = "Distance not found"
        } else {
            
            cell.lbDistance.text = "Nearby \(String(format: "%.1f", doctor.distance!)) miles"
        }
        
        cell.lbDetails.text = doctor.description
        
        if doctor.actions.call == nil {
            
            cell.btCall.isHidden = true
        }
        
        return cell
    }
}
