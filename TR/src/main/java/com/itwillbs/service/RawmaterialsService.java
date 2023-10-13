package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.dao.RawmaterialsDAO;
import com.itwillbs.domain.ClientDTO;
import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.RawmaterialsDTO;
import com.itwillbs.domain.WarehouseDTO;

@Service 
public class RawmaterialsService implements RawmaterialsService2 {
 
	// RawmaterialsDAO 객체생성
	@Inject
	private RawmaterialsDAO rawmaterialsDAO;

	public void insertRawmaterials(RawmaterialsDTO rawmaterialsDTO) {
		System.out.println("RawmaterialsService insertRawmaterials()");

		// 원자재 등록시 글번호 증가
		if(rawmaterialsDAO.getMaxNum() == null) {
			rawmaterialsDTO.setRawNum(1);
		}else {
			rawmaterialsDTO.setRawNum(rawmaterialsDAO.getMaxNum() + 1);
		}
		rawmaterialsDAO.insertRawmaterials(rawmaterialsDTO);
	}

	// home 페이징처리, 검색기능
	public List<RawmaterialsDTO> getRawmaterialsList(PageDTO pageDTO) {
		System.out.println("RawmaterialsService getRawmaterialsList()");
		int startRow = (pageDTO.getCurrentPage()-1)*pageDTO.getPageSize() + 1;
        int endRow = startRow + pageDTO.getPageSize() - 1;
        pageDTO.setStartRow(startRow - 1);
        pageDTO.setEndRow(endRow);
		return rawmaterialsDAO.getRawmaterialsList(pageDTO);
	}
	
	// home 페이징처리, 검색기능
	public int getRawmaterialsCount(PageDTO pageDTO) {
		System.out.println("RawmaterialsService getRawmaterialsCount()");
		return rawmaterialsDAO.getRawmaterialsCount(pageDTO);
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

	// selectclient 페이징처리, 검색기능
	public List<ClientDTO> getClientList(PageDTO pageDTO) {
		System.out.println("RawmaterialsService getClientList()");
		int startRow = (pageDTO.getCurrentPage()-1)*pageDTO.getPageSize() + 1;
        int endRow = startRow + pageDTO.getPageSize() - 1;
        pageDTO.setStartRow(startRow - 1);
        pageDTO.setEndRow(endRow);
		return rawmaterialsDAO.getClientList(pageDTO);
	}

	// selectclient 페이징처리, 검색기능
	public int getClientCount(PageDTO pageDTO) {
		System.out.println("RawmaterialsService getClientCount()");
		return rawmaterialsDAO.getClientCount(pageDTO);
	}
	
	// selectwarehouse 페이징처리, 검색기능
	public List<WarehouseDTO> getWarehouseList(PageDTO pageDTO) {
		System.out.println("RawmaterialsService getWarehouseList()");
		int startRow = (pageDTO.getCurrentPage()-1)*pageDTO.getPageSize() + 1;
		int endRow = startRow + pageDTO.getPageSize() - 1;
		pageDTO.setStartRow(startRow - 1);
		pageDTO.setEndRow(endRow);
		return rawmaterialsDAO.getWarehouseList(pageDTO);
	}

	// selectwarehouse 페이징처리, 검색기능
	public int getWarehouseCount(PageDTO pageDTO) {
		System.out.println("RawmaterialsService getWarehouseCount()");
		return rawmaterialsDAO.getWarehouseCount(pageDTO);
	}

	// 여기서부터 비고코드 수정하기
	public RawmaterialsDTO getSellMemo(String rawCode) {
		System.out.println("SellService getSellMemo()");
		return rawmaterialsDAO.getSellMemo(rawCode);
	}

	public void updateSellMemo(RawmaterialsDTO rawmaterialsDTO) {
		System.out.println("SellService updateSellMemo");
		rawmaterialsDAO.updateSellMemo(rawmaterialsDTO);
	}

	public void insertSellMemo(RawmaterialsDTO rawmaterialsDTO) {
		System.out.println("SellService insertSellMemo()");
		rawmaterialsDAO.insertSellMemo(rawmaterialsDTO);	
	}

	public void sellDelete(RawmaterialsDTO rawmaterialsDTO) {
		System.out.println("SellService sellDelete()");
		rawmaterialsDAO.deleteSell(rawmaterialsDTO);
	}
	
}