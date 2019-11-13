//
//  HomeTableVC.swift
//  CloudMovie
//
//  Created by Edwin Alvarado on 11/11/19.
//  Copyright © 2019 tbx. All rights reserved.
//

import UIKit
import Moya

class HomeTableVC: UITableViewController {

    let provider = MoyaProvider<MovieService>()
    var data: [PackMoviesDTO] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.title = "Movie Packs"
        
        getData()
        setupView()
    }
    
    func getData(){
        provider.request(.moviePacks) { (moyaResult) in
            let result: Endpoints.internalResponse = Endpoints.proccessResult(result: moyaResult)
            
            switch result {
            case .success(let response):
                let responsePackMovies = try! JSONDecoder().decode([PackMoviesDTO].self, from: response.data)
                self.data = responsePackMovies
            case .error(let response):
                break
            case .logout:
                UserDefaultsManager.removeAuth()
                self.dismiss(animated: true, completion: {
                    Utils.View.showMessage(title: "Ups!", message: "Token expirado")
                })
            case .failure:
                break
            }
        }
    }
    
    func setupView(){
        self.tableView.register(UINib.init(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.data.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.data[section].title ?? ""
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (self.data[indexPath.section].type?.elementsEqual("thumb"))!{
            return self.screenHeight * 0.37
        }else{
            return self.screenHeight * 0.50
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
        cell.setup(self.data[indexPath.section])
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
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
