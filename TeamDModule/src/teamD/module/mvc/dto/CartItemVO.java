package teamD.module.mvc.dto;

public class CartItemVO {
	private String id; // 로그인 한 아이디
	private int pnum; // 상품 번호
	private int qty; // 담은 수량
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getPnum() {
		return pnum;
	}
	public void setPnum(int pnum) {
		this.pnum = pnum;
	}
	public int getQty() {
		return qty;
	}
	public void setQty(int qty) {
		this.qty = qty;
	}
}
