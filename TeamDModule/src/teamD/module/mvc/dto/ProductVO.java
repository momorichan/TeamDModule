package teamD.module.mvc.dto;

public class ProductVO {
	private int pnum; // 상품 번호. 시퀀스
	private String pname; // 상품 이름.
	private int price; // 상품 가격
	private int scnum; // 소분류 번호
	private int stock; // 상품 재고
	private String pdetail; // 상품 상세 설명
	private String image; // 상품 이미지
	private String image2; // 상품 이미지
	private String image3; // 상품 이미지
	
	public int getPnum() {
		return pnum;
	}
	public void setPnum(int pnum) {
		this.pnum = pnum;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getScnum() {
		return scnum;
	}
	public void setScnum(int scnum) {
		this.scnum = scnum;
	}
	public int getStock() {
		return stock;
	}
	public void setStock(int stock) {
		this.stock = stock;
	}
	public String getPdetail() {
		return pdetail;
	}
	public void setPdetail(String pdetail) {
		this.pdetail = pdetail;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getImage2() {
		return image2;
	}
	public void setImage2(String image2) {
		this.image2 = image2;
	}
	public String getImage3() {
		return image3;
	}
	public void setImage3(String image3) {
		this.image3 = image3;
	}
	
	

}
