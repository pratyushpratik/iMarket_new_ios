import UIKit

class signUpTwoViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var tfFirstName: UITextField!
    @IBOutlet weak var tfLastName: UITextField!
    
    @IBOutlet weak var imgProfilePicture: UIImageView!
    
    @IBOutlet weak var btnFinish: UIButton!
    
    var image:UIImage?
    
    var message1 = ""
    
    var emailText = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfFirstName.delegate = self
        tfLastName.delegate = self
        
        imgProfilePicture.layer.cornerRadius = imgProfilePicture.frame.size.width/2
        imgProfilePicture.clipsToBounds = true
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
      
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
        
        tfFirstName.inputAccessoryView = toolBar
        tfLastName.inputAccessoryView = toolBar
    }
   
    func doneClicked(){
        view.endEditing(true)
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
        btnFinish.isEnabled = true
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
    
    func isValidAlphabet(testStr: String) -> Bool {
        let alphabetRegEx = "^[a-zA-Z]+$"
        let alphabetTest = NSPredicate(format:"SELF MATCHES %@", alphabetRegEx)
        return alphabetTest.evaluate(with: testStr)
    }
    
    func isAlphabetLength(alphabet: String) -> Bool {
        if alphabet.characters.count <= 10{
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destViewController = segue.destination as? signUpThreeViewController{
            destViewController.labelTextOne = tfFirstName.text!
            destViewController.labelTextTwo = tfLastName.text!
            destViewController.labelTextThree = emailText
            destViewController.imgImage = imgProfilePicture.image!
        }
    }
    
    @IBAction func btnSignUpTwoBack(_ sender: Any) {
                _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnImageOperation(_ sender: AnyObject) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true){}
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
        imgProfilePicture.image = image
        }
        else{}
        self.dismiss(animated: true, completion: nil)
        }
    
    @IBAction func btnFinishOperation(_ sender: Any) {
        
        if tfFirstName.text == "" {
            validate(msg: "First name Required", btn: btnFinish, isEnabled: false)
        }
        else if tfLastName.text == "" {
            validate(msg: "Last Name Required", btn: btnFinish, isEnabled: false)
        }
        else if !isValidAlphabet(testStr: tfFirstName.text ?? ""){
            validate(msg: "Provide valid First name", btn: btnFinish, isEnabled: false)
        }
        else if !isValidAlphabet(testStr: tfLastName.text ?? ""){
            validate(msg: "Provide valid Last name", btn: btnFinish, isEnabled: false)
        }
        else if !isAlphabetLength(alphabet: tfFirstName.text ?? ""){
            validate(msg: "First name length can't be greater than 10", btn: btnFinish, isEnabled: false)
        }
        else if !isAlphabetLength(alphabet: tfLastName.text ?? ""){
            validate(msg: "Last name length can't be greater than 10", btn: btnFinish, isEnabled: false)
        }
        else if isValidAlphabet(testStr: tfFirstName.text ?? "") && isValidAlphabet(testStr: tfLastName.text ?? "") && isAlphabetLength(alphabet: tfFirstName.text ?? "") && isAlphabetLength(alphabet: tfLastName.text ?? ""){
            btnFinish.isEnabled = true
            performSegue(withIdentifier: "signUpThree", sender: self)
        }
        else{
            validate(msg: "Sign Up failed", btn: btnFinish, isEnabled: false)
        }
    }
    
    func validate(msg:String , btn: UIButton, isEnabled: Bool){
        alertControllerr(_message: msg)
        btn.isEnabled = isEnabled
    }
}
