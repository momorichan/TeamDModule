package teamD.module.mvc.dto;

import java.util.List;

public class LCategoryVO {
	private int lcnum; // 대분류 번호. 시퀀스
	private String lcname; // 대분류 이름
	
	private List<SCategoryVO> scategories; // 대분류 카테고리에 속하는 소분류 카테고리들
	
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
	public List<SCategoryVO> getScategories() {
		return scategories;
	}
	public void setScategories(List<SCategoryVO> scategories) {
		this.scategories = scategories;
	}
	

}
