package teamD.module.mvc.dto;

public class LCategoryVO {
	private int lcnum; // 대분류 번호. 시퀀스
	private String lcname; // 대분류 이름
	public int getLcnum() {
		return lcnum;
	}
	public void setLcnum(int lcnum) {
		this.lcnum = lcnum;
	}
	public String getLcname() {
		return lcname;
	}
	public void setLcname(String lcname) {
		this.lcname = lcname;
	}
	

}
