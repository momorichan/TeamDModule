package teamD.module.mvc.dao;

import java.util.List;
import java.util.Map;

import teamD.module.mvc.dto.CartItemVO;

public interface CartDaoInter {
	public void cartInsert(CartItemVO vo); // 카트 추가
	public int checkCart(Map<String, String> map); // 유저의 카트에 해당 상품이 존재하는 여부 확인
	public void cartUpdate(CartItemVO vo); // 카트에 존재할시, 개수 업데이트
	public List<CartItemVO> cartList(String id); // 카트 목록
	public void cartDelete(Map<String, String> map); // 카트 삭제
	
	// 로그
	public void log_cartAdd(Map<String, String> map); // 로그 - 카트 추가
	public void log_cartDelete(Map<String, String> map); // 로그 - 카트 삭제
}
