package teamD.module.mvc.dto;

public class SCategoryVO {
	private int scnum; // 소분류 번호. 시퀀스 
	private String scname; // 소분류 이름
	private int lcnum; // 대분류 번호. 시퀀스. 외래키
	
	public int getScnum() {
		return scnum;
	}
	public void setScnum(int scnum) {
		this.scnum = scnum;
	}
	public String getScname() {
		return scname;
	}
	public void setScname(String scname) {
		this.scname = scname;
	}
	public int getLcnum() {
		return lcnum;
	}
	public void setLcnum(int lcnum) {
		this.lcnum = lcnum;
	}
	
	
	
}
