package com.itwillbs.domain;

public class StockDTO {
	
	
	private int whseCount;
	private String rawCode;
	private String prodCode;
	private String whseCode;
	
	
	
	
	@Override
	public String toString() {
		return "StockDTO [ whseCount=" + whseCount + ", rawCode=" + rawCode + ", prodCode=" + prodCode
				+ ", whseCode=" + whseCode + "]";
	}
	
	
	public int getWhseCount() {
		return whseCount;
	}
	public void setWhseCount(int whseCount) {
		this.whseCount = whseCount;
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
	

}
