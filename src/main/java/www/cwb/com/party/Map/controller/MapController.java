package www.cwb.com.party.Map.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import www.cwb.com.party.Map.service.MapService;
import www.cwb.com.party.Map.vo.MapVO;
import www.cwb.com.party.Map.vo.ScaleVO;
import www.cwb.com.party.Team.service.TeamService;
import www.cwb.com.party.Team.vo.TeamVO;


@Controller
@RequestMapping("/map/*")
public class MapController {
   @Autowired
   private MapService mapService;
   @Autowired
   private TeamService teamService;
   
   @GetMapping("/map")
   public void map4Location(MapVO map, Model model) {
      //CustomUser currentMember = SecurityUtil.getCurrentMember();
      //if (currentMember == null) {
      //   currentMember = "kimhd0329";
      //};
      List<MapVO> mapLists = mapService.getAllMaps();
      //model.addAttribute("userId", currentMember.getUsername());
      model.addAttribute("userId", "kimhd0329");
      model.addAttribute("mapLists", mapLists);
      return ;
   }
   
   @RequestMapping(value = "/data", produces = "application/json;charset = UTF-8")
   public ResponseEntity<List<TeamVO>> jsonTransfer (){
	   List<TeamVO> teamLists = teamService.getListTeam();
      //위도,경도 값을 리스트로 보관
      List addrLists = new ArrayList();
   
      //위도,경도 리스트를 "position"을 키로 묶기
     // Map<String, List> positions = new HashMap<String, List>();
      
      //positions.put("position", addrLists);
      return new ResponseEntity<List<TeamVO>> (teamLists, HttpStatus.OK);
   }
   @RequestMapping(value = "/data1/{scale}/{swLat}/{swLng}/{neLat}/{neLng}", produces = "application/json;charset = UTF-8")
   public ResponseEntity<Map<String, List>> ajaxTransfer (
         @PathVariable("scale") int scale,
         @PathVariable("swLat") float swLat,
         @PathVariable("swLng") float swLng,
         @PathVariable("neLat") float neLat,
         @PathVariable("neLng") float neLng){
      
      ScaleVO scaleVO = new ScaleVO();
      scaleVO.setScale(scale);
      scaleVO.setSwLat((float)swLat);
      scaleVO.setSwLng((float)swLng);
      scaleVO.setNeLat((float)neLat);
      scaleVO.setNeLng((float)neLng);
       List<MapVO> mapLists = mapService.getMarkers(scaleVO);
       System.out.println("safa: " + mapLists);
      //위도,경도 값을 리스트로 보관
      List addrLists = new ArrayList();
      for (MapVO map : mapLists) {
         //lat: 위도, lng: 경도 mapping해주기
         Map<String, String> addr = new HashMap<String, String>();
         String content = map.getContent();
         if (StringUtils.isEmpty(content)) {
        	 content = " ";
         }
         Object od = map.getLatitude();
         Object fa = map.getLongitude();
         addr.put("name", map.getName());
         addr.put("courtAd", map.getAddress());
         addr.put("content", content);
         addr.put("lat", od.toString());
         addr.put("lng", fa.toString());
         addrLists.add(addr);
      }
      //위도,경도 리스트를 "position"을 키로 묶기
      Map<String, List> positions = new HashMap<String, List>();
      
      positions.put("position", addrLists);
      return new ResponseEntity<Map<String, List>> (positions, HttpStatus.OK);
   }
   
   
   @PostMapping("/insert.do")
   public String insertMap(MapVO map, RedirectAttributes rttr) {
      //CustomUser currentMember = SecurityUtil.getCurrentMember();
      
      System.out.print("Insert map : " + map);
      //map.setUser_id(currentMember.getUsername());
      map.setUser_id("kimhd0329");
      mapService.insertMap(map);
      rttr.addFlashAttribute("result", "DB Insert 완료!!");
      return "redirect:/map/map";
   }
}
   
   
