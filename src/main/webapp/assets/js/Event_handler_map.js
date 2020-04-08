  var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
       mapOption = {
           center: new kakao.maps.LatLng(37.556743, 126.945941), // 지도의 중심좌표[현재위치로 잡는 수정 필요]
           level: 6 // 지도의 확대 레벨
       };  
   
   // 지도 생성(지도컨테이너 +중심좌표,확대레벨)
   var map = new kakao.maps.Map(mapContainer, mapOption); 
   
   // 주소-좌표 변환 객체를 생성합니다
   var geocoder = new kakao.maps.services.Geocoder();
   
   
   //클러스터 관련
   var clusterer = new kakao.maps.MarkerClusterer({
      map: map,
      averageCenter: true,
      minLevel: 6
   });
   
   //(클릭이벤트) 마커 관련
   var marker = new kakao.maps.Marker(); // 클릭한 위치를 표시할 마커입니다
    //infowindow = new kakao.maps.InfoWindow({zindex:1}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다

   // 현재 지도 중심좌표로 주소를 검색해서 지도 좌측 상단에 표시합니다
   searchAddrFromCoords(map.getCenter(), displayCenterInfo);
   getInfo();

 //---------------------------클릭이벤트---------------------------------       
   // 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
   kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
       searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
           if (status === kakao.maps.services.Status.OK) {
               var detailAddr = '' + result[0].address.address_name;
                               '<span class="title">법정동 주소정보</span>' + 
                               detailAddr + 
                           '</div>';
   
               // 마커를 클릭한 위치에 표시합니다 
               marker.setPosition(mouseEvent.latLng);
               marker.setMap(map);
   
           }  
          // 클릭한 위도, 경도 정보를 가져옵니다 '
       var latlnginfo = mouseEvent.latLng;
        
      // 마커 위치를 클릭한 위치로 옮깁니다
      marker.setPosition(latlnginfo);
          
        //지도 아래 위도경도를 표시합니다
       var message = '클릭한 위치의 위도는 ' + latlnginfo.getLat() + ' 이고, ';
             message += '경도는 ' + latlnginfo.getLng() + ' 입니다';
       var resultDiv = document.getElementById('clickLatlng'); 
       var resultDiv1 = document.getElementById('clickAddr'); 
       resultDiv.innerHTML = message;  
       resultDiv1.innerHTML = detailAddr;
       });
   });
 //--------------------------중심좌표나 확대수준 변경 이벤트---------------
   // 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
   kakao.maps.event.addListener(map, 'idle', function() {
       searchAddrFromCoords(map.getCenter(), displayCenterInfo);
       clearMarkers();
       getInfo();
   });
   
 
   function searchAddrFromCoords(coords, callback) {
       // 좌표로 행정동 주소 정보를 요청합니다
       geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
   }
   
   function searchDetailAddrFromCoords(coords, callback) {
       // 좌표로 법정동 상세 주소 정보를 요청합니다
       geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
   }
   
   // 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
   function displayCenterInfo(result, status) {
       if (status === kakao.maps.services.Status.OK) {
           var infoDiv = document.getElementById('centerAddr');
   
           for(var i = 0; i < result.length; i++) {
               // 행정동의 region_type 값은 'H' 이므로
               if (result[i].region_type === 'H') {
                   infoDiv.innerHTML = result[i].address_name;
                   break;
               }
           }
       }    
   }
   var mapTypeControl = new kakao.maps.MapTypeControl();

    // 지도 타입 컨트롤을 지도에 표시합니다
    map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
    
    var courtMarkers = [];
    var markers = [];
    var overlays = [];
    function getInfo() {
        // 지도의 현재 중심좌표를 얻어옵니다 
        var center = map.getCenter(); 
        // 지도의 현재 레벨을 얻어옵니다
        var level = map.getLevel();
        // 지도의 현재 영역을 얻어옵니다 
        var bounds = map.getBounds();
        // 영역의 남서쪽 좌표를 얻어옵니다 
        var swLatLng = bounds.getSouthWest(); 
        // 영역의 북동쪽 좌표를 얻어옵니다 
        var neLatLng = bounds.getNorthEast(); 
        // 영역정보를 문자열로 얻어옵니다. ((남,서), (북,동)) 형식입니다
        var boundsStr = bounds.toString();
        
        var message = '지도 중심좌표는 위도 ' + center.getLat() + ', <br>';
       message += '경도 ' + center.getLng() + ' 이고 <br>';
       message += '지도 레벨은 ' + level + ' 입니다 <br> <br>';
       message += '지도의 남서쪽 좌표는 ' + swLatLng.getLat() + ', ' + swLatLng.getLng() + ' 이고 <br>';
       message += '북동쪽 좌표는 ' + neLatLng.getLat() + ', ' + neLatLng.getLng() + ' 입니다';
        
       console.log(message);
       var data = {
             scale: level,
               swLat: swLatLng.getLat(),
               swLng: swLatLng.getLng(),
               neLat: neLatLng.getLat(),
               neLng: neLatLng.getLng()
       }
       var url = "/map/data1/" + data.scale + "/" + data.swLat +"/" + data.swLng + "/" + data.neLat + "/" + data.neLng +".json";
        $.ajax({
           type: "get",
           url: url,
           data: data,
           contentType:"application/json;charset=UTF-8",
           success : function(result) {
              getMarkers(url, result);
           }
        });
    }
    
    //더보기 만들기
    var bDisplay = true;
    
    function doDisplay(){
    	var con = document.getElementById("myDIV");
    	if(con.style.display =='none'){
    		con.style.display = 'block';
    	}else{
    		con.style.display  = 'none';
    	}
    }
    function createGame(address){
    	var f = document.game;
    	
    	f.type.value = "game";
    	f.address.value= address;
    	
    	f.action = "/board/createPost";
    	f.method = "get";
    	f.submit();
    }
    
    
    function getMarkers(url, data){
       $.get(url, function (data){
          $(data.position).map(function(i, position){
            var marker = new kakao.maps.Marker({
                   map : map,
                   position : new kakao.maps.LatLng(position.lat, position.lng)
                });
        
            var courtInfoWord = '<div class="wrap">' + 
            '    <div class="info">' + 
            '        <div class="title">' + 
            position.name + 
            '            <div class="close" onclick="closeOverlay()" title="닫기"></div>' + 
            '        </div>' + 
            '        <div class="body">' + 
            '            <div class="img">' +
            '                <img src="http://cfile181.uf.daum.net/image/250649365602043421936D" width="73" height="70">' +
            '           </div>' + 
            '                <form name="game">'+
            '                <input type="hidden" name="type"/> '+
            '                <input type="hidden" name="address"/> '+ '</form>' +
            '            <div class="desc">' + 
            '                <div class="ellipsis">' + position.courtAd + '</div>' +
            '                <div class="jibun ellipsis">' + position.content + '</div>' +
            '                <div><a href="javascript:createGame('+"'" + position.courtAd+"'" +');">게임만들기</a></div>' + 
            '            </div>' + 
            '        </div>' + 
            '    </div>' +    
            '</div>';  
            // 인포윈도우를 생성합니다
            var overlay  = new kakao.maps.CustomOverlay({
                content : courtInfoWord,   //position.courtAd
                position: marker.getPosition()
            });
            
         // 마커에 클릭이벤트를 등록합니다
            kakao.maps.event.addListener(marker, 'click', function() {
                  // 마커 위에 인포윈도우를 표시합니다
               closeOverlay();
               overlay.setMap(map, marker);  
            },
            // 커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
            function closeOverlay() {
               overlay.setMap(null);
            });
            markers.push(marker);
            overlays.push(overlay);
             });
      });  

    }

    
    function clearMarkers(){
          for (var i = 0; i < markers.length; i++){
            markers[i].setMap(null);
            }
             markers=[];
    }
    function closeOverlay(){
       for (var i = 0; i < overlays.length; i++){
            overlays[i].setMap(null);
            }
             
    }
    
 
 
//-----------------------------------------------다중마커생성
// 편의점 마커를 생성하고 편의점 마커 배열에 추가하는 함수입니다
    function createCourtMarkers() {
        for (var i = 0; i < position.name.length; i++) {
            
            var imageSize = new kakao.maps.Size(22, 26),
                imageOptions = {   
                    spriteOrigin: new kakao.maps.Point(10, 36),    
                    spriteSize: new kakao.maps.Size(36, 98)  
                };       
         
            // 마커이미지와 마커를 생성합니다
            var markerImage = createMarkerImage(markerImageSrc, imageSize, imageOptions),    
                marker = createMarker(position.name[i], markerImage);  

            // 생성된 마커를 편의점 마커 배열에 추가합니다
            courtMarkers.push(marker);    
        }        
    }  
 // 편의점 마커들의 지도 표시 여부를 설정하는 함수입니다
    function setCourtMarkers(map) {        
        for (var i = 0; i < position.name.length; i++) {  
        	position.name[i].setMap(map);
        }        
    }

  //------------------------------------------------------데이터 가져오기       
    var name = document.querySelector('name');
    var courtAd = document.querySelector('courtAd');
    var content = document.querySelector('content');
    var requestURL = 'http://localhost:8080/map/data2.json';
    var request = new XMLHttpRequest();
    request.open('GET', requestURL);
    
    