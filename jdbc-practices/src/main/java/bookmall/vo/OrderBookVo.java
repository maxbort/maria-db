package bookmall.vo;

public class OrderBookVo {
	private Long order_no;
	private Long book_no;
	private int count;
	private int payment;
	private String bookTitle;
	
	public String getBookTitle() {
		return bookTitle;
	}
	public void setBookTitle(String bookTitle) {
		this.bookTitle = bookTitle;
	}
	public Long getOrderNo() {
		return order_no;
	}
	public void setOrderNo(Long order_no) {
		this.order_no = order_no;
	}
	public Long getBookNo() {
		return book_no;
	}
	public void setBookNo(Long book_no) {
		this.book_no = book_no;
	}
	public int getQuantity() {
		return count;
	}
	public void setQuantity(int count) {
		this.count = count;
	}
	public int getPrice() {
		return payment;
	}
	public void setPrice(int payment) {
		this.payment = payment;
	}
	
	
	
}
