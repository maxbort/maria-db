package bookmall.vo;

public class OrderVo {	
	
	private Long no;
	private Long member_no;
	private String order_no;
	private int total_price;
	private String address;
	private String status;
	public Long getNo() {
		return no;
	}
	public void setNo(Long no) {
		this.no = no;
	}
	public Long getUserNo() {
		return member_no;
	}
	public void setUserNo(Long member_no) {
		this.member_no = member_no;
	}
	public String getNumber() {
		return order_no;
	}
	public void setNumber(String order_no) {
		this.order_no = order_no;
	}
	public int getPayment() {
		return total_price;
	}
	public void setPayment(int total_price) {
		this.total_price = total_price;
	}
	public String getShipping() {
		return address;
	}
	public void setShipping(String address) {
		this.address = address;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	
	
	
	
	
}
