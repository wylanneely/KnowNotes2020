//
//  GamePlayRound1ViewController.swift
//  Know Notes
//
//  Created by Wylan L Neely on 10/23/20.
//

import UIKit

class GamePlayRound1ViewController: UIViewController {
    
    var gameRoundNotes: [Note] = GameLessonManager.manager.lesson.round1Notes
    
    var note1: Note?
    var note2: Note?
    var note3: Note?
    
    let hapticGenerator = UINotificationFeedbackGenerator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignNotesToButtons()
        setUpScoresLifes()
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: SetUp
    
    func assignNotesToButtons(){
        let note_1 = gameRoundNotes[0]
        let note_2 = gameRoundNotes[1]
        let note_3 = gameRoundNotes[2]
        note1 = note_1
        note2 = note_2
        note3 = note_3
        note1Button.tag = note_1.id
        note2Button.tag = note_2.id
        note3Button.tag = note_3.id
        note1Button.setTitle("\(note_1.name)", for: .normal)
        note2Button.setTitle("\(note_2.name)", for: .normal)
        note3Button.setTitle("\(note_3.name)", for: .normal)

    }
    
    func setUpScoresLifes(){
        lifesLabel.text = "\(GameLessonManager.manager.lifes)"
        scoreLabel.text = "\(GameLessonManager.manager.score)"
    }
    
    var currentNote: Note?
    
    func checkRoundEnd(){
        if GameLessonManager.manager.score >= 10 {
            self.performSegue(withIdentifier: "toRound2", sender: self)
        }
        if GameLessonManager.manager.lifes == 0 {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    //MARK: Actions
    @IBAction func playButtonTapped(_ sender: Any) {
       let newNote = GameLessonManager.manager.getNextNote()
        currentNote = newNote
        //PlaySound
    }
    
    @IBAction func note1ButtonTapped(_ sender: Any) {
        if let note1 = note1 {
            if GameLessonManager.manager.checkUpdateSessionWith(note: note1) {
                //correct
                hapticGenerator.notificationOccurred(.success)
                scoreLabel.text = "\(GameLessonManager.manager.score)"
            } else {
                //wrong
                hapticGenerator.notificationOccurred(.error)
                lifesLabel.text = "\(GameLessonManager.manager.lifes)"
            }
        }
        checkRoundEnd()
    }
    @IBAction func note2ButtonTapped(_ sender: Any) {
        if let note2 = note2 {
            if GameLessonManager.manager.checkUpdateSessionWith(note: note2) {
                //correct
                hapticGenerator.notificationOccurred(.success)
                scoreLabel.text = "\(GameLessonManager.manager.score)"
            } else {
                //wrong
                hapticGenerator.notificationOccurred(.error)
                lifesLabel.text = "\(GameLessonManager.manager.lifes)"
            }
        }
        checkRoundEnd()
    }
    @IBAction func note3ButtonTapped(_ sender: Any) {
        if let note3 = note3 {
            if GameLessonManager.manager.checkUpdateSessionWith(note: note3) {
                //correct
                hapticGenerator.notificationOccurred(.success)
                scoreLabel.text = "\(GameLessonManager.manager.score)"
            } else {
                //wrong
                lifesLabel.text = "\(GameLessonManager.manager.lifes)"
                hapticGenerator.notificationOccurred(.error)
            }
        }
        checkRoundEnd()
    }
    
    
    //MARK: Outlets

    @IBOutlet weak var note1Button: UIButton!
    @IBOutlet weak var note2Button: UIButton!
    @IBOutlet weak var note3Button: UIButton!
    @IBOutlet weak var note1ButtonView: UIView!
    @IBOutlet weak var note2ButtonView: UIView!
    @IBOutlet weak var note3ButtonView: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var lifesLabel: UILabel!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
