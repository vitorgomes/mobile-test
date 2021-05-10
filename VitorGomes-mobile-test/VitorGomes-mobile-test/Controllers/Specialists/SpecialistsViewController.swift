//
//  SpecialistsViewController.swift
//  VitorGomes-mobile-test
//
//  Created by Vitor Gomes on 06/05/21.
//

import UIKit

class SpecialistsViewController: UIViewController {

    @IBOutlet weak var nbSpecialists: UINavigationBar!
    @IBOutlet weak var tvSpecialists: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        nbSpecialists.delegate = self
//        nbSpecialists.texte
    }
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func filter(_ sender: UIBarButtonItem) {
        
        //No implementation needed.
    }
}

//extension SpecialistsViewController: UINavigationBarDelegate {
//
//}
