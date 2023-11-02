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
import org.springframework.web.bind.annotation.RequestMapping;
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

	@GetMapping("/prInsert")
	public String prInsertForm(Model model) {
		model.addAttribute("lclist", productDaoInter.lcList());
		return "product/prInsertForm";
	}

	@RequestMapping("/pagingForm")
	public Map<String, String> pagingForm() {
		Map<String, String> map = new HashMap<String, String>();
		return map;
	}

	@RequestMapping("/prList")
    public String prListForm(Model model, @RequestParam Map<String, String> paramMap) {
         String cPage = paramMap.get("cPage");
         pageVO.setTotalRecord(productDaoInter.getTotal(paramMap));
         int totalRecord = pageVO.getTotalRecord();
         pageVO.setTotalPage((int)Math.ceil(totalRecord/(double)pageVO.getNumPerPage()));
         pageVO.setTotalBlock((int) Math.ceil((double) pageVO.getTotalPage()/ pageVO.getPagePerBlock()));

         if(cPage != null) {
            pageVO.setNowPage(Integer.parseInt(cPage));
         }else {
            pageVO.setNowPage(1);
         }
         pageVO.setBeginPerPage((pageVO.getNowPage() - 1) * pageVO.getNumPerPage() + 1);
         pageVO.setEndPerPage((pageVO.getBeginPerPage()-1) + pageVO.getNumPerPage());
         Map<String, String> map = new HashMap<String,String>();
         map.put("begin",String.valueOf(pageVO.getBeginPerPage()));
         map.put("end",String.valueOf(pageVO.getEndPerPage()));
         map.putAll(paramMap);
         for(Map.Entry<String , String> e : map.entrySet()) {
            System.out.println(e.getKey()+","+e.getValue());
         }
         List<ProductVO> list = productDaoInter.productList(map);
         System.out.println("Size : " + list.size());
         int StartPage = (int)((pageVO.getNowPage() - 1) / pageVO.getPagePerBlock()) * pageVO.getPagePerBlock() +1;
         int endpage = StartPage + pageVO.getPagePerBlock() - 1 ;
         if(endpage > pageVO.getTotalPage()) {
            endpage = pageVO.getTotalPage();
         }
         model.addAttribute("startPage",StartPage);
         model.addAttribute("endPage",endpage);
         model.addAttribute("page",pageVO);
         model.addAttribute("list",list);
         model.addAttribute("searchType",map.get("searchType"));
         model.addAttribute("searchValue",map.get("searchValue"));
         
         //대분류 카테고리를 모델에 추가
         model.addAttribute("lclist", productDaoInter.lcList());
         
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

	@GetMapping("/prDetail")
	public String prDetail(int pnum, Model m) {
		m.addAttribute("lcategory", productDaoInter.prDetail(pnum));
		return "product/prDetail";
	}

}
