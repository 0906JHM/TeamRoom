package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.dao.RawmaterialsDAO;
import com.itwillbs.domain.RawmaterialsDTO;

@Service 
public class RawmaterialsService implements RawmaterialsService2 {

	// RawmaterialsDAO 객체생성
	@Inject
	private RawmaterialsDAO rawmaterialsDAO;

	public void insertRawmaterials(RawmaterialsDTO rawmaterialsDTO) {
		System.out.println("RawmaterialsService insertRawmaterials()");
		rawmaterialsDAO.insertRawmaterials(rawmaterialsDTO);
	}

	public List<RawmaterialsDTO> getRawmaterialsList() {
		System.out.println("RawmaterialsService getRawmaterialsList()");
		return rawmaterialsDAO.getRawmaterialsList();
	}

	public List<RawmaterialsDTO> getRawmaterialsSearchList(RawmaterialsDTO rawmaterialsDTO) {
		System.out.println("RawmaterialsService getRawmaterialsSearchList()");
		return rawmaterialsDAO.getRawmaterialsSearchList(rawmaterialsDTO);
	}

	// 체크박스로 선택삭제
	@Override
	public void delete(String rawCode){
		rawmaterialsDAO.delete(rawCode);
	}

	public RawmaterialsDTO getDetail(String rawCode) {
		System.out.println("RawmaterialsService getDetail()");
		return rawmaterialsDAO.getDetail(rawCode);
	}

	public void updateRawmaterials(RawmaterialsDTO rawmaterialsDTO) {
		System.out.println("RawmaterialsService updateRawmaterials()");
		rawmaterialsDAO.updateRawmaterials(rawmaterialsDTO);
	}
	
}
