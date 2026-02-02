package com.zeus.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
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
	public String itemDetail(Item item,Model model) throws Exception {
		log.info("/detail");
		List<Item> itemList = itemservice.list();
		model.addAttribute("itemList", itemList);
		return "item/List";
	}
	
}
