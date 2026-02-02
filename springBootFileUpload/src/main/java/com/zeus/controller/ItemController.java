package com.zeus.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.UUID;

import org.apache.commons.io.IOUtils;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.zeus.domain.Item;
import com.zeus.service.ItemService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@MapperScan(basePackages = "com.zeus.mapper")
@RequestMapping("/item")
public class ItemController {

	@Autowired
	private ItemService itemservice;

	// application.properties 에서 upload.path에 저장된 값을 주입
	@Value("${upload.path}")
	private String uploadPath;

	@GetMapping("/createForm")
	public String itemcreateForm(Model model) {
		log.info("/createForm");
		return "item/createForm";
	}

	@PostMapping("/create")
	public String itemcreate(Item item, Model model) throws IOException, Exception {
		log.info("/create item=".toString());
		// 1.파일 업로드 한것을 가져올것
		MultipartFile file = item.getPicture();
		// 2.파일 정보를 로그파필에 기록
		log.info("originalName: " + file.getOriginalFilename());
		log.info("size: " + file.getSize());
		log.info("contentType: " + file.getContentType());
		// 3.파일을 외장하드에 저장
		String createdFileName = uploadFile(file.getOriginalFilename(), file.getBytes());
		// 4.저장된 새로생성된 파일명을 item 도메인에 저장한다.
		item.setUrl(createdFileName);
		// 5.테이블에 상품화면정보를 저장
		int count = itemservice.create(item);

		if (count > 0) {
			model.addAttribute("message", "%s 상품등록이 성공되었습니다.".formatted(file.getOriginalFilename()));
			return "item/success";
		}
		model.addAttribute("message", "%s 상품등록이 실패되었습니다.".formatted(file.getOriginalFilename()));
		return "item/failed";
	}

	private String uploadFile(String originalName, byte[] fileData) throws Exception {
		// 절대 중복되지않는 문자열생성 (cdc39bc0-a12-agqw-854-01ffqwed)
		UUID uid = UUID.randomUUID();
		// cdc39bc0-a12-agqw-854-01ffqwed_도훈.jpg (예시
		String createdFileName = uid.toString() + "_" + originalName;
		// new File("D:/upload","cdc39bc0-a12-agqw-854-01ffqwed_도훈.jpg")
		// D:/upload/cdc39bc0-a12-agqw-854-01ffqwed_도훈.jpg 생성 내용이없는 파일명만생성
		File target = new File(uploadPath, createdFileName);
		// (파일내용이 있는 바이트)byte[] fileData 을
		// D:/upload/cdc39bc0-a12-agqw-854-01ffqwed_도훈.jpg 복사진행
		FileCopyUtils.copy(fileData, target);
		return createdFileName;
	}

	@GetMapping("/list")
	public String itemList(Model model) throws Exception {
		log.info("/itemList");
		List<Item> itemList = itemservice.list();
		model.addAttribute("itemList", itemList);
		return "item/List";
	}

	@GetMapping("/detail")
	public String itemDetail(Item i, Model model) throws Exception {
		log.info("/detail");
		Item item = itemservice.read(i);
		model.addAttribute("item", item);
		return "item/detail";
	}
	
	//화면을 요청하는것이아닌 테이터를 보내줄것을 요청.
	@ResponseBody
	@GetMapping("/display")
	public ResponseEntity<byte[]> itemDisplay(Item item) throws Exception {
		log.info("FILE  url: ");
		//파일을 읽기위한 스트림
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		
		String url = itemservice.getPicture(item);
		log.info("FILE url: " + url);
		try {
			//파일명의 확장자를 가져옴 String formatName =  "jpg"; 
			String formatName = url.substring(url.lastIndexOf(".") + 1);
			MediaType mType = getMediaType(formatName);
			HttpHeaders headers = new HttpHeaders();
			in = new FileInputStream(uploadPath + File.separator + url);
			//이미지파일타입이 널이 아니하면 헤더에 이미지타입을 저장
			if (mType != null) {
				headers.setContentType(mType);
			}
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.CREATED);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		} finally {
			in.close();
		}
		return entity;
	}

	private MediaType getMediaType(String form) {
		String formatName = form.toUpperCase();
		if (formatName != null) {
			if (formatName.equals("JPG")) {
				return MediaType.IMAGE_JPEG;
			}
			if (formatName.equals("GIF")) {
				return MediaType.IMAGE_GIF;
			}
			if (formatName.equals("PNG")) {
				return MediaType.IMAGE_PNG;
			}
		}
		return null;
	}
}
