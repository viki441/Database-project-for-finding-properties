// Get simple text output container
var output = document.getElementById("output")
// Get all svg paths with class 'region'
var regions = document.getElementsByClassName("region");
// get the region selection dropdown
var selection = document.getElementById('dropdown');
// Region selected on map
var selRegion;

// select region on map and synchronise with dropdown
for (var i = 0; i < regions.length; i++) (function(i){ 
  
  regions[i].onclick = function() {
    //what happens to non-selected regions
    for (var j = 0; j < regions.length; j++) {
      regions[j].style.fill = '';
      regions[j].classList.remove('active');
    }
    
    //what happens to selected region
    
    // on map
    regions[i].style.fill = "orange";
    regions[i].classList.add('active');
    
    //select region from map-selection in dropdown
    for (var h = 0; h < selection.length; h++) {
        if(selection.options[h].value == regions[i].id)
        {
          selection.selectedIndex = h;
        };
      }
   };
})(i);


// select region in dropdown and synchronise with map

selection.onchange = function myFunction() {

  for (var i = 0; i < regions.length; i++) (function(i){ 

      var h = selection.selectedIndex;
      if(selection.options[h].value == regions[i].id)
        {
          //what happens to selected region on map
          regions[i].style.fill = "white";
          regions[i].classList.add('active');
        }
  
      else{
        regions[i].style.fill = '';
        regions[i].classList.remove('active');
      }
  })(i);
};

document.querySelectorAll("rect").forEach(rect => {
  rect.setAttribute("width", 20);
  rect.setAttribute("height", 20);
});
