package teamD.module.mvc.controller.cartService;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import teamD.module.mvc.dao.CartDaoInter;
import teamD.module.mvc.dto.CartItemVO;

@Service
public class CartService {
	
	@Autowired
	private CartDaoInter cartDaoInter;
	
	@Transactional
	public void addCart(CartItemVO vo, Map<String, String> map) {
		
		if(cartDaoInter.checkCart(map) == 0) { // 카트에 상품이 없을시
			cartDaoInter.cartInsert(vo);
			cartDaoInter.log_cartAdd(map);
			
		} else { // 카트에 상품이 있을시
			cartDaoInter.cartUpdate(vo);
			
		}
	
	}
	
	@Transactional
	public void deleteCart(Map<String, String> map) {
		
			cartDaoInter.cartDelete(map);
			cartDaoInter.log_cartDelete(map);
		
	}
	
}
