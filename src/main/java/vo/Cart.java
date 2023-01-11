package vo;

public class Cart {
	private int goodsCode;
	private String customerId;
	private String goodsOption;
	private int cartQuantity;
	private String createdate;
	
	public int getGoodsCode() {
		return goodsCode;
	}
	public void setGoodsCode(int goodsCode) {
		this.goodsCode = goodsCode;
	}
	public String getCustomerId() {
		return customerId;
	}
	public void setCustomerId(String customerId) {
		this.customerId = customerId;
	}
	public String getGoodsOption() {
		return goodsOption;
	}
	public void setGoodsOption(String goodsOption) {
		this.goodsOption = goodsOption;
	}
	public int getCartQuantity() {
		return cartQuantity;
	}
	public void setCartQuantity(int cartQuantity) {
		this.cartQuantity = cartQuantity;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
}
