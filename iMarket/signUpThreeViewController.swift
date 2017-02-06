
import UIKit

class signUpThreeViewController: UIViewController {

    @IBOutlet weak var labelFirstName: UILabel!
    @IBOutlet weak var labelLastName: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    
    @IBOutlet var imgImageView: UIImageView!
    
    var imgImage = UIImage()
    
    var labelTextOne = String()
    var labelTextTwo = String()
    var labelTextThree = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgImageView.layer.cornerRadius = imgImageView.frame.size.width/3
        imgImageView.clipsToBounds = true
        
        labelFirstName.text = labelTextOne
        labelLastName.text = labelTextTwo
        labelEmail.text = labelTextThree
        imgImageView.image = imgImage
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btnSignUpThree(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
}
