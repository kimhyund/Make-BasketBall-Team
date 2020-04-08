        // Get the modal
        var modal = document.getElementById('CourtAddress');
 
        // Get the button that opens the modal
        var btn = document.getElementById("myBtn");
       
        
        // Get the <span> element that closes the modal
        var span = document.getElementsByClassName("close")[0];                                          
        
        // When the user clicks on the button, open the modal 
        btn.onclick = function() {
        	var latlng = document.getElementById("clickLatlng").innerHTML;
            var Addr = document.getElementById("clickAddr").innerHTML;
            var stringfied = '' + latlng;
            var stringfied1 = '' + Addr;
            var strArray = stringfied.split(' ');
         
            var insertlat = document.getElementById("latitude");
            var insertlng = document.getElementById("longitude");
            var instant = document.getElementById("address");
            insertlat.value = strArray[3];
            insertlng.value = strArray[6];
            instant.value =stringfied1;
            //insertlat.style.display = "none";
            //insertlng.style.display = "none";
             modal.style.display = "block";
        }
 
        // 스팬(x)를 누를 경우 모달창 종료
        span.onclick = function() { 
        	
            modal.style.display = "none";
        }
 
        // 모달 창 바깥부분을 클릭 할 경우 모달창 종료
        window.onclick = function(event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
        
