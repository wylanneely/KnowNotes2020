//
//  KnownPlayerInstrumentNotesTableViewController.swift
//  Know Notes
//
//  Created by Wylan L Neely on 10/21/20.
//

import UIKit

class KnownPlayerInstrumentNotesTableViewController: UITableViewController,BeginLessonDelegate {
    
    //MARK: Delegate
    func beginLesssonButtonTapped() {
        self.performSegue(withIdentifier: "toGamePlay", sender: self)
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCellXibs()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    private func registerCellXibs(){
        let firstNoteCell = UINib(nibName: "FirstKownNotesViewCell",
                                  bundle: nil)
        let headerNoteCell = UINib(nibName: "PlayerKnownInstrumentNotesHeaderViewCell",
                                          bundle: nil)
        let secondRoundNoteCell = UINib(nibName: "SecondRoundKnownNotesViewCell",
                                        bundle: nil)
        let beginNoteCell = UINib(nibName: "BeginEditNotesLessonViewCell",
                                          bundle: nil)
        let lockedHalfNotesCell = UINib(nibName: "HalfNotesLockedViewCell",
                                        bundle: nil)
        
        self.tableView.register(firstNoteCell, forCellReuseIdentifier: "FirstNoteCell")
        self.tableView.register(lockedHalfNotesCell, forCellReuseIdentifier: "lockedHalfNotes")
       
        self.tableView.register(headerNoteCell, forCellReuseIdentifier: "headerCell")
        
        self.tableView.register(secondRoundNoteCell, forCellReuseIdentifier: "secondRoundCell")
        
        self.tableView.register(beginNoteCell, forCellReuseIdentifier: "beginCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
        return 5
        } else {
            return 1
        }
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell", for: indexPath)
                if let notesCellExample = PlayerKnownInstrumentNotesHeaderViewCell.createCell() {
                    return notesCellExample
                }
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "FirstNoteCell", for: indexPath)
                if let notesCellExample = FirstKownNotesViewCell.createCell() {
                    return notesCellExample
                }
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "secondRoundCell", for: indexPath)
                if let notesCellExample = SecondRoundKnownNotesViewCell.createCell() {
                    return notesCellExample
                }
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: "secondRoundCell", for: indexPath)
                if let notesCellExample = SecondRoundKnownNotesViewCell.createCell() {
                    //TODO: Set these buttons upso the user can select which note to learn
                    DispatchQueue.main.async {
                        notesCellExample.firstSelectedNoteLabel.text = "F"
                        notesCellExample.secondSelectedNoteButton.setTitle("G", for: .normal)
                    }
                    return notesCellExample
                }
                return cell
            case 4:
                let cell = tableView.dequeueReusableCell(withIdentifier: "beginCell", for: indexPath)
                if let notesCellExample = BeginEditNotesLessonViewCell.createCell() {
                    notesCellExample.delegate = self
                    return notesCellExample
                }
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "FirstNoteCell", for: indexPath)
                if let notesCellExample = FirstKownNotesViewCell.createCell() {
                    return notesCellExample
                }
                return cell
            }
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "lockedHalfNotes", for: indexPath)
        if let lockedHalfNotesCell = HalfNotesLockedViewCell.createCell() {
            return lockedHalfNotesCell
        }
        return cell
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 1 {
            return 80
        }
        
        switch indexPath.row {
        case 0: return 180
        case 1: return 120
        case 2: return 120
        case 3: return 120
        case 4: return 60
        default: return 120
        }
            
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    

}
