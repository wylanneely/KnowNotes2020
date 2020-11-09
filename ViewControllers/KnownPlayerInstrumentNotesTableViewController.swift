//
//  KnownPlayerInstrumentNotesTableViewController.swift
//  Know Notes
//
//  Created by Wylan L Neely on 10/21/20.
//

import UIKit

class KnownPlayerInstrumentNotesTableViewController: UITableViewController,BeginLessonDelegate {
    
    //MARK: Properties
    
    var instrumentName: String = InstrumentType.grandPiano.rawValue
    var instrumentImage: UIImage?
    
    var leaderboardsManager = GameCenterManager.manager.leaderboardsManager
    
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCellXibs()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func registerCellXibs(){
        let firstNoteCell = UINib(nibName: "FirstKownNotesViewCell", bundle: nil)
        let headerNoteCell = UINib(nibName: PlayerKnownInstrumentNotesHeaderViewCell.xibRID, bundle: nil)
        let secondRoundNoteCell = UINib(nibName: "SecondRoundKnownNotesViewCell",bundle: nil)
        let beginNoteCell = UINib(nibName: "BeginEditNotesLessonViewCell", bundle: nil)
        let lockedHalfNotesCell = UINib(nibName: "HalfNotesLockedViewCell", bundle: nil)
        self.tableView.register(firstNoteCell, forCellReuseIdentifier: "FirstNoteCell")
        self.tableView.register(lockedHalfNotesCell, forCellReuseIdentifier: "lockedHalfNotes")
        self.tableView.register(headerNoteCell, forCellReuseIdentifier: "headerCell")
        self.tableView.register(secondRoundNoteCell, forCellReuseIdentifier: "secondRoundCell")
        self.tableView.register(beginNoteCell, forCellReuseIdentifier: "beginCell")
    }
    
    
    //MARK: Delegate
            func beginLesssonButtonTapped() {
                LessonSession.manager.resetScores()
                LessonSession.manager.setRound1Notes()
                self.performSegue(withIdentifier: "toGamePlay", sender: self)
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
        
                        //MARK: Tableview Layout
        if indexPath.section == 0 {
            switch indexPath.row {
            
            case 0:
                if let instrumentImage = instrumentImage {
                    if let notesCellExample = PlayerKnownInstrumentNotesHeaderViewCell.createCell() {
                        
                        switch instrumentName {
                        case InstrumentType.grandPiano.rawValue:
                            //NOTE: FIX
                            if leaderboardsManager.didFinishGrandPianoRound2 {
                                                                //                  //                     //
                                notesCellExample.commonInit(image: instrumentImage, rank: "Grand Pianist", completedNotes: 7)
                                return notesCellExample
                                
                            } else if leaderboardsManager.didFinishGrandPianoRound1 {
                                notesCellExample.commonInit(image: instrumentImage, rank: "Piano Player", completedNotes: 5)
                                return notesCellExample
                            }
                            notesCellExample.commonInit(image: instrumentImage, rank: "Rookie", completedNotes: 3)
                            return notesCellExample
                        case InstrumentType.acousticGuitar.rawValue:
                            notesCellExample.commonInit(image: instrumentImage, rank: "Rookie", completedNotes: 3)
                            return notesCellExample
                        default:
                            return notesCellExample
                        }
                    }
                }
                
            case 1:
                if let notesCellExample = FirstKownNotesViewCell.createCell() {
                    return notesCellExample
                }
            case 2:
                if let notesCellExample = SecondRoundKnownNotesViewCell.createCell() {
                    switch instrumentName {
                    case InstrumentType.grandPiano.rawValue:
                        if leaderboardsManager.didFinishGrandPianoRound1 {
                            return notesCellExample
                        } else {
                            notesCellExample.setLockedNotesViews()
                            return notesCellExample
                        }
                    case InstrumentType.acousticGuitar.rawValue:
                        notesCellExample.setLockedNotesViews()
                        return notesCellExample
                    default:
                        return notesCellExample
                    }
                }
                
            case 3:
                if let notesCellExample = SecondRoundKnownNotesViewCell.createCell() {
                    switch instrumentName {
                    case InstrumentType.grandPiano.rawValue:
                        DispatchQueue.main.async {
                            notesCellExample.setLockedNotesViews()
                            notesCellExample.firstSelectedNoteLabel.text = "F"
                            notesCellExample.secondSelectedNoteButton.setTitle("G", for: .normal)
                        }
                        
                        if leaderboardsManager.didFinishGrandPianoRound2 {
                            return notesCellExample
                        } else {
                            notesCellExample.setLockedNotesViews()
                            return notesCellExample
                        }
                        
                    case InstrumentType.acousticGuitar.rawValue:
                        notesCellExample.setLockedNotesViews()
                        return notesCellExample
                    default:
                        return notesCellExample
                    }
                }
                
            case 4:
                if let notesCellExample = BeginEditNotesLessonViewCell.createCell() {
                    notesCellExample.delegate = self
                    return notesCellExample
                }
                
            default:
                if let notesCellExample = FirstKownNotesViewCell.createCell() {
                    return notesCellExample
                }
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
        case 0: return 200
        case 1: return 120
        case 2: return 120
        case 3: return 120
        case 4: return 70
        default: return 900
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
}
