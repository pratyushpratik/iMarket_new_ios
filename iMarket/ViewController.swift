import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnContinueUsingFacebook: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        btnContinueUsingFacebook.layer.cornerRadius=28
        btnContinueUsingFacebook.layer.masksToBounds=true
        btnContinueUsingFacebook.layer.borderColor=UIColor.init(red: 198, green: 16, blue: 53, alpha: 0.5).cgColor
        btnContinueUsingFacebook.layer.borderWidth=2
        
        btnLogin.layer.cornerRadius=28
        btnLogin.layer.masksToBounds=true
        btnLogin.layer.borderColor=UIColor.init(red: 198, green: 16, blue: 53, alpha: 0.5).cgColor
        btnLogin.layer.borderWidth=2
        
        btnSignUp.layer.cornerRadius=28
        btnSignUp.layer.masksToBounds=true
        btnSignUp.layer.borderColor=UIColor.white.cgColor
        btnSignUp.layer.borderWidth=2
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btnLoginOperation(_ sender: Any) {
        performSegue(withIdentifier: "login", sender: self)
    }
    
    @IBAction func btnSignUpOperation(_ sender: Any) {
        performSegue(withIdentifier: "signUpOne", sender: self)
    }
}


