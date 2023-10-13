package com.itwillbs.domain;

public class StockDTO {
	
	
	private int stockCount;
	private String rawCode;
	private String prodCode;
	private String whseCode;
	private int stockNum;
	
	public int getStockCount() {
		return stockCount;
	}
	@Override
	public String toString() {
		return "StockDTO [stockCount=" + stockCount + ", rawCode=" + rawCode + ", prodCode=" + prodCode + ", whseCode="
				+ whseCode + ", stockNum=" + stockNum + "]";
	}
	public void setStockCount(int stockCount) {
		this.stockCount = stockCount;
	}
	public String getRawCode() {
		return rawCode;
	}
	public void setRawCode(String rawCode) {
		this.rawCode = rawCode;
	}
	public String getProdCode() {
		return prodCode;
	}
	public void setProdCode(String prodCode) {
		this.prodCode = prodCode;
	}
	public String getWhseCode() {
		return whseCode;
	}
	public void setWhseCode(String whseCode) {
		this.whseCode = whseCode;
	}


	public int getStockNum() {
		return stockNum;
	}


	public void setStockNum(int stockNum) {
		this.stockNum = stockNum;
	}


	
	

}
