package com.itwillbs.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;


import com.itwillbs.dao.OpenlistDAO;
import com.itwillbs.dao.RequirementDAO;
import com.itwillbs.domain.ClientDTO;
import com.itwillbs.domain.LineDTO;
import com.itwillbs.domain.ProdDTO;
import com.itwillbs.domain.RawmaterialsDTO;
import com.itwillbs.domain.RequirementDTO;
import com.itwillbs.domain.RequirementPageDTO;
import com.itwillbs.domain.SellDTO;
import com.itwillbs.domain.WarehouseDTO;


@Service
public class OpenlistService {

	@Inject
	private OpenlistDAO pdao;

	// 품목관리 총 갯수
	
	public int countProd() {
		return pdao.countProd();
	}

	
	  // 품목관리 리스트 불러오기
	  
	  public List<ProdDTO> getProdList(RequirementPageDTO pdto) throws Exception {
	  return pdao.readProdList(pdto); }
	 

	
	  // 품목관리 검색리스트 갯수 불러오기
	  
	   public int countProd(ProdDTO dto) { return pdao.countProd(dto);
	  }
	 

	
	  // 품목관리 검색리스트 불러오기
	  
	   public List<ProdDTO> getProdList(ProdDTO dto, RequirementPageDTO pdto)
	  throws Exception {
	  
	  return pdao.readProdList(dto, pdto); }
	 


	// ==========================================================================

	// 원자재관리 총 갯수
	
	public int countRaw() {
		return pdao.countRaw();
	}

	
	  // 원자재관리 전체 리스트
	  
	   public List<RawmaterialsDTO> getRawList(RequirementPageDTO pdto) throws Exception
	   { return pdao.readRawList(pdto);
	  }
	 

	
	  // 원자재관리 검색 갯수
	  
	   public int countRaw(RawmaterialsDTO dto) { return
	  pdao.countRaw(dto); }
	 
	
	  // 원자재관리 검색 리스트
	  
	   public List<RawmaterialsDTO> getRawList(RawmaterialsDTO dto,
	  RequirementPageDTO pdto) throws Exception { return pdao.readRawList(dto, pdto); }
	   
	// ==========================================================================

		// 거래처목록 총 갯수
		
		public int countClient() {
			return pdao.countClient();
		}
		public int buycountClient() {
			return pdao.buycountClient();
		}
		public int sellcountClient() {
			return pdao.sellcountClient();
		}

		
		  // 거래처목록 전체 리스트
		  
		   public List<ClientDTO> getClientList(RequirementPageDTO pdto) throws Exception
		   { return pdao.readClientList(pdto);
		  }
		   public List<ClientDTO> buygetClientList(RequirementPageDTO pdto) throws Exception
		   { return pdao.buyreadClientList(pdto);
		  }
		   public List<ClientDTO> sellgetClientList(RequirementPageDTO pdto) throws Exception
		   { return pdao.sellreadClientList(pdto);
		  }
		 

		
		  // 거래처목록 검색 갯수
		  
		   public int countClient(ClientDTO dto) { return
		  pdao.countClient(dto); }
		   
		   public int buycountClient(ClientDTO dto) { return
					  pdao.buycountClient(dto); }
		   
		   public int sellcountClient(ClientDTO dto) { return
					  pdao.sellcountClient(dto); }
		 
		
		  // 거래처목록 검색 리스트
		  
		   public List<ClientDTO> getClientList(ClientDTO dto,
		  RequirementPageDTO pdto) throws Exception { return pdao.readClientList(dto, pdto); }
		   
		   public List<ClientDTO> buygetClientList(ClientDTO dto,
					  RequirementPageDTO pdto) throws Exception { return pdao.buyreadClientList(dto, pdto); }
		   
		   public List<ClientDTO> sellgetClientList(ClientDTO dto,
					  RequirementPageDTO pdto) throws Exception { return pdao.sellreadClientList(dto, pdto); }
	 

		// ==========================================================================

			// 수주목록 총 갯수
			
			public int countSell() {
				return pdao.countSell();
			}

			
			  // 수주목록 전체 리스트
			  
			   public List<SellDTO> getSellList(RequirementPageDTO pdto) throws Exception
			   { return pdao.readSellList(pdto);
			  }
			 

			
			  // 수주목록 검색 갯수
			  
			   public int countSell(SellDTO dto) { return
			  pdao.countSell(dto); }
			 
			
			  // 수주목록 검색 리스트
			  
			   public List<SellDTO> getSellList(SellDTO dto,
			  RequirementPageDTO pdto) throws Exception { return pdao.readSellList(dto, pdto); }
			   
			   
			// ==========================================================================

				// 거래처목록 총 갯수
				
				public int countWhse() {
					return pdao.countWhse();
				}

				
				  // 거래처목록 전체 리스트
				  
				   public List<WarehouseDTO> getWhseList(RequirementPageDTO pdto) throws Exception
				   { return pdao.readWhseList(pdto);
				  }
				 

				
				  // 거래처목록 검색 갯수
				  
				   public int countWhse(WarehouseDTO dto) { return
				  pdao.countWhse(dto); }
				 
				
				  // 거래처목록 검색 리스트
				  
				   public List<WarehouseDTO> getWhseList(WarehouseDTO dto,
				  RequirementPageDTO pdto) throws Exception { return pdao.readWhseList(dto, pdto); }

				   
				   ////////////////////////////////////////////////
				   
				   //라인 목록 갯수 검사
				public int countline(LineDTO dto) {
					
					return pdao.countline(dto);
				}


				public List<LineDTO> getlineList(RequirementPageDTO pdto) throws Exception {
					
					return pdao.readlinelist(pdto);
					
				}

				
		 
	// ==========================================================================

	/*
	 * // 소요량관리 게시물 총 갯수
	 * 
	 * public int countReq() { return pdao.countReq(); }
	 * 
	 * // 소요량관리 리스트 불러오기
	 * 
	 * public List<RequirementDTO> getReqList(RequirementPageDTO pdto) throws
	 * Exception { return pdao.readReqList(pdto); }
	 * 
	 * // 소요량관리 게시물 검색 갯수
	 * 
	 * public int countReq(RequirementDTO dto) throws Exception { return
	 * pdao.countReq(dto); }
	 * 
	 * // 소요량관리 검색리스트 불러오기
	 * 
	 * public List<RequirementDTO> getReqList(RequirementDTO dto, RequirementPageDTO
	 * pdto) throws Exception { return pdao.readReqList(dto, pdto); }
	 * 
	 * // 소요량관리 추가버튼 클릭 시 품번코드 가져가기
	 * 
	 * public String getReqCode() { return pdao.readReqCode(); }
	 * 
	 * // 소요량관리 정보 다중 저장
	 * 
	 * public void insertReq(List<RequirementDTO> req) throws Exception {
	 * 
	 * for (RequirementDTO reqs : req) { if(reqs.getReqCode() != null) {
	 * System.out.println("@@@@@@@@@@@@@@"+reqs.getReqCode());
	 * pdao.insertReqList(reqs); } } }
	 * 
	 * // 소요량관리 삭제
	 * 
	 * public void removeReq(List<String> checked) throws Exception {
	 * pdao.deleteReq(checked); }
	 * 
	 * // 소요량관리 수정 시 기존 데이터 가져가기
	 * 
	 * public RequirementDTO getReq(String ReqCode) throws Exception { return
	 * pdao.getReq(ReqCode); }
	 * 
	 * // 소요량관리 수정
	 * 
	 * public void modifyReq(RequirementDTO udto) throws Exception {
	 * pdao.updateReq(udto); }
	 */
	// 라인=======================================================================

	/*
	 * // 라인 조회
	 * 
	 * public List<LineDTO> getLineList() throws Exception { return
	 * pdao.getLineList(); }
	 * 
	 * // 라인 조회 (페이징처리)
	 * 
	 * public List<LineDTO> getLineListPage(LineWhPageDTO dto) throws Exception {
	 * return pdao.getLineListPage(dto); }
	 * 
	 * // 라인 검색 (페이징 처리)
	 * 
	 * public List<LineDTO> getSearchLinePage(LineWhPageDTO dto, LineDTO ldto)
	 * throws Exception { return pdao.getSearchLinePage(dto, ldto); }
	 * 
	 * // 게시판 총 글 개수 계산
	 * 
	 * public int getTotalCount() throws Exception {
	 * 
	 * return pdao.getTotalCount(); }
	 * 
	 * // 게시판 총 글 개수 계산 (서치)
	 * 
	 * public int getSearchTotalCount(LineDTO ldto) throws Exception {
	 * 
	 * return pdao.getSearchTotalCount(ldto); }
	 * 
	 * // 라인 추가
	 * 
	 * public void registLine(LineDTO ldto, String emp_id) throws Exception {
	 * 
	 * pdao.registLine(ldto, emp_id); }
	 * 
	 * // 라인 삭제
	 * 
	 * public void deleteLine(List<String> checked) throws Exception {
	 * 
	 * pdao.deleteLine(checked); }
	 * 
	 * // 라인 수정
	 * 
	 * public void modifyLine(LineDTO ldto) throws Exception {
	 * 
	 * pdao.modifyLine(ldto); }
	 * 
	 * // 라인 조회(String line_code)
	 * 
	 * public LineDTO getLine(String line_code) throws Exception {
	 * 
	 * return pdao.getLine(line_code); }
	 * 
	 * 
	 * // 라인 추가 시 코드값 가져가기
	 * 
	 * public String getLiCode(String line_place) throws Exception {
	 * 
	 * return pdao.getLiCode(line_place); }
	 * 
	 * 
	 * // 창고=======================================================================
	 * 
	 * // 창고 목록 조회 + 페이징처리
	 * 
	 * public List<WarehouseDTO> getWh_prodListPage(LineWhPageDTO dto) throws
	 * Exception {
	 * 
	 * return pdao.getWh_prodListPage(dto); }
	 * 
	 * // 창고 조회 총 글 개수 계산
	 * 
	 * public int getWh_TotalCount() throws Exception {
	 * 
	 * return pdao.getWh_TotalCount(); }
	 * 
	 * // 창고 검색 + 페이징처리
	 * 
	 * public List<WarehouseDTO> searchWarehousePage(LineWhPageDTO dto, Wh_prodDTO
	 * wdto) throws Exception {
	 * 
	 * return pdao.searchWarehousePage(dto, wdto); }
	 * 
	 * // 검색시 총 글 개수 계산
	 * 
	 * public int searchWh_TotalCount(Wh_prodDTO wdto) throws Exception {
	 * 
	 * return pdao.searchWh_TotalCount(wdto); }
	 * 
	 * // 창고 추가
	 * 
	 * public void registWh(Wh_prodDTO wdto, String emp_id) throws Exception {
	 * 
	 * pdao.registWh(wdto, emp_id); }
	 * 
	 * // 창고 삭제
	 * 
	 * public void deleteWh(List<String> checked) throws Exception {
	 * 
	 * pdao.deleteWh(checked); }
	 * 
	 * // 창고 수정
	 * 
	 * public void modifyWh(Wh_prodDTO wdto) throws Exception {
	 * 
	 * pdao.modifyWh(wdto); }
	 * 
	 * // 창고 조회(String wh_code)
	 * 
	 * public Wh_prodDTO getWarehouse(String wh_code) throws Exception {
	 * 
	 * return pdao.getWarehouse(wh_code); }
	 * 
	 * // 창고 추가 선택 시 코드 가져오기
	 * 
	 * public String getWhCode() {
	 * 
	 * return pdao.getWhCode(); }
	 */

	// ==========================================================================

	/*
	 * // 생산실적 목록
	 * 
	 * public List<RequirementDTO> getPerfList(LineWhPageDTO pdto) throws Exception
	 * { return pdao.readPerfList(pdto);
	 * 
	 * } // getAllPerf()
	 * 
	 * // 생산실적 등록
	 * 
	 * public void regRequirement(RequirementDTO dto) throws Exception {
	 * pdao.createRequirement(dto); } // regRequirement()
	 * 
	 * // 생산실적 삭제
	 * 
	 * public void removeRequirement(List<String> checked) throws Exception {
	 * pdao.deleteRequirement(checked); } // removeRequirement()
	 * 
	 * // 생산실적 조회
	 * 
	 * public RequirementDTO getRequirementInfo(String performCode) throws Exception
	 * { return pdao.readRequirementInfo(performCode); } // getRequirementInfo()
	 * 
	 * // 생산실적 수정
	 * 
	 * public void modifyRequirement(RequirementDTO udto) throws Exception {
	 * pdao.updateRequirement(udto); } // modifyRequirement()
	 * 
	 * // 생산실적 전체 수
	 * 
	 * public int getPerfCnt() throws Exception { return pdao.getPerfCnt(); } //
	 * getAllPerfCnt()
	 * 
	 * // 생산실적 검색
	 * 
	 * public List<RequirementDTO> getPerfList(HashMap<String, Object> search)
	 * throws Exception { return pdao.readPerfList(search); } // getPerfList(search)
	 * 
	 * // 생산실적 검색 수
	 * 
	 * public int getPerfCnt(HashMap<String, Object> search) throws Exception {
	 * return pdao.getPerfCnt(search); } // getPerfCnt(search)
	 * 
	 * // 실적현황 - 양불수
	 * 
	 * public Map<String, List<RequirementDTO>> getPerformStatus() throws Exception
	 * { return pdao.getPerformStatus();
	 * 
	 * } //getPerformStatus()
	 * 
	 * 
	 * public List<RequirementDTO> getReqList(RequirementPageDTO pDTO) throws
	 * Exception { // TODO Auto-generated method stub return null; }
	 * 
	 * 
	 * public int countReq(RequirementDTO DTO) throws Exception { // TODO
	 * Auto-generated method stub return 0; }
	 * 
	 * 
	 * public List<RequirementDTO> getReqList(RequirementDTO DTO, RequirementPageDTO
	 * pDTO) throws Exception { // TODO Auto-generated method stub return null; }
	 * 
	 * 
	 * public void insertReq(List<RequirementDTO> req) throws Exception { // TODO
	 * Auto-generated method stub
	 * 
	 * }
	 * 
	 * 
	 * public RequirementDTO getReq(String req_code) throws Exception { // TODO
	 * Auto-generated method stub return null; }
	 * 
	 * 
	 * public void modifyReq(RequirementDTO uDTO) throws Exception { // TODO
	 * Auto-generated method stub
	 * 
	 * }
	 * 
	 * 
	 * public void removePerformance(List<String> checked) throws Exception { //
	 * TODO Auto-generated method stub
	 * 
	 * }
	 */
	






}
