package bookmall.vo;

public class CartVo {

	private Long book_no;
	private Long member_no;
	private int quantity;
	private String book_title;

	public String getBookTitle() {
		return book_title;
	}
	public void setBookTitle(String book_title) {
		this.book_title = book_title;
	}
	public Long getBookNo() {
		return book_no;
	}
	public void setBookNo(Long book_no) {
		this.book_no = book_no;
	}
	public Long getUserNo() {
		return member_no;
	}
	public void setUserNo(Long member_no) {
		this.member_no = member_no;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	@Override
	public String toString() {
		return "CartVo [book_no=" + book_no + ", member_no=" + member_no + ", quantity=" + quantity + ", book_title="
				+ book_title + "]";
	}
	
		
}
