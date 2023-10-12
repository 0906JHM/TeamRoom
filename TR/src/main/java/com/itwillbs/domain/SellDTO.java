package com.itwillbs.domain;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
public class SellDTO {
	 
	private String sellCode; //수주코드
	private String sellDate; //수주일자
	private String sellDuedate; //납기일자
	private String sellEmpId; //수주담당직원 ID
	private int sellCount; //수주 수량
	private String prodCode; //제품코드
	private String prodName; //제품명
	private String sellFile; //수주파일원본
	private String sellMemo; //수주 비고
	private String sellState; //수주상태
	private String clientCode; //거래처코드
	private int sellNum; //수주번호
	private String sellPrice;
	
	
	
}//class
