package com.itwillbs.domain;

public class EmployeesDTO {
	
	private String empId;
	private String empPass;
	private String empName;
	private String empDepartment;
	private String empPosition;
	private String empEmail;
	private String empTel;
	private String empHiredate;
	private String empState;
	
	
	
	@Override
	public String toString() {
		return "EmployeesDTO [empId=" + empId + ", empPass=" + empPass + ", empName=" + empName + ", empDepartment="
				+ empDepartment + ", empPosition=" + empPosition + ", empEmail=" + empEmail + ", empTel=" + empTel
				+ ", empHiredate=" + empHiredate + ", empState=" + empState + "]";
	}
	public String getEmpId() {
		return empId;
	}
	public void setEmpId(String empId) {
		this.empId = empId;
	}
	public String getEmpPass() {
		return empPass;
	}
	public void setEmpPass(String empPass) {
		this.empPass = empPass;
	}
	public String getEmpName() {
		return empName;
	}
	public void setEmpName(String empName) {
		this.empName = empName;
	}
	public String getEmpDepartment() {
		return empDepartment;
	}
	public void setEmpDepartment(String empDepartment) {
		this.empDepartment = empDepartment;
	}
	public String getEmpPosition() {
		return empPosition;
	}
	public void setEmpPosition(String empPosition) {
		this.empPosition = empPosition;
	}
	public String getEmpEmail() {
		return empEmail;
	}
	public void setEmpEmail(String empEmail) {
		this.empEmail = empEmail;
	}
	public String getEmpTel() {
		return empTel;
	}
	public void setEmpTel(String empTel) {
		this.empTel = empTel;
	}
	public String getEmpHiredate() {
		return empHiredate;
	}
	public void setEmpHiredate(String empHiredate) {
		this.empHiredate = empHiredate;
	}
	public String getEmpState() {
		return empState;
	}
	public void setEmpState(String empState) {
		this.empState = empState;
	}
	
	

}
