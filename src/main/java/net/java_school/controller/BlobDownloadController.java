package net.java_school.controller;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.appengine.api.blobstore.BlobInfo;
import com.google.appengine.api.blobstore.BlobInfoFactory;
import com.google.appengine.api.blobstore.BlobKey;
import com.google.appengine.api.blobstore.BlobstoreService;
import com.google.appengine.api.blobstore.BlobstoreServiceFactory;

@Controller
public class BlobDownloadController {
	private BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
	
	@RequestMapping("/serve")
	public void download(String filekey, HttpServletRequest req, HttpServletResponse resp) throws IOException {
		BlobKey blobKey = new BlobKey(filekey);
		BlobInfo blobInfo = new BlobInfoFactory().loadBlobInfo(blobKey);
		String filename = URLEncoder.encode(blobInfo.getFilename(), "UTF-8");
		resp.setContentType("application/octet-stream");
		resp.addHeader("Content-Disposition", "attachment; filename*=UTF-8''" + filename);
		blobstoreService.serve(blobKey, resp);
	}
}