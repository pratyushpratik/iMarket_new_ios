import UIKit

class loginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tfEmailId: UITextField!
    @IBOutlet weak var tfLoginPassword: UITextField!
    
    @IBOutlet weak var btnLoginNext: UIButton!
    
    var message1 = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfEmailId.delegate = self
        tfLoginPassword.delegate = self
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
        
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
        
        tfEmailId.inputAccessoryView = toolBar
        tfLoginPassword.inputAccessoryView = toolBar
    }
  
    
    func doneClicked() {
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        btnLoginNext.isEnabled = true
        //animateViewMoving(up: true, moveValue: 100)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //animateViewMoving(up: false, moveValue: 100)
    }
    
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = self.view.frame.offsetBy(dx: 0,  dy: movement)
        UIView.commitAnimations()
    }
    
    func isValidEmail(testStr: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    
    func isPwdLength(password: String) -> Bool {
        if password.characters.count <= 15 {
            return true
        }
        else{
            return false
        }
    }
    
    func alertControllerr(_message: String){
        let  myAlertNameFailure = UIAlertController(title : "Alert" , message : message1 , preferredStyle :UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title : "OK" , style : UIAlertActionStyle.default , handler:nil)
        myAlertNameFailure.addAction(okAction)
        self.present(myAlertNameFailure , animated : true , completion : nil)
    }
    
    @IBAction func btnLoginBack(_ sender: Any) {
                _ = self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnNextOperation(_ sender: Any) {
        
        if tfEmailId.text == "" {
            validate(msg: "Email id Required", btn: btnLoginNext, isEnabled: false)
        }
        else if tfLoginPassword.text == "" {
            validate(msg: "Password Required", btn: btnLoginNext, isEnabled: false)
        }
        else if !isValidEmail(testStr: tfEmailId.text ?? ""){
            validate(msg: "Provide valid email", btn: btnLoginNext, isEnabled: false)
            
        }
        else if !isPwdLength(password: tfLoginPassword.text ?? ""){
          validate(msg: "Password length can't be greater than 15", btn: btnLoginNext, isEnabled: false)
            
        }
        else if isValidEmail(testStr: tfEmailId.text ?? "") && isPwdLength(password: tfLoginPassword.text ?? ""){
            validate(msg: "Redirected to next page", btn: btnLoginNext, isEnabled: true)
        }
        else{
            validate(msg: "Sign Up failed", btn: btnLoginNext, isEnabled: false)
        }
    }
    
    func validate(msg:String, btn:UIButton, isEnabled:Bool){
        alertControllerr(_message: msg)
        btn.isEnabled = isEnabled
    }
}
