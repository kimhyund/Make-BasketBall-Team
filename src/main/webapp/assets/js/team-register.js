        // Get the modal
        var modal = document.getElementById('TeamRegistry');
 
        // Get the button that opens the modal
        var btn = document.getElementById("t_register");
       
        
        // Get the <span> element that closes the modal
        var span = document.getElementsByClassName("close")[0];                                          
        
        // When the user clicks on the button, open the modal 
        btn.onclick = function() {
        	
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
  
