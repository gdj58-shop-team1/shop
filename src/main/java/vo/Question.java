package vo;

public class Question {
	private int questionCode;
	private int orderCode;
	private String category;
	private String questionTitle;
	private String questionMemo;
	private String createdate;
	
	public int getQuestionCode() {
		return questionCode;
	}
	public void setQuestionCode(int questionCode) {
		this.questionCode = questionCode;
	}
	public int getOrderCode() {
		return orderCode;
	}
	public void setOrderCode(int orderCode) {
		this.orderCode = orderCode;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getQuestionTitle() {
		return questionTitle;
	}
	public void setQuestionTitle(String questionTitle) {
		this.questionTitle = questionTitle;
	}
	public String getQuestionMemo() {
		return questionMemo;
	}
	public void setQuestionMemo(String questionMemo) {
		this.questionMemo = questionMemo;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	
}
