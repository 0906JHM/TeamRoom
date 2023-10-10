package com.itwillbs.domain;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class inMaterialDTO {
	private String inNum;
	private Date inDate;
	private int inCount;
	private String inMaterial;
	private String buyNum;
	private String inEmpId;
	private String clientCode;
	private String inMemo;
}
