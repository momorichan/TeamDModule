package teamD.module.mvc.dto;

public class CartItem_LogVO {
	private int logid; // 로그 번호. 시퀀스
	private String id; // 로그인한 아이디
	private int scnum; // 소분류 카테고리 
	private String logtime; // 로그 찍힌 시간
	private String status; // 로그 상태, 장바구니 on/off, 구매
	
	public int getLogid() {
		return logid;
	}
	public void setLogid(int logid) {
		this.logid = logid;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getScnum() {
		return scnum;
	}
	public void setScnum(int scnum) {
		this.scnum = scnum;
	}
	public String getLogtime() {
		return logtime;
	}
	public void setLogtime(String logtime) {
		this.logtime = logtime;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	
	
	

}
