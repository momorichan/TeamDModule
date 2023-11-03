package teamD.module.mvc.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import teamD.module.mvc.dto.CartItemVO;

@Repository
public class CartDao implements CartDaoInter{

	@Autowired
	private SqlSessionTemplate ss;
	
	// 카트 추가
	@Override
	public void cartInsert(CartItemVO vo) {
		ss.insert("cart.cartAdd", vo);
	}

	// 로그-카트추가
	@Override
	public void log_cartAdd(Map<String, String> map) {
		ss.insert("cart.log_cartAdd", map);
	}

	// 카트에 존재 여부 확인
	@Override
	public int checkCart(Map<String, String> map) {
		
		return ss.selectOne("cart.checkCart", map);
	}
	
	// 카트에 존재시 수량 업데이트
	@Override
	public void cartUpdate(CartItemVO vo) {
		ss.update("cart.cartUpdate", vo);
		
	}

	// 카트리스트 목록을 불러옴
	@Override
	public List<CartItemVO> cartList(String id) {
		return ss.selectList("cart.cartList", id);
	}

	// 카트 삭제
	@Override
	public void cartDelete(Map<String, String> map) {
		ss.delete("cart.cartDelete", map);
		
	}

	// 로그-카트삭제
	@Override
	public void log_cartDelete(Map<String, String> map) {
		ss.insert("cart.log_cartDelete", map);
		
	}
	
	

}
