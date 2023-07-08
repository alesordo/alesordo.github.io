function showGreeting() {
    var date = new Date();
    var hour = date.getHours();

    var greeting;

    if (hour >= 5 && hour < 12) {
        greeting = "good morning ☕️";
    } else if (hour >= 12 && hour < 18) {
        greeting = "good afternoon 🤸";
    } else if(hour >= 18 && hour < 24){
        greeting = "good evening 🌃";
    } else{
        greeting = "greetings, night owl 🦉"
    }

    document.getElementById("greeting").innerHTML = greeting;
}

// Call the showGreeting function once the DOM content is loaded
document.addEventListener("DOMContentLoaded", function() {
    showGreeting();
    });