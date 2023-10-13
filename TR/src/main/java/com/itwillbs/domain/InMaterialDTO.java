package com.itwillbs.domain;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class InMaterialDTO {
	private String inNum;
	private String inDate;
	private int inCount;
	private int inPrice;
	private String rawCode;
	private String rawName;
	private float rawPrice;
	private String buyNum;
	private String inEmpId;
	private String clientCode;
	private String clientCompany;
	private int stockCount;
	private String inState;
//	비고 필요없나
	private String inMemo;
	
	
	
//	페이징 처리를 위한 DTO 
	private int pageSize;	//표현할 게시물 수
	private String pageNum;	//현재페이지
	private int currentPage;//현재페이지
	private int startRow;	//시작하는 게시물
	private int endRow;		//끝나는 게시물
	
	private int count;		//게시물의 총개수 
	private int startPage;	//시작하는 페이지
	private int endPage;	//끝나는 페이지
	private int pageBlock;  //페이지 크기
	private int pageCount;	//한 페이지에 보여주는 페이지 개수
}
