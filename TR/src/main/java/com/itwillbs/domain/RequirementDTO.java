  package com.itwillbs.domain;
  
  import lombok.Data;
  
  @Data public class RequirementDTO {
	  private String reqCode;
	  private String prodCode;
	  private String rawCode;
	  private String reqAmount;
	  private String reqMemo; 
	  
		/*
		 * @Override public String toString() { return "RequirementDTO [reqCode=" +
		 * reqCode + ", prodCode=" + prodCode + ", rawCode=" + rawCode + ", reqAmount="
		 * + reqAmount + ", reqMemo=" + reqMemo+"]"; }
		 */

	  
		
		 private ProdDTO prod;
			/* private RawMaterialDTO raw; */
		 
  
		
		 public RequirementDTO() {
		 prod = new ProdDTO();
			/* raw = new RawMaterialDTO(); */
		 }
		
  
  
  } //Requirements
 