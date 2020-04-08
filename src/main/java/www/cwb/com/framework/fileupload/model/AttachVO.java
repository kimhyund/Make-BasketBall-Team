package www.cwb.com.framework.fileupload.model;

import java.io.File;

import lombok.Data;
import www.cwb.com.framework.fileupload.controller.UploadController;

@Data
public class AttachVO {
	private String masterName;
	private String uuid;
	private int masterId;
	private String uploadPath;
	private String fileName;
	private boolean fileType;
	private String showBackFileName;
	
	
	
	public String getMasterName() {
		return masterName;
	}

	public void setMasterName(String masterName) {
		this.masterName = masterName;
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public int getMasterId() {
		return masterId;
	}

	public void setMasterId(int masterId) {
		this.masterId = masterId;
	}

	public String getUploadPath() {
		return uploadPath;
	}

	public void setUploadPath(String uploadPath) {
		this.uploadPath = uploadPath;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public boolean isFileType() {
		return fileType;
	}

	public void setFileType(boolean fileType) {
		this.fileType = fileType;
	}

	public String getShowBackFileName() {
		return showBackFileName;
	}

	public void setShowBackFileName(String showBackFileName) {
		this.showBackFileName = showBackFileName;
	}

	public void appendShowBackFileName(String savedFileName) {
		showBackFileName += savedFileName;
	}
	
	public void makeShowBackFileName() {
		if (fileType) {
			//Image 일 때
			showBackFileName = uploadPath + File.separator + UploadController.THUMBNAIL_FILE_PREFIX + uuid + "_" + fileName;  
		} else {
			//Image가 아닐 때
			showBackFileName = uploadPath + File.separator + uuid + "_" + fileName;  
		}
		
	}
}
