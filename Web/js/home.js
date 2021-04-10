var user = document.getElementById("user");
var life = document.getElementById("life");
var score = document.getElementById("score");
var asstable = document.getElementById("Asstable");
console.log(asstable);

fetchURL = (query, variable) => {
    return fetch(`https://funlearn.herokuapp.com/graphql/`, {
        method: "POST",
        headers: {
            "content-type": "Application/JSON",
            Authorization: `JWT ${localStorage.getItem("token")}`,
        },
        body: JSON.stringify({
            query: query,
            variables: variable,
        }),
    }).then((res) => res.json());
};

document.getElementById("Tests").classList.add("remove");
fetchURL(`{
    me{
      name,
      email,
      score,
      life
    }
  }`).then((result) => {
    console.log(result.data);
    user.innerHTML = `Welcome   ${result.data.me.name}`;
    score.innerHTML = `${result.data.me.score}`;
    life.innerHTML = `${result.data.me.life}`;
});

var i = 0;
fetchURL(`{
        myA{
         subject,
         name,
         marksobtained,
         duedate
       } 
       }`).then((result) => {
    console.log(result.data);
    result.data.myA.forEach((element, i) => {
        document.getElementById("Asstable").innerHTML += `
              <tr>
            <td>${i + 1}</td>
            <td>${element.subject}</td>
            <td>${element.name}</td>
            <td>${element.score}</td>
            <td>${element.duedate}</td>
            </tr>
              `;
    });
});

fetchURL(`{
    leaderboard{
      name,
      score,
      life
    }
   
  }`).then((result) => {
    console.log(result.data.leaderboard);
    var i = 1;
    result.data.leaderboard.forEach((element, i) => {
        document.getElementById("lboard").innerHTML += `
          <tr>
            <td>${i}</td>
            <td>${element.name}</td>
            <td>${element.score}</td>
            <td>${element.life}</td>
            </tr>
          `;
    });
});

const showTest = () => {
    var i = 1;
    document.getElementById("Assignments").classList.add("remove");
    document.getElementById("Assignments").classList.remove("show");
    document.getElementById("Tests").classList.add("show");
    fetchURL(`{
        mtT{
         subject,
         totalmarks,
         marksobtained,
         date
       }
       }`).then((result) => {
        console.log(result.data);
        result.data.mtT.forEach((element, i) => {
            document.getElementById("Testtable").innerHTML += `
             <tr>
            <td>${i}</td>
            <td>${element.subject}</td>
            <td>${element.marksobtained}</td>
            <td>${element.totalmarks}</td>
            </tr>
             `;
        });
    });
};

const showAss = () => {
    var i = 1;
    fetchURL(`{
        myA{
         subject,
         name,
         marksobtained,
         duedate
       } 
       }`).then((result) => {
        console.log(result.data);
        result.data.myA.forEach((element) => {
            document.getElementById("Asstable").innerHTML += `
              <tr>
            <td>${i}</td>
            <td>${element.subject}</td>
            <td>${element.name}</td>
            <td>${element.score}</td>
            <td>${element.duedate}</td>
            </tr>
              `;
        }, i++);
    });
    document.getElementById("Assignments").classList.add("show");
    document.getElementById("Tests").classList.add("remove");
    document.getElementById("Tests").classList.remove("show");
};