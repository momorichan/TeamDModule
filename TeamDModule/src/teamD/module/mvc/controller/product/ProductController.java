package teamD.module.mvc.controller.product;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import teamD.module.mvc.dao.ProductDaoInter;
import teamD.module.mvc.dto.PageVO;
import teamD.module.mvc.dto.ProductVO;

@Controller
public class ProductController {
	@Autowired
	private ProductDaoInter productDaoInter;
	@Autowired
	private PageVO pageVO;

	// insertForm으로 화면 전환, lcategory의 정보를 지님
	@GetMapping("/prInsert")
	public String prInsertForm(Model model) {
		model.addAttribute("lclist", productDaoInter.lcList());
		return "product/prInsertForm";
	}

	// insertForm에서 등록 버튼을 눌렀을 때 데이터베이스에 저장
	@PostMapping("/prAdd")
	public String prAdd(Model m, ProductVO vo, HttpServletRequest request) {

		// MultipartFile로 이미지 파일 업로드(ProductVO)
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

		// 메모리상(임시 저장소)에 파일을 우리가 설정한 경로에 복사 하겠다.
		// 이미지가 저장될 경로 만들기
		StringBuffer path = new StringBuffer();
		path.append(r_path).append(img_path).append("\\"); // 이스케이프 문자열
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

		return "redirect:prList";
	}

	// Get 방식으로 검색, 카테고리 선택 없이 상품목록 첫화면을 보여줌
	@GetMapping("/prList")
	public String prListForm(Model model) {
		Map<String, String> map = new HashMap<String, String>();

		map.put("lcnum", "0"); // 0 = (전체선택)특정 대분류를 선택하지 않음
		map.put("scnum", "0"); // 0 = (전체선택)특정 소분류를 선택하지 않음
		pageVO.setTotalRecord(productDaoInter.getTotal(map)); // 전체 상품 개수를 구함
		
		// 페이징 처리
		// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ //
		int totalRecord = pageVO.getTotalRecord(); 
		pageVO.setTotalPage((int) Math.ceil(totalRecord / (double) pageVO.getNumPerPage()));
		pageVO.setTotalBlock((int) Math.ceil((double) pageVO.getTotalPage() / pageVO.getPagePerBlock()));
		pageVO.setBeginPerPage((pageVO.getNowPage() - 1) * pageVO.getNumPerPage() + 1);
		pageVO.setEndPerPage((pageVO.getBeginPerPage() - 1) + pageVO.getNumPerPage());
		map.put("begin", String.valueOf(pageVO.getBeginPerPage()));
		map.put("end", String.valueOf(pageVO.getEndPerPage()));
		int startPage = (int) ((pageVO.getNowPage() - 1) / pageVO.getPagePerBlock()) * pageVO.getPagePerBlock() + 1;
		int endpage = startPage + pageVO.getPagePerBlock() - 1;
		if (endpage > pageVO.getTotalPage()) {
			endpage = pageVO.getTotalPage();
		}		
		// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━  //
		List<ProductVO> prList = productDaoInter.productList(map);// 전체 상품 목록
		
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endpage);
		model.addAttribute("page", pageVO);
		model.addAttribute("list", prList);
		
		// 대분류 카테고리를 모델에 추가
		model.addAttribute("lclist", productDaoInter.lcList());

		return "product/prList";
	}

	@GetMapping("/prDetail")
	public String prDetail(int pnum, Model m) {
		m.addAttribute("lcategory", productDaoInter.prDetail(pnum));
		return "product/prDetail";
	}

}
