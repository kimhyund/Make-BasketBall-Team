package www.cwb.com.framework.fileupload.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import net.coobird.thumbnailator.Thumbnailator;
import www.cwb.com.framework.fileupload.model.AttachVO;
import www.cwb.com.framework.fileupload.service.AttachService;

@Controller
@RequestMapping("/fileUpload/*")
public class UploadController {
	public static final String UPLOAD_FOLDER = "C:\\was_upload";
	public static final String THUMBNAIL_FILE_PREFIX = "s_";
	
	@Autowired
	private AttachService attachService;

	@GetMapping("uploadAjax")
	public void uploadAjax() {
		//uploadAjax.jsp로 전환하기
	}
	
	@PreAuthorize("isAuthenticated()")
	//테이블에 반영하지 않습니다. 폴더에 파일을 올리기만 합니다.
	@PostMapping(value="uploadAjaxAction", 
			produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachVO>> uploadAjaxPost(MultipartFile[] uploadFile) {
		List<AttachVO> retList = new ArrayList<>();
		
		//하루에 하나씩의 업로드용 폴더 검사하여 없으면 만들기 
		String uploadFolder = UPLOAD_FOLDER;
		String strUploadPath = getFolderName(new Date());
		File uploadPath = new File(uploadFolder, strUploadPath);
		if (!uploadPath.exists()) {
			uploadPath.mkdirs();
		}
		
		for (MultipartFile multipartFile : uploadFile) {
			AttachVO attachVO = new AttachVO();
			attachVO.setUploadPath(strUploadPath);
			attachVO.setShowBackFileName(strUploadPath);
			
			String uploadFileFullName = multipartFile.getOriginalFilename();

			String uploadFileName = uploadFileFullName.substring(
					uploadFileFullName.lastIndexOf("\\") + 1);
			attachVO.setFileName(uploadFileName);

			//c:\\a\b\c.xx   -> c.xx
			String uuid = UUID.randomUUID().toString();
			attachVO.setUuid(uuid);
			String uuidFileName = uuid + "_" + uploadFileName;
			File saveFile = new File(uploadPath, uuidFileName);
			
			try {
				//사용자 지정한 해당 파일을 업로드한다.
				multipartFile.transferTo(saveFile);
				String savedFileName = makeThumbnail(uploadPath, multipartFile, 
						uuidFileName, saveFile, attachVO);
				attachVO.appendShowBackFileName(savedFileName);
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
			retList.add(attachVO);
		}
		System.out.println(retList);
		return new ResponseEntity<List<AttachVO>>(retList, HttpStatus.OK);
	}

	/**
	 * 
	 * @param fileName 예를들어 2019/12/04/s_sdfrghasdfrgqwe7r65248rtfbhasef_Poodle.png
	 * @return
	 */
	@GetMapping("display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName) {
		ResponseEntity<byte[]> ret = null;
		
		File file = new File(UPLOAD_FOLDER + File.separatorChar + fileName);
		try {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			ret = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ret;
	}
	
	@GetMapping(value="download", produces=MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(@RequestHeader("User-Agent") String userAgent, String fileName) {
		Resource resource = new FileSystemResource(UPLOAD_FOLDER + File.separatorChar + fileName);
		if (!resource.exists()) {
			return new ResponseEntity<Resource>(HttpStatus.NOT_FOUND);
		}
		
		String resourceName = resource.getFilename();
		String resourceOriginalName = resourceName.substring(resourceName.lastIndexOf("_") + 1);
		
		HttpHeaders header = new HttpHeaders();
		try {
			String downloadName = null;

			if (userAgent.contains("Trident")) {
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8").replaceAll("\\+", " ");
			} else if (userAgent.contains("Edge")) {
				downloadName = URLEncoder.encode(resourceOriginalName, "UTF-8");
			} else {
				downloadName = new String(resourceOriginalName.getBytes("UTF-8"), 
						"ISO-8859-1");
			}
			header.add("Content-Disposition",
					"attachment;filename=" + downloadName);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseEntity<Resource>(resource, header, HttpStatus.OK);
	}
/*
 * 테이블에서 지우기 기능은 아님. 업로드한 폴더에서 해당 파일 창아서 삭제하기
			data:{fileName:targetFile, type:fileType},
 */
	@PostMapping(value="deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(AttachVO attachObj) {
		File file;
		try {
			file = new File(UPLOAD_FOLDER + File.separatorChar + URLDecoder.decode(attachObj.getFileName(), "UTF-8"));
			file.delete();
			//이미지 파일의 경우 썸네일과 원본을 함께 지워주어야 겠지요
			if (attachObj.isFileType()) {
				//~~~\sssss.jpg => 3
				String absolutePath = file.getAbsolutePath();
				int idxFileSeparator = absolutePath.lastIndexOf(File.separatorChar);
				StringBuilder sb = new StringBuilder(absolutePath.substring(0, idxFileSeparator + 1));
				sb.append(THUMBNAIL_FILE_PREFIX);
				sb.append(absolutePath.substring(idxFileSeparator + 1));
				String largerFileName = sb.toString();
				new File(largerFileName).delete();
			}
			
			//Attach Table을 통해 확보한 첨부 정보 삭제는 table에서도 삭제하여야 합니다.
			if (attachObj.getMasterId() != 0) {
				attachService.deleteAttach(attachObj);
			}
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}

	public void deleteFiles(List<AttachVO> listAttach) {
		for (AttachVO attachVO : listAttach) {
			try {
				String strPath = UPLOAD_FOLDER + File.separatorChar + attachVO.getUploadPath() + File.separatorChar + attachVO.getUuid() + "_" + attachVO.getFileName();
				Path path = Paths.get(strPath);
				Files.deleteIfExists(path);
				if (attachVO.isFileType()) {
					String strThumbPath = UPLOAD_FOLDER + File.separatorChar + attachVO.getUploadPath() + File.separatorChar + THUMBNAIL_FILE_PREFIX + attachVO.getUuid() + "_" + attachVO.getFileName();
					path = Paths.get(strThumbPath);
					Files.deleteIfExists(path);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	private String makeThumbnail(File uploadPath, MultipartFile multipartFile, 
			String uuidFileName, File saveFile, AttachVO attachVO)
			throws FileNotFoundException, IOException {
		String savedFileName;
		if (isImgType(saveFile)) {
			//이미지 파일의 경우 빠른 응답성을 위하여 크기가 작은 섬네일 파일을 추가적으로 만든다.
			attachVO.setFileType(true);
			String thumdnailFileName = THUMBNAIL_FILE_PREFIX + uuidFileName;
			savedFileName = File.separatorChar + thumdnailFileName;
			File thumdnailFile = new File(uploadPath, thumdnailFileName);
			FileOutputStream fos = new FileOutputStream(thumdnailFile);
			Thumbnailator.createThumbnail(multipartFile.getInputStream(), fos, 100, 100);
			fos.close();
		} else {
			savedFileName = File.separatorChar + uuidFileName;
		}
		return savedFileName;
	}
	
	public static String getFolderName(Date date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String ymd = sdf.format(date);
		//File.separatorChar OS 이식성을 보장해 준다.
		return ymd.replace('-', File.separatorChar);
	}
	
	/* 개발 표준 중에 함수에서 리턴은 오직 한번만 작성한다. */
	private boolean isImgType(File file) {
		boolean ret = false;
		try {
			String contentType = Files.probeContentType(file.toPath());
			if (contentType != null) {
				ret = contentType.startsWith("image");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ret;
	}

}
