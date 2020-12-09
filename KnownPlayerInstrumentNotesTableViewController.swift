//
//  KnownPlayerInstrumentNotesTableViewController.swift
//  Know Notes
//
//  Created by Wylan L Neely on 10/21/20.
//

import UIKit

class KnownPlayerInstrumentNotesTableViewController: UITableViewController,UIAdaptivePresentationControllerDelegate, BeginLessonDelegate, FirstRoundNotesDelegate, secondNoteGroupDelegate,ThirdNoteGroupDelegate, sharpsFlatsDelegate,ShuffleModeDelegate {
    //MARK: Properties
    
    var instrumentType: InstrumentType = .grandPiano
    var instrumentImage: UIImage?
    var leaderboardsManager = GameCenterManager.manager.leaderboardsManager
    
    var groupStartNumber: Int = 1
    var hasHalfNotes: Bool = false
    
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCellXibs()
    }
    
    //BugWorkaround
 
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func registerCellXibs(){
        let firstNoteCell = UINib(nibName: FirstKnownNotesViewCell.xibRID, bundle: nil)
        let headerNoteCell = UINib(nibName: PlayerKnownInstrumentNotesHeaderViewCell.xibRID, bundle: nil)
        let secondRoundNoteCell = UINib(nibName:SecondRoundKnownNotesViewCell.xibRID,bundle: nil)
        let beginNoteCell = UINib(nibName: BeginEditNotesLessonViewCell.xibRID, bundle: nil)
        let lockedHalfNotesCell = UINib(nibName: HalfNotesLockedViewCell.xibRID, bundle: nil)
        let shuffleCell = UINib(nibName: ShuffleNotesViewCell.xibRID, bundle: nil)
        let thirdCell = UINib(nibName: ThirdRoundKnownNotesViewCell.xibRID, bundle: nil)
        
        self.tableView.register(thirdCell, forCellReuseIdentifier: "ThirdCell")
        self.tableView.register(firstNoteCell, forCellReuseIdentifier: "FirstNoteCell")
        self.tableView.register(lockedHalfNotesCell, forCellReuseIdentifier: "lockedHalfNotes")
        self.tableView.register(headerNoteCell, forCellReuseIdentifier: "headerCell")
        self.tableView.register(secondRoundNoteCell, forCellReuseIdentifier: "secondRoundCell")
        self.tableView.register(beginNoteCell, forCellReuseIdentifier: "beginCell")
        self.tableView.register(shuffleCell, forCellReuseIdentifier: "shuffleCell")
    }

    //MARK: Delegates
    
    //MARK: Begin Delegate

    func beginLesssonButtonTapped() {
        Session.manager.resetScores()
        switch groupStartNumber {
        case 2:
            Session.manager.setRound2Notes()
            self.performSegue(withIdentifier: "skipToRound2", sender: self)
        case 3:
            Session.manager.setRound3Notes()
            self.performSegue(withIdentifier: "skipToRound3", sender: self)
        default:
            Session.manager.setRound1Notes()
            self.performSegue(withIdentifier: "toGamePlay", sender: self)
        }
    }

    //MARK: Advanced Gameplay Delegates
    
    func sharpsFlatsSelected(hasHalfs: Bool?) {
        if let hasHalfs = hasHalfs {
            hasHalfNotes = hasHalfs
            Session.manager.hasHalfNotes = hasHalfs
            DispatchQueue.main.async {
                self.tableView.reloadRows(at: [self.indexp1,self.indexp1,self.indexp1], with: .automatic)
                    }
        } else {
            self.present(lockedHalfsAlert, animated: true, completion: nil)
        } 
    }
    
    func shuffleModeSelected(mode: ShuffleMode) {
        switch mode {
        case .auto: Session.manager.shuffleMode = mode
        case .manual: Session.manager.shuffleMode = mode
        case .off: Session.manager.shuffleMode = mode
        case .locked: self.present(lockedShuffleAlert, animated: true, completion: nil)
        }
    }
    
    //MARK: Note Groups Delegate
    
    let indexp1 = IndexPath(row: 1, section: 0)
    let indexp2 = IndexPath(row: 2, section: 0)
    let indexp3 = IndexPath(row: 3, section: 0)
    
    func firstGroupTapped() {
        groupStartNumber = 1
        tableView.reloadRows(at: [indexp1,indexp3,indexp2], with: .automatic)
    }
    func secondGroupTapped() {
        groupStartNumber = 2
        tableView.reloadRows(at: [indexp1,indexp3,indexp2], with: .automatic)
   }
    func thirdGroupTapped() {
        groupStartNumber = 3
        tableView.reloadRows(at: [indexp1,indexp3,indexp2], with: .automatic)
    }
    func lockedSecondGroupTapped() {
        self.present(lockedRound2Alert, animated: true, completion: nil)
    }
    func lockedThirdGroupTapped() {
        self.present(lockedRound3Alert, animated: true, completion: nil)
    }
    
    //MARK: Alerts
    
    var lockedRound2Alert: UIAlertController {
        let alert = UIAlertController(title: "Locked", message: "Complete Round 1 to Unlock", preferredStyle: .alert)
        let action2 = UIAlertAction(title: "Ok", style: .cancel) { (_) in
            return
        }
        alert.addAction(action2)
        return alert
    }
    
    var lockedRound3Alert: UIAlertController {
        let alert = UIAlertController(title: "Locked", message: "Complete Round 2 to Unlock", preferredStyle: .alert)
        let action2 = UIAlertAction(title: "Ok", style: .cancel) { (_) in
            return
        }
        alert.addAction(action2)
        return alert
    }
    
    var lockedHalfsAlert: UIAlertController {
        let alert = UIAlertController(title: "Locked", message: "Complete all rounds to unlock", preferredStyle: .alert)
        let action2 = UIAlertAction(title: "Ok", style: .cancel) { (_) in
            return
        }
        alert.addAction(action2)
        return alert
    }
    
    var lockedShuffleAlert: UIAlertController {
        let alert = UIAlertController(title: "Locked", message: "Complete round 1 to unlock", preferredStyle: .alert)
        let action2 = UIAlertAction(title: "Ok", style: .cancel) { (_) in
            return
        }
        alert.addAction(action2)
        return alert
    }
    
    // MARK: TableView

    override func numberOfSections(in tableView: UITableView) -> Int {
        //NOTE: to display what sounds you have unlocked
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
        return 5
        }
        if section == 1 {
            if  instrumentType == .grandPiano, leaderboardsManager.didFinishGrandPianoRound2 {
                return 2
            }
            if instrumentType == .acousticGuitar, leaderboardsManager.didFinishAcousticGuitarRound1 {
                    return 2
                }
            } else {
                return 1
            }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //MARK: Layout Order
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                if let instrumentImage = instrumentImage {
                    if let notesCellExample = PlayerKnownInstrumentNotesHeaderViewCell.createCell() {
                        
                        switch instrumentType {
                        case .grandPiano:
                            if leaderboardsManager.didFinishGrandPianoRound2 {
                                notesCellExample.commonInit(image: instrumentImage, rank: "Grand Pianist", completedNotes: 7)
                                return notesCellExample
                            } else if leaderboardsManager.didFinishGrandPianoRound1 {
                                notesCellExample.commonInit(image: instrumentImage, rank: "Piano Player", completedNotes: 5)
                                return notesCellExample
                            }
                            notesCellExample.commonInit(image: instrumentImage, rank: "Noob Pianist", completedNotes: 3)
                            return notesCellExample
                        case .acousticGuitar:
                            notesCellExample.noteDescription.text = "Regular Major Chords"
                            if leaderboardsManager.didFinishAcousticGuitarRound2 {
                                notesCellExample.commonInit(image: instrumentImage, rank: "Master Guitarist", completedNotes: 7)
                                return notesCellExample
                            } else if leaderboardsManager.didFinishAcousticGuitarRound1 {
                                notesCellExample.commonInit(image: instrumentImage, rank: "Guitar Player", completedNotes: 5)
                                return notesCellExample
                            }
                            
                            notesCellExample.commonInit(image: instrumentImage, rank: "Noob Guitarist", completedNotes: 3)
                            return notesCellExample
                            
                            
                        case .violin:
                            if leaderboardsManager.didFinishViolinRound2 {
                                notesCellExample.commonInit(image: instrumentImage, rank: "Concert Master", completedNotes: 7)
                                return notesCellExample
                            } else if leaderboardsManager.didFinishViolinRound1 {
                                notesCellExample.commonInit(image: instrumentImage, rank: "Violin Player", completedNotes: 5)
                                return notesCellExample
                            }
                            notesCellExample.commonInit(image: instrumentImage, rank: "Noob Violinist", completedNotes: 3)
                                return notesCellExample
                        
                        case .saxaphone:
                            if leaderboardsManager.didFinishSaxRound2 {
                                notesCellExample.commonInit(image: instrumentImage, rank: "Sax Master", completedNotes: 7)
                                return notesCellExample
                            } else if leaderboardsManager.didFinishSaxRound1 {
                                notesCellExample.commonInit(image: instrumentImage, rank: "Sax Player", completedNotes: 5)
                                return notesCellExample
                            }
                            notesCellExample.commonInit(image: instrumentImage, rank: "Noob Sax Player", completedNotes: 3)
                                return notesCellExample
                        }}}
                
            case 1:
                if let notesCellExample = FirstKnownNotesViewCell.createCell() {
                        notesCellExample.setSelectedView()
                    notesCellExample.delegate = self
                    return notesCellExample
                }
                
            case 2:
                if let notesCellExample = SecondRoundKnownNotesViewCell.createCell()
                {

                    if groupStartNumber == 2 {
                        notesCellExample.setSelectedView()
                    }
                    if groupStartNumber == 3 {
                        notesCellExample.setSelectedView()
                    }
                    notesCellExample.delegate = self

                    switch instrumentType{
                    case .grandPiano:
                        if leaderboardsManager.didFinishGrandPianoRound1 {
                            return notesCellExample
                        } else {
                            notesCellExample.setLockedNotesViews()
                            return notesCellExample
                        }
                    case .acousticGuitar:
                        if leaderboardsManager.didFinishAcousticGuitarRound1 {
                            return notesCellExample
                        } else {
                            notesCellExample.setLockedNotesViews()
                            return notesCellExample
                        }
                    case .violin:
                        if leaderboardsManager.didFinishViolinRound1 {
                            return notesCellExample
                        } else {
                            notesCellExample.setLockedNotesViews()
                            return notesCellExample
                        }
                    case .saxaphone:
                        if leaderboardsManager.didFinishSaxRound1 {
                            return notesCellExample
                        } else {
                            notesCellExample.setLockedNotesViews()
                            return notesCellExample
                        }
                    }
                }
                
            case 3:
                if let notesCellExample = ThirdRoundKnownNotesViewCell.createCell() {
                    if groupStartNumber == 3 {
                        notesCellExample.setSelectedView()
                    }
                    notesCellExample.delegate = self
                    switch instrumentType {
                    case InstrumentType.grandPiano:
                        if leaderboardsManager.didFinishGrandPianoRound2 {
                            return notesCellExample
                        } else {
                            notesCellExample.setLockedNotesViews()
                            return notesCellExample
                        }
                    case InstrumentType.acousticGuitar:
                        if leaderboardsManager.didFinishAcousticGuitarRound2 {
                            return notesCellExample
                        } else {
                            notesCellExample.setLockedNotesViews()
                            return notesCellExample
                        }
                    case .violin:
                        if leaderboardsManager.didFinishViolinRound2 {
                            return notesCellExample
                        } else {
                            notesCellExample.setLockedNotesViews()
                            return notesCellExample
                        }
                    case .saxaphone:
                        if leaderboardsManager.didFinishSaxRound2{
                            return notesCellExample
                        } else {
                            notesCellExample.setLockedNotesViews()
                            return notesCellExample
                        }
                    }
                }
                
            case 4:
                if let notesCellExample = BeginEditNotesLessonViewCell.createCell() {
                    notesCellExample.delegate = self
                    notesCellExample.beginButton.pulsate()
                    return notesCellExample
                }
                
            default:
                if let notesCellExample = FirstKnownNotesViewCell.createCell() {
                    return notesCellExample
                }
            }
        }
        
        if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                if let shuffleViewCell = ShuffleNotesViewCell.createCell() {
                    shuffleViewCell.delegate = self
                    if Session.manager.isShuffleModeUnlocked == true {
                        return shuffleViewCell
                    } else {
                        shuffleViewCell.setLockedState()
                        return shuffleViewCell
                    }
                }
            case 1:
                if let lockedHalfNotesCell = HalfNotesLockedViewCell.createCell() {
                    if instrumentType == .grandPiano {
                        lockedHalfNotesCell.delegate = self
                        return lockedHalfNotesCell
                    }
                    if instrumentType == .acousticGuitar {
                        lockedHalfNotesCell.delegate = self
                        lockedHalfNotesCell.setGUitarChords()
                        return lockedHalfNotesCell
                    } else {
                        return lockedHalfNotesCell
                    }
                    
                }
                
                
            default:
                let cell = UITableViewCell()
                cell.backgroundColor = UIColor.clear
                return cell
            }
            
        }
        
        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.clear
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
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNonzeroMagnitude
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? GamePlayRound1ViewController {
            vc.instrumentType = self.instrumentType
            vc.hasHalfNotes = self.hasHalfNotes
            vc.getGameNotes()
            vc.shuffleMode = Session.manager.shuffleMode
        }
        if let vc = segue.destination as? GamePlayRound2ViewController {
            vc.isStartingRound = true
            vc.instrumentType = self.instrumentType
            vc.hasHalfNotes = self.hasHalfNotes
            vc.getGameNotes()
            vc.shuffleMode = Session.manager.shuffleMode
        }
        if let vc = segue.destination as? GamePlayRound3ViewController {
            vc.isStartingRound = true
            vc.instrumentType = self.instrumentType
            vc.hasHalfNotes = self.hasHalfNotes
            vc.shuffleMode = Session.manager.shuffleMode
            vc.getGameNotes()
        }
    }
    
}
