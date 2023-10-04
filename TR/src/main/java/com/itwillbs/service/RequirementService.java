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

import com.itwillbs.dao.RequirementDAO;
import com.itwillbs.domain.RequirementDTO;
import com.itwillbs.domain.RequirementPageDTO;


@Service
public class RequirementService {

	@Inject
	private RequirementDAO pdao;

	// 품목관리 총 갯수
	
	public int countProd() {
		return pdao.countProd();
	}

	/*
	 * // 품목관리 리스트 불러오기
	 * 
	 *  public List<ProductDTO> getProdList(RequirementPageDTO pdto) throws
	 * Exception { return pdao.readProdList(pdto); }
	 */

	/*
	 * // 품목관리 검색리스트 갯수 불러오기
	 * 
	 *  public int countProd(ProductDTO dto) { return pdao.countProd(dto);
	 * }
	 */

	/*
	 * // 품목관리 검색리스트 불러오기
	 * 
	 *  public List<ProductDTO> getProdList(ProductDTO dto, RequirementPageDTO pdto)
	 * throws Exception {
	 * 
	 * return pdao.readProdList(dto, pdto); }
	 */

	// 품목관리 추가버튼 클릭 시 품번코드 가져가기
	
	public String getProdCode() {
		return pdao.readProdCode();
	}

	/*
	 * // 품목관리 정보 다중
	 * 
	 *  public void insertProd(List<ProductDTO> products) { for (ProductDTO
	 * product : products) { pdao.insertProdList(product); } }
	 */

	// 품목관리 삭제
	
	public void removeProd(List<String> checked) throws Exception {
		pdao.deleteProd(checked);
	}

	/*
	 * // 품목관리 수정 시 기존 데이터 가져가기
	 * 
	 *  public ProductDTO getProd(String prod_code) throws Exception {
	 * return pdao.getProd(prod_code); }
	 */

	/*
	 * // 품목관리 수정
	 * 
	 *  public void modifyProd(ProductDTO udto) throws Exception {
	 * pdao.updateProd(udto); }
	 */

	// ==========================================================================

	// 원자재관리 총 갯수
	
	//public int countRaw() {
	//	return pdao.countRaw();
	//}

	/*
	 * // 원자재관리 전체 리스트
	 * 
	 *  public List<RawMaterialDTO> getRawList(RequirementPageDTO pdto) throws
	 * Exception { // TODO Auto-generated method stub return pdao.readRawList(pdto);
	 * }
	 */

	/*
	 * // 원자재관리 검색 갯수
	 * 
	 *  public int countRaw(RawMaterialDTO dto) { return
	 * pdao.countRaw(dto); }
	 */
	/*
	 * // 원자재관리 검색 리스트
	 * 
	 *  public List<RawMaterialDTO> getRawList(RawMaterialDTO dto,
	 * RequirementPageDTO pdto) throws Exception { return pdao.readRawList(dto, pdto); }
	 */

	// 원자재관리 추가버튼 클릭 시 품번코드 가져가기
	
	public String getRawCode() {
		return pdao.readRawCode();
	}

	/*
	 * // 원자재관리 데이터 추가
	 * 
	 *  public void insertRaw(List<RawMaterialDTO> raw) { for
	 * (RawMaterialDTO raws : raw) { pdao.insertRawList(raws); } }
	 */

	// 원자재관리 데이터 삭제
	
	public void removeRaw(List<String> checked) throws Exception {
		pdao.deleteRaw(checked);
	}

	/*
	 * // 원자재관리 수정 시 기존 데이터 가져가기
	 * 
	 *  public RawMaterialDTO getRaw(String raw_code) throws Exception {
	 * return pdao.getRaw(raw_code); }
	 */

	/*
	 * // 원자재관리 수정
	 * 
	 *  public void modifyRaw(RawMaterialDTO udto) throws Exception {
	 * pdao.updateRaw(udto); }
	 */

	// ==========================================================================

	// 소요량관리 게시물 총 갯수
	
	public int countReq() {
		return pdao.countReq();
	}

	// 소요량관리 리스트 불러오기
	
	public List<RequirementDTO> getReqList(RequirementPageDTO pdto) throws Exception {
		return pdao.readReqList(pdto);
	}

	// 소요량관리 게시물 검색 갯수
	
	public int countReq(RequirementDTO dto) throws Exception {
		return pdao.countReq(dto);
	}

	// 소요량관리 검색리스트 불러오기
	
	public List<RequirementDTO> getReqList(RequirementDTO dto, RequirementPageDTO pdto) throws Exception {
		return pdao.readReqList(dto, pdto);
	}

	// 소요량관리 추가버튼 클릭 시 품번코드 가져가기
	
	public String getReqCode() {
		return pdao.readReqCode();
	}

	// 소요량관리 정보 다중 저장
	
	public void insertReq(List<RequirementDTO> req) throws Exception {
		
		for (RequirementDTO reqs : req) {
			if(reqs.getReqCode() != null) {			
				System.out.println("@@@@@@@@@@@@@@"+reqs.getReqCode());
			pdao.insertReqList(reqs);
			}
		}
	}

	// 소요량관리 삭제
	
	public void removeReq(List<String> checked) throws Exception {
		pdao.deleteReq(checked);
	}

	// 소요량관리 수정 시 기존 데이터 가져가기
	
	public RequirementDTO getReq(String ReqCode) throws Exception {
		return pdao.getReq(ReqCode);
	}

	// 소요량관리 수정
	
	public void modifyReq(RequirementDTO udto) throws Exception {
		pdao.updateReq(udto);
	}
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
