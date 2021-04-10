var loginName;
var loginPass;
var Name;
var Rollno;
var Password;
var Username;
var email;

const fetchURL = (query, variable) => {
    console.log(`${variable} ${query}`);
    return fetch("https://funlearn.herokuapp.com/graphql/", {
        method: "POST",
        headers: {
            "content-type": "application/json",
        },
        body: JSON.stringify({
            query: query,
            variables: variable,
        }),
    }).then((res) => res.json());
};
// fetchURL(`{
//     leaderboard{
//       name,
//       email,
//       score
//     }
//   }`).then((result) => {
// console.log(result.data);
// });

const login = () => {
    loginName = document.getElementById("exampleName1").value;
    loginPass = document.getElementById("exampleInputPassword2").value;
    console.log(`${loginName} ${loginPass}`);
    if (loginName != "" && loginPass != "") {
        fetchURL(
            `mutation GetUser($username:String! $password:String! )
        {
          tokenAuth(username:$username password:$password)
          {
            token
          }
        }`, { username: loginName, password: loginPass }
        ).then((result) => {
            console.log(result.data.tokenAuth.token);
            localStorage.setItem("token", result.data.tokenAuth.token);
            if (result.data.tokenAuth.token != "") {
                window.location.href = "home.html";
            } else {
                alert("Invalid User ");
            }
        });
    } else {
        alert("Enter valid details");
    }
};
const signup = () => {
    Name = document.getElementById("exampleInputName").value;
    Rollno = document.getElementById("exampleRollno").value;
    Password = document.getElementById("exampleInputPassword1").value;
    Username = document.getElementById("exampleUserName").value;
    email = document.getElementById("exampleInputEmail2").value;
    if (
        Name != "" &&
        Password != "" &&
        Username != "" &&
        email != "" &&
        Rollno != ""
    ) {
        fetchURL(
            `mutation createUser($email : String! $name:String! $roll:String!  $username:String! $password:String! )
       {
        createUser(email:$email name:$name password:$password username:$username roll:$roll){
         user
         {
           name,
           email,
           rollNo  
         }
        }
       }`, {
                email: email,
                name: Name,
                roll: Rollno,
                username: Username,
                password: Password,
            }
        ).then((result) => {
            console.log(result.data);
            alert("Successfully Registered");
            window.location.href = "register.html";
        });
    } else {
        alert("Enter valid details");
    }
};