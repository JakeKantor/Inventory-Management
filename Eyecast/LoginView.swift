//
//  LoginView.swift
//  Eyecast
//
//  Created by Jacob Kantor on 6/20/22.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseDatabase

struct LoginView: View {
    init() {
        
//        opaqueSeparator
        UITabBar.appearance().backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.1)
      }
    //Variables that are assigned to the text field
    
    @State private var email = ""
    @State private var password = ""
    @State private var name = ""
    
    
    //Varibles to switch buttons between register and login
    @State private var isDontHaveAccountClicked = false
    @State private var loginSignUp = "Login"
    @State private var dontHaveAccount = "Don't havce an account? Sign Up"
    @State private var showName = false

    //Boolean to show alert
    @State private var showAlert = false
    @State private var errorType = ""
    
    //Boolean to allow programtic navigationlink to swtich to add camera view
    @State private var isShowingTabBarView = false



    @State private var theUserName = ""


    
    //FOR FUTURE USE!!!
   //Variable to store the user data
    @StateObject var user1 = userType()



    //Creates the reference to the Realtime Database
    
    var ref = Database.database().reference()

    

    // Function that handles the sign up
    func register(){
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if user != nil{
                
                self.ref.child("Users").child(user!.user.uid).child("Name").setValue(name)
                self.ref.child("Users").child(user!.user.uid).child("Email").setValue(email)
                self.ref.child("Users").child(user!.user.uid).child("Password").setValue(password)
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {

                login()
                }
            }else{

                if let myError = error?.localizedDescription{
                    errorType = myError
                    showAlert = true
                    

                    


                }else{
                    errorType = "Unknown error"
                    showAlert = true
                }
            }
        }
    
    }
    
    
    func login(){
        
        if email != "" && password != "" {
            
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if user != nil{
                    
                    let userID = Auth.auth().currentUser?.uid
                    self.ref.child("Users").child(userID!).observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
                        
                        let value = snapshot.value as! [String: AnyObject]

                    }){ (error) in
                        
                     //Not using
                    }
                    
                    //Segue to the tab bar controller using navigation link
                    print("Logged IN!!")
                    isShowingTabBarView = true
                    
                    //Add function to pull and save name
                    self.ref.child("Users").child(userID!).child("Name").getData { error, snapshot in
                        
                        var usersName = snapshot?.value as? String ;
                        
                        theUserName = usersName!
                        
                    }
                    
                    
                }else{
                    
                    if let myError = error?.localizedDescription{
                        errorType = myError
                        showAlert = true
                    }else{
                        errorType = "Unknown error"
                        showAlert = true
                    }
                }
            }

        }
        
    }
    
   
    
    
    
    
    var body: some View {
        //Displays Initial Content
        
        tabBarView
//        if isShowingTabBarView == false {
//
//            content
//
//        }else{
//
//            tabBarView
//
//
//
//        }

        
    }
    
    var content: some View{
        
        ZStack {
            
            //Background Color
            Color.init(red: 0, green: 0, blue: 0.128).ignoresSafeArea(.all)
            
            
            //Yellow diagonal stripe
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundStyle(.linearGradient(colors: [.yellow,.orange], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 1000,height:700)
                .rotationEffect(.degrees(135))
                .offset(x:-300,y:-250)



            
            
            VStack(spacing: 20){
                
                
                
                
                Text("Welcome")
                    .foregroundColor(.white)
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .padding(.leading,0.5)
                    .offset(x:-100,y:-100)
                
                if showName == false{
                    
                    //name textfield
                        TextField("",text: $name)
                            .foregroundColor(.white)
                            .textFieldStyle(.plain)
                            .placeholder(when: name.isEmpty) {
                                Text("Name").foregroundColor(.white)
                                    .bold()
                    
                                
                            }.hidden()
                        
                    Rectangle().hidden()
                            .frame(width: 350, height: 1)
                            .foregroundColor(.white)
                    
                }else if showName == true {
                    //name textfield
                        TextField("",text: $name)
                            .foregroundColor(.white)
                            .textFieldStyle(.plain)
                            .placeholder(when: name.isEmpty) {
                                Text("Name").foregroundColor(.white)
                                    .bold()
                    
                                
                            }
                        
                    Rectangle()
                            .frame(width: 350, height: 1)
                            .foregroundColor(.white)
                    
                }
                
                
                
                
            //email textfield
                TextField("",text: $email)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: email.isEmpty) {
                        Text("Email").foregroundColor(.white)
                            .bold()
            
                        
                    }
                
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.white)
                
                
                
            //password textfield 
                SecureField("",text: $password)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: password.isEmpty) {
                        Text("Password").foregroundColor(.white)
                            .bold()
            
                        
                    }
                
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.white)
                
                
            
                    
                Button {
               
                    if loginSignUp == "Register"{
                        
                        //Register function
                        register()
                        
                        print("Register")
                    }else if loginSignUp == "Login"{
                        
                        //Login funciton
                        login()
                        

                        print("Login")
                    }
                        

                    
                    
                } label: {
                    Text(loginSignUp)
                        .bold()
                        .frame(width: 200, height: 40)
                      

                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.linearGradient(colors: [.yellow, .orange], startPoint: .top, endPoint: .bottomTrailing))
                        )
                        

                                         

    
                }.foregroundColor(.white)
                    .padding(.top)
                    .offset(y: 110)
                
                
                

                
                //start nav
                
               
                Button {
                 
                    if isDontHaveAccountClicked == false{
                        isDontHaveAccountClicked = true
                        loginSignUp = "Register"
                        dontHaveAccount = "Already have an account?Login"
                        showName = true
                        
                        
                    }else if isDontHaveAccountClicked == true{
                        isDontHaveAccountClicked = false
                        loginSignUp = "Login"
                        dontHaveAccount = "Don't havce an account? Sign Up"
                        showName = false

                    }
                    
                } label: {
                    Text(dontHaveAccount)
                        .bold()
                        .foregroundColor(.white)
                }
                .padding(.top)
                .offset(y:110)
                .alert(isPresented: $showAlert) {
                    
                    Alert(title: Text("⚠️"), message: Text(errorType), dismissButton: .default(Text("OK")))

                }
                
//end nav
                
             //Modifiers for entire VStack
            }.frame(width: 350)
                .onAppear()

            

        }.ignoresSafeArea()

    }
    

    

    var tabBarView: some View{
        
 
        
        TabView{
            ProductionView(nameOfUser: theUserName)
                .tabItem {
                    Label("Production", systemImage: "hammer")


                }
            
            TestView(nameOfUser: theUserName)
                .tabItem {
                    Label("Testing", systemImage: "testtube.2")

                }
            KitView()
                .tabItem {
                    Label("Kit", systemImage: "shippingbox.fill")

                }
            InventoryView()
                .tabItem {
                    Label("Inventory", systemImage: "tray.2")

                }
            
        }.accentColor(Color.init(red: 0, green: 0, blue: 0.128))

    }
   

    
    
}










struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        

        LoginView().previewDevice("iPhone 13 Pro Max")
        
        LoginView().previewDevice("iPhone 12")
        LoginView().previewDevice("iPhone 8")


        

    }
}


//Created to account for the rotated view so that elements are visble to user
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

