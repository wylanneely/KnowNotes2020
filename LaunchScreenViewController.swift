//
//  LaunchScreenViewController.swift
//  Know Notes
//
//  Created by Wylan L Neely on 11/28/20.
//

import UIKit

class LaunchScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUP()
        // Do any additional setup after loading the view.
    }
    
    func setUP(){
        
        let gifImage = UIImage.gifImageWithName(name: "KnowNotesLaunchScreen")
        gif.image = gifImage
    }
    
    @IBOutlet weak var gif: UIImageView!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
