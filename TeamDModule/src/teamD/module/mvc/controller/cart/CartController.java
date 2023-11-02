package teamD.module.mvc.controller.cart;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import teamD.module.mvc.controller.cartService.CartService;
import teamD.module.mvc.dao.CartDaoInter;
import teamD.module.mvc.dto.CartItemVO;

@Controller
public class CartController {
	
	@Autowired
	private CartDaoInter cartdaoInter;
	
	@Autowired
	private CartService cartService;
	
	// 장바구니 추가
	@RequestMapping("/addCart")
	public String addCart(CartItemVO vo, int pnum, HttpSession session) {
		String id = String.valueOf(session.getAttribute("sessionID")); // 세션에 담겨 있는 아이디
		vo.setId(id);
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("pnum", String.valueOf(pnum));
		
		cartService.addCart(vo, map);
		
		return "redirect:cartList";
	}
	
	// 장바구니 리스트
	@GetMapping("/cartList")
	public String cartList(HttpSession session, Model m) {
		String id = String.valueOf(session.getAttribute("sessionID")); // 세션에 담겨 있는 아이디
		
		m.addAttribute("list", cartdaoInter.cartList(id));
		
		return "cart/cartList";
	}
	
	// 장바구니 삭제
	@PostMapping("/cartDelete")
	public String cartDelete(HttpSession session, int pnum) {
		String id = String.valueOf(session.getAttribute("sessionID")); // 세션에 담겨 있는 아이디
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("pnum", String.valueOf(pnum));
		
		cartService.deleteCart(map);
		
		return "redirect:cartList";
	}
	
}
