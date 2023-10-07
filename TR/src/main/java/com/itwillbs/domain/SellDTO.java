package com.itwillbs.domain;

import java.sql.Timestamp;

public class SellDTO {
	
	private String sellCode; //수주코드
	private Timestamp sellDate; //수주일자
	private Timestamp sellDuedate; //납기일자
	private String sellEmpId; //수주담당직원 ID
	private int sellCount; //수주 수량
	private String prodCode; //제품코드
	private String prodName; //제품명
	private String sellFile; //수주파일원본
	private String sellMemo; //수주 비고
	private String sellState; //수주상태
	private String clientCode; //거래처코드
	private int sellNum; //수주번호
	


	@Override
	public String toString() {
		return "SellDTO [sellCode=" + sellCode + ", sellDate=" + sellDate + ", sellDuedate=" + sellDuedate
				+ ", sellEmpId=" + sellEmpId + ", sellCount=" + sellCount + ", prodCode=" + prodCode + ", prodName="
				+ prodName + ", sellFile=" + sellFile + ", sellMemo=" + sellMemo + ", sellState=" + sellState
				+ ", clientCode=" + clientCode + ", sellNum=" + sellNum + "]";
	}
	// get, set 메서드
	public String getSellCode() {
		return sellCode;
	}
	public void setSellCode(String sellCode) {
		this.sellCode = sellCode;
	}
	public Timestamp getSellDate() {
		return sellDate;
	}
	public void setSellDate(Timestamp sellDate) {
		this.sellDate = sellDate;
	}
	public Timestamp getSellDuedate() {
		return sellDuedate;
	}
	public void setSellDuedate(Timestamp sellDuedate) {
		this.sellDuedate = sellDuedate;
	}
	public String getSellEmpId() {
		return sellEmpId;
	}
	public void setSellEmpId(String sellEmpId) {
		this.sellEmpId = sellEmpId;
	}
	public int getSellCount() {
		return sellCount;
	}
	public void setSellCount(int sellCount) {
		this.sellCount = sellCount;
	}
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
	public String getSellFile() {
		return sellFile;
	}
	public void setSellFile(String sellFile) {
		this.sellFile = sellFile;
	}
	public String getSellMemo() {
		return sellMemo;
	}

	public void setSellMemo(String sellMemo) {
		this.sellMemo = sellMemo;
	}
	public String getSellState() {
		return sellState;
	}
	public void setSellState(String sellState) {
		this.sellState = sellState;
	}
	public String getClientCode() {
		return clientCode;
	}
	public void setClientCode(String clientCode) {
		this.clientCode = clientCode;
	}
	public int getSellNum() {
		return sellNum;
	}

	public void setSellNum(int sellNum) {
		this.sellNum = sellNum;
	}
	
	
	
}//class
