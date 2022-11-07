//
//  DashboardViewController.swift
//  PatientHealthChart
//
//  Created by laputer on 11/5/22.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class DashboardViewController: UIViewController {
    
    
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    
    @IBOutlet weak var dateOfBirthPicker: UIDatePicker!
    
    @IBOutlet weak var txtHeightFT: UITextField!
    @IBOutlet weak var txtHeightInches: UITextField!
    @IBOutlet weak var txtWeight: UITextField!
    
    var db: Firestore?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        let keychain = KeyChainService().keyChain
        keychain.clear()

        do {
            try Auth.auth().signOut()
        }
        catch{
            print("Unable to logout")
        }

        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    
    @IBAction func savePatientDetailAction(_ sender: Any) {
        
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        guard let firstName = txtFirstName.text else {return}
        guard let lastName = txtLastName.text else {return}
        guard let heightFT = txtHeightFT.text else {return}
        guard let heightInches = txtHeightInches.text else {return}
        guard let weight = txtWeight.text else {return}
        
        let DOB = dateOfBirthPicker.date
        
        // Add a new document with a generated ID
//        var ref: DocumentReference? = nil
//        guard let db = db else {return}
//        ref = db.collection("Patients/\(uid)").addDocument(data: [
//            "firstName": firstName,
//            "LastName": lastName,
//            "HeightInFT": Int(heightFT) ?? 5,
//            "HeightInInches": Int(heightInches) ?? 10,
//            "Weight": Int(weight) ?? 150
//            //"DOB": lastName
//        ]) { err in
//            if let err = err {
//                print("Error adding document: \(err)")
//            } else {
//                print("Document added with ID: \(ref!.documentID)")
//            }
//        }
        
        // Add a new document with a generated ID
        //var ref: DocumentReference? = nil
        guard let db = db else {return}
        let path = "Patients"
        db.collection("Patients").document(uid).setData([
            "firstName": firstName,
            "LastName": lastName,
            "HeightInFT": Int(heightFT) ?? 5,
            "HeightInInches": Int(heightInches) ?? 10,
            "Weight": Int(weight) ?? 150
            //"DOB": lastName
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            }
        }
        
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
