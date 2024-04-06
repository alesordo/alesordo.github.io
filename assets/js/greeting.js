function showGreeting() {
    var date = new Date();
    var hour = date.getHours();

    var greeting;

    if (hour >= 5 && hour < 12) {
        greeting = "good morning ☕️";
    } else if (hour >= 12 && hour < 18) {
        greeting = "good afternoon ☀️";
    } else if(hour >= 18 && hour < 24){
        greeting = "good evening 🌃";
    } else{
        greeting = "welcome, night owl 🦉"
    }

    document.getElementById("greeting").innerHTML = greeting;
}

function automaticAge() {
    var date = new Date();
    var year = date.getFullYear();
    var age = year - 1999;

    document.querySelector("#age").innerHTML = age;
}

// Call the showGreeting function once the DOM content is loaded
showGreeting();
automaticAge();