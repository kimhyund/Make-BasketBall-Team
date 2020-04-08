 		</div>
      <footer class="footer footer-black  footer-white ">
        <div class="container-fluid">
          <div class="row">
            <nav class="footer-nav">
              
            </nav>
            <div class="credits ml-auto">
              <span class="copyright">
                
              </span>
            </div>
          </div>
        </div>
      </footer>
    </div>
  </div>

  
 
  
  
  <script type="text/javascript">
  $(document).ready(function(){
	  clearColor();
	  colorMenu();
  })
  function clearColor(){
	  var divs = document.getElementById("sidebar").getElementsByTagName("li"); 
	  for(var i=0; i<divs.length; i++){ 
		  if(divs[i].classList.contains('active')){
			  console.log("success");
			  divs[i].className="";
		  }
	  }
	  console.log("url : "+$(location).attr('href'));
	  console.log("url : "+$(location).attr('pathname'));
	  
  }
   //url로 sidebar 메뉴 class active하기
  function colorMenu(){
	  clearColor();
	  console.log("url111 : "+$(location).attr('pathname'));
	  var path = $(location).attr('pathname');
	  if (path.includes("/board")){
		  var li = document.getElementById("board");
		  li.className="active";
	  }	else if (path.includes("/map")){
		  var li = document.getElementById("Maps");
		  li.className="active";
	  } else if (path.includes("/team")){
		  var li = document.getElementById("Team");
		  li.className="active";
	  }
	  
  }
  
  </script>
  
  
</body>

</html>