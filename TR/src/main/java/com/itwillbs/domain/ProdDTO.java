package com.itwillbs.domain;

public class ProdDTO {
	private String prodCode;
	private String prodName;
	private String prodUnit;
	private String prodSize;
	private String prodPerfume;
	private String clientCode;
	private String whseCode;
	private float prodPrice;
	private String prodMemo;
	
	
	@Override
	public String toString() {
		return "ProdDTO [prodCode=" + prodCode + ", prodName=" + prodName + ", prodUnit=" + prodUnit + ", prodSize="
				+ prodSize + ", prodPerfume=" + prodPerfume + ", clientCode=" + clientCode + ", whseCode=" + whseCode
				+ ", prodPrice=" + prodPrice + ", prodMemo=" + prodMemo + "]";
	}

//	ctrl alt s
	public String getProdCode() {
		return prodCode;
	}


	public void setProdCode(String prodCode) {
		this.prodCode = prodCode;
	}


	public String getProdName() {
		return prodName;
	}


	public void setProdName(String prodName) {
		this.prodName = prodName;
	}


	public String getProdUnit() {
		return prodUnit;
	}


	public void setProdUnit(String prodUnit) {
		this.prodUnit = prodUnit;
	}


	public String getProdSize() {
		return prodSize;
	}


	public void setProdSize(String prodSize) {
		this.prodSize = prodSize;
	}


	public String getProdPerfume() {
		return prodPerfume;
	}


	public void setProdPerfume(String prodPerfume) {
		this.prodPerfume = prodPerfume;
	}


	public String getClientCode() {
		return clientCode;
	}


	public void setClientCode(String clientCode) {
		this.clientCode = clientCode;
	}


	public String getWhseCode() {
		return whseCode;
	}


	public void setWhseCode(String whseCode) {
		this.whseCode = whseCode;
	}


	public float getProdPrice() {
		return prodPrice;
	}


	public void setProdPrice(float prodPrice) {
		this.prodPrice = prodPrice;
	}


	public String getProdMemo() {
		return prodMemo;
	}


	public void setProdMemo(String prodMemo) {
		this.prodMemo = prodMemo;
	}
	
	
}
