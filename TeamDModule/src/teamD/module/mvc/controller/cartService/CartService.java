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

	// 카트에 상품을 추가할 때
	// 1. cartitem 테이블에 상품 추가
	// 2. cartitem_log 테이블에 로그 추가
	// 3. 위 과정중 하나라도 오류 발생 시 롤백시키 위해 transaction 사용
	@Transactional
	public void addCart(CartItemVO vo, Map<String, String> map) {

		if (cartDaoInter.checkCart(map) == 0) { // 카트에 상품이 없을시 카트 테이블에 추가
			cartDaoInter.cartInsert(vo);
			cartDaoInter.log_cartAdd(map);

		} else { // 카트에 상품이 있을시 카트 테이블 수량 업데이트
			cartDaoInter.cartUpdate(vo);

		}

	}

	@Transactional
	public void deleteCart(Map<String, String> map) {
		// 둘다 삭제
		cartDaoInter.cartDelete(map);
		cartDaoInter.log_cartDelete(map);

	}

}
