package teamD.module.mvc.controller.product;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import teamD.module.mvc.dao.ProductDaoInter;
import teamD.module.mvc.dto.ProductVO;

@Controller
public class ProductController {
	@Autowired
	private ProductDaoInter productDaoInter;
	
	
	@GetMapping("/prInsert")
	public String prInsertForm(Model model) {
		model.addAttribute("lclist", productDaoInter.lcList());
		return "product/prInsertForm";
	}
	
	@GetMapping("/prList")
	public String prList(Model model) {
		List<ProductVO> list = productDaoInter.prList();
		System.out.println("리스트 테스트" + list);
		model.addAttribute("list",list);
		return "product/prList";
	}
	
	@PostMapping("/prAdd")
	   public String prAdd(Model m, ProductVO vo, HttpServletRequest request) {
	      MultipartFile mf1 = vo.getMfile1();
	      String oriFn1 = mf1.getOriginalFilename();
	      
	      MultipartFile mf2 = vo.getMfile2();
	      String oriFn2 = mf2.getOriginalFilename();
	      
	      MultipartFile mf3 = vo.getMfile3();
	      String oriFn3 = mf3.getOriginalFilename();

	      // 경로 테스트 : 이미지가 저장될 경로
	      String img_path = "resources\\imgfile";

	      // 이클립스 상에 저장할 이미지 경로
	      String r_path = request.getSession().getServletContext().getRealPath("/");
	      System.out.println("r_path: " + r_path);

	      // 이미지 사이즈 및 contentType 확인
	      long size = mf1.getSize();
	      String contentType = mf1.getContentType();
	      
	      long size2 = mf2.getSize();
	      String contentType2 = mf2.getContentType();
	      
	      long size3 = mf3.getSize();
	      String contentType3 = mf3.getContentType();


	      // 메모리상(임시 저장소)에 파일을 우리가 설정한 경로에 복사 하겠다.
	      // 이미지가 저장될 경로 만들기
	      StringBuffer path = new StringBuffer();
	      path.append(r_path).append(img_path).append("\\");
	      path.append(oriFn1);
	      System.out.println("이미지 파일1의 FullPath: " + path);
	      
	      StringBuffer path2 = new StringBuffer();
	      path2.append(r_path).append(img_path).append("\\");
	      path2.append(oriFn2);
	      System.out.println("이미지 파일2의 FullPath: " + path2);
	      
	      StringBuffer path3 = new StringBuffer();
	      path3.append(r_path).append(img_path).append("\\");
	      path3.append(oriFn3);
	      System.out.println("이미지 파일3의 FullPath: " + path3);

	      File f = new File(path.toString());
	      File f2 = new File(path2.toString());
	      File f3 = new File(path3.toString());
	      
	      // 임시 메모리에 담긴 즉 업로드한 파일의 값 -> File 클래스의 경로로 복사
	      try {
	         mf1.transferTo(f);
	         mf2.transferTo(f2);
	         mf3.transferTo(f3);
	      } catch (IllegalStateException | IOException e) {
	         e.printStackTrace();
	      }

	      vo.setImage(oriFn1);
	      vo.setImage2(oriFn2);
	      vo.setImage3(oriFn3);
	      
	      productDaoInter.prInsert(vo);

	      return "redirect:main";
	   }
	
}
