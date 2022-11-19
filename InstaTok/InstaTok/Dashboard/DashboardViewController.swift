//
//  DashboardViewController.swift
//  InstaTok
//
//  Created by laputer on 11/18/22.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class DashboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let arr = ["Ashish", "Mark", "Tom", "Bill"]
    
    var posts: [PostsClass] = [PostsClass]()
    
    @IBOutlet weak var tblView: UITableView!
    var db: Firestore?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        getPosts()
        // Do any additional setup after loading the view.
    }
    
    func getPosts() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        guard let db = db else {return}
        db.collection("Posts").whereField("UID", isEqualTo: uid)
        .getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.posts = [PostsClass]()
                for document in querySnapshot!.documents {
                    //print("\(document.documentID) => \(document.data())")
                    
                    guard let values = document.data() as? [String: Any] else {return}
                    
                    guard let caption = values["Caption"] as? String else {return}
                    guard let imageURL = values["ImageURL"] as? String else {return}
                    guard let location = values["Location"] as? String else {return}
                    //guard let timeStamp = values["Timestamp"] as? Timestamp else {return}
                    
                    let post = PostsClass()
                    post.caption = caption
                    post.dateTime = ""
                    post.location = location
                    post.imageURL = imageURL
                    self.posts.append(post)
                    
//                    print(caption)
//                    print(imageURL)
//                    print(location)
                    //print("timeStamp")
                }
                self.tblView.reloadData()
            }
        }
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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = arr[indexPath.row]
//        return cell
        let cell = Bundle.main.loadNibNamed("ImagePostTableViewCell", owner: self)?.first as! ImagePostTableViewCell
                
        cell.imgView.image = UIImage(named: "SpaceNeedle")
        cell.caption.text = posts[indexPath.row].caption
        cell.location.text = posts[indexPath.row].location
        cell.dateTime.text = "dateTime"

        return cell
    }
    
    /**
     db.collection("cities").whereField("capital", isEqualTo: true)
         .getDocuments() { (querySnapshot, err) in
             if let err = err {
                 print("Error getting documents: \(err)")
             } else {
                 for document in querySnapshot!.documents {
                     print("\(document.documentID) => \(document.data())")
                 }
             }
     }
     */
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
