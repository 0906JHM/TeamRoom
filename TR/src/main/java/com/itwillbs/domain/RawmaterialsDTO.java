package com.itwillbs.domain;

public class RawmaterialsDTO {
 
	private String rawCode;
	private String rawName;
	private String rawType;
	private String rawUnit;
	private String rawPrice;
	private String clientCode;
	private String whseCode;
	private String rawMemo;
	
	@Override
	public String toString() {
		return "RawmaterialsDTO [rawCode=" + rawCode + ", rawName=" + rawName + ", rawType=" + rawType + ", rawUnit="
				+ rawUnit + ", rawPrice=" + rawPrice + ", clientCode=" + clientCode + ", whseCode=" + whseCode
				+ ", rawMemo=" + rawMemo + "]";
	}

	public String getRawCode() {
		return rawCode;
	}

	public void setRawCode(String rawCode) {
		this.rawCode = rawCode;
	}

	public String getRawName() {
		return rawName;
	}

	public void setRawName(String rawName) {
		this.rawName = rawName;
	}

	public String getRawType() {
		return rawType;
	}

	public void setRawType(String rawType) {
		this.rawType = rawType;
	}

	public String getRawUnit() {
		return rawUnit;
	}

	public void setRawUnit(String rawUnit) {
		this.rawUnit = rawUnit;
	}

	public String getRawPrice() {
		return rawPrice;
	}

	public void setRawPrice(String rawPrice) {
		this.rawPrice = rawPrice;
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

	public String getRawMemo() {
		return rawMemo;
	}

	public void setRawMemo(String rawMemo) {
		this.rawMemo = rawMemo;
	}
	
}
