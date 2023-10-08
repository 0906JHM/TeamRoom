package com.itwillbs.dao;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.itwillbs.controller.RequirementController;
import com.itwillbs.domain.ClientDTO;
import com.itwillbs.domain.ProdDTO;
import com.itwillbs.domain.RawmaterialsDTO;
import com.itwillbs.domain.RequirementDTO;
import com.itwillbs.domain.RequirementPageDTO;
import com.itwillbs.service.RequirementService;


@Repository
public class OpenlistDAO {

	@Inject
	private SqlSession sqlSession;
	
	private static final Logger logger = LoggerFactory.getLogger(OpenlistDAO.class);;


	private static final String NAMESPACE = "com.itwillbs.mappers.OpenlistMapper";

	// 품목관리 리스트 총 갯수
	 
	public int countProd() {
		logger.debug(" 품목관리 리스트 갯수 확인 ");
		return sqlSession.selectOne(NAMESPACE + ".countProd");
	}

	
	  // 품목 리스트 불러오기
	  
	    public List<ProdDTO> readProdList(RequirementPageDTO pdto) throws
	  Exception { logger.debug(" 품목관리 전체리스트 DAO "); return
	  sqlSession.selectList(NAMESPACE + ".readProd", pdto); }
	  
	  // 품목관리 검색 리스트 총 갯수
	  
	    public int countProd(ProdDTO dto) { return
	  sqlSession.selectOne(NAMESPACE + ".countSearchProd", dto); }
	  
	
	  // 품목 검색리스트 불러오기
	  
	  public List<ProdDTO> readProdList(ProdDTO dto, RequirementPageDTO pdto)
	  throws Exception {
	  HashMap<String,Object> data = new HashMap<String, Object>();
	  data.put("start", pdto.getStart()); data.put("cntPerPage",
	  pdto.getCntPerPage()); data.put("prodCode", dto.getProdCode());
	  data.put("prodName", dto.getProdName()); 
	  
	  return sqlSession.selectList(NAMESPACE + ".readSearchProd", data); }
	
	// ==========================================================================
	
	// 원자재관리 리스트 총 갯수
	 
	public int countRaw() {
		logger.debug(" 원자재관리 리스트 갯수 확인 ");
		return sqlSession.selectOne(NAMESPACE + ".countRaw");
	}
	
	// 원자재 관리 전체 리스트
	
	    public List<RawmaterialsDTO> readRawList(RequirementPageDTO pdto) throws
	  Exception { logger.debug(" 원자재관리 전체리스트 DAO "); return
	  sqlSession.selectList(NAMESPACE + ".readRaw", pdto); }
	  
	  // 원자재관리 검색 갯수
	  
	    public int countRaw(RawmaterialsDTO dto) { HashMap<String, Object>
	  data = new HashMap<String, Object>();
	  
	  data.put("rawCode", dto.getRawCode()); data.put("rawName",
	  dto.getRawName()); 
	  
	  return sqlSession.selectOne(NAMESPACE + ".countSearchRaw", data); }
	  
	  // 원자재관리 검색리스트
	  
	    public List<RawmaterialsDTO> readRawList(RawmaterialsDTO dto,
	  RequirementPageDTO pdto) throws Exception { HashMap<String, Object> data = new
	  HashMap<String, Object>();
	  
	  data.put("start", pdto.getStart()); data.put("cntPerPage",
	  pdto.getCntPerPage()); data.put("rawCode", dto.getRawCode());
	  data.put("rawName", dto.getRawName());
	  
	  return sqlSession.selectList(NAMESPACE + ".readSearchRaw", data); }
	    
	 // ==========================================================================
		
		// 거래처목록 리스트 총 갯수
		 
		public int countClient() {
			logger.debug(" 거래처목록 리스트 갯수 확인 ");
			return sqlSession.selectOne(NAMESPACE + ".countClient");
		}
		
		// 거래처목록 전체 리스트
		
		    public List<ClientDTO> readClientList(RequirementPageDTO pdto) throws
		  Exception { logger.debug(" 거래처목록 전체리스트 DAO "); return
		  sqlSession.selectList(NAMESPACE + ".readClient", pdto); }
		  
		  // 거래처목록 검색 갯수
		  
		    public int countClient(ClientDTO dto) { HashMap<String, Object>
		  data = new HashMap<String, Object>();
		  
		  data.put("clientCode", dto.getClientCode()); data.put("clientCompany",
		  dto.getClientCompany()); 
		  
		  return sqlSession.selectOne(NAMESPACE + ".countSearchClient", data); }
		  
		  // 거래처목록 검색리스트
		  
		    public List<ClientDTO> readClientList(ClientDTO dto,
		  RequirementPageDTO pdto) throws Exception { HashMap<String, Object> data = new
		  HashMap<String, Object>();
		  
		  data.put("start", pdto.getStart()); data.put("cntPerPage",
		  pdto.getCntPerPage()); data.put("clientCode", dto.getClientCode());
		  data.put("clientCompany", dto.getClientCompany());
		  
		  return sqlSession.selectList(NAMESPACE + ".readSearchClient", data); }

	// ==========================================================================
	
	// 소요량관리 전체 갯수
	 
	public int countReq() {
		logger.debug(" 소요량관리 리스트 갯수 확인 ");
		return sqlSession.selectOne(NAMESPACE + ".countReq");
	}
	
	// 소요량관리 전체리스트
	 
	public List<RequirementDTO> readReqList(RequirementPageDTO pdto) throws Exception {
		logger.debug(" 소요량관리 전체리스트 DAO ");
		return sqlSession.selectList(NAMESPACE + ".readReq", pdto);
	}
	
	// 소요량 검색 갯수
	 
	public int countReq(RequirementDTO dto) {
		HashMap<String, Object> data = new HashMap<String, Object>();

		data.put("reqCode", dto.getReqCode());
		data.put("prodCode", dto.getProdCode());
		data.put("rawCode", dto.getRawCode());
		
		return sqlSession.selectOne(NAMESPACE + ".countSearchReq", data);
	}
	
	// 소요량 검색 리스트
	 
	public List<RequirementDTO> readReqList(RequirementDTO dto, RequirementPageDTO pdto) throws Exception {
		HashMap<String, Object> data = new HashMap<String, Object>();

		data.put("start", pdto.getStart());
		data.put("cntPerPage", pdto.getCntPerPage());
		data.put("reqCode", dto.getReqCode());
		data.put("prodCode", dto.getProdCode());
		data.put("rawCode", dto.getRawCode());

		return sqlSession.selectList(NAMESPACE + ".readSearchReq", data);
	}
	
	// 소요량 추가버튼 클릭 시 품번코드 가져가기
	 
	public String readReqCode() {
		
		String code = "RQ000";
		
		if (sqlSession.selectOne(NAMESPACE + ".readReqCode") == null) {
			return code;
		} else {
			return sqlSession.selectOne(NAMESPACE + ".readReqCode");
		}
		
	}
	
	// 소요량 데이터 추가
	 
	public void insertReqList(RequirementDTO req) {
		sqlSession.insert(NAMESPACE + ".reqIn", req);

	}
	
	// 소요량 데이터 삭제
	 
	public void deleteReq(List<String> checked) throws Exception {
		logger.debug("##### DAO: deleteRaw() 호출");

		Iterator<String> it = checked.iterator();
		int result = 0;

		while (it.hasNext()) {
			String reqCode = it.next();
			result += sqlSession.delete(NAMESPACE + ".deleteReq", reqCode);
		}

		logger.debug("##### DAO: delete 결과 ===> " + result);

	}
	
	// 소요량관리 수정 시 기존데이터 가져가기
	 
	public RequirementDTO getReq(String reqCode) throws Exception {
		return sqlSession.selectOne(NAMESPACE + ".readReqOne", reqCode);
	}

	// 소요량관리 수정
	 
	public void updateReq(RequirementDTO udto) throws Exception {
		sqlSession.update(NAMESPACE + ".updateReq", udto);
	}

	// ==========================================================================

	/*
	 * // 라인 조회
	 * 
	 * public List<LineDTO> getLineList() throws Exception {
	 * logger.debug("@@getLineList() 호출@@");
	 * 
	 * return sqlSession.selectList(NAMESPACE + ".lineList"); }
	 * 
	 * // 라인조회 (페이징처리)
	 * 
	 * public List<LineDTO> getLineListPage(LineWhPageDTO dto) throws Exception {
	 * logger.debug("@@getLineListPage(LineWhPageDTO dto) 호출@@");
	 * 
	 * return sqlSession.selectList(NAMESPACE + ".lineListPage", dto); }
	 * 
	 * // 라인 검색 (페이징처리)
	 * 
	 * public List<LineDTO> getSearchLinePage(LineWhPageDTO dto, LineDTO ldto)
	 * throws Exception {
	 * logger.debug("@@ getSearchLinePage(LineWhPageDTO dto, LineDTO ldto) 호출 @@");
	 * 
	 * Map<String, Object> params = new HashMap<>();
	 * 
	 * params.put("line_code", ldto.getLine_code()); params.put("line_name",
	 * ldto.getLine_name());
	 * 
	 * if (ldto.getLine_use() != 0) { params.put("line_use", ldto.getLine_use()); }
	 * 
	 * params.put("line_place", ldto.getLine_place()); params.put("startPage",
	 * dto.getStartPage()); params.put("pageSize", dto.getPageSize());
	 * 
	 * return sqlSession.selectList(NAMESPACE + ".searchLinePage", params); }
	 * 
	 * // 게시판 총 글개수 계산
	 * 
	 * public int getTotalCount() throws Exception {
	 * logger.debug("@@ getTotalCount() 호출 @@");
	 * 
	 * return sqlSession.selectOne(NAMESPACE + ".totalCnt"); }
	 * 
	 * // 게시판 총 글개수 계산 (서치)
	 * 
	 * public int getSearchTotalCount(LineDTO ldto) throws Exception {
	 * logger.debug("@@ getSearchTotalCount(LineDTO ldto) 호출 @@"); int result =
	 * sqlSession.selectOne(NAMESPACE + ".searchTotalCnt", ldto);
	 * logger.debug("result :" + result); return result; }
	 * 
	 * // 라인 추가
	 * 
	 * public void registLine(LineDTO ldto, String emp_id) throws Exception {
	 * logger.debug("@@ D : registLine(LineDTO ldto) 호출 @@");
	 * 
	 * ldto.setEmp_id(emp_id);
	 * 
	 * int result = sqlSession.insert(NAMESPACE+".registLine", ldto);
	 * 
	 * if(result != 0) { logger.debug("emp_id 포함 등록 완료"); } }
	 * 
	 * // 라인 삭제
	 * 
	 * public void deleteLine(List<String> checked) throws Exception {
	 * logger.debug("@@ D : deleteLine(List<String> checked) 호출 @@");
	 * 
	 * Iterator<String> it = checked.iterator(); int result = 0;
	 * 
	 * while(it.hasNext()) { String line_code = it.next(); result +=
	 * sqlSession.delete(NAMESPACE+".deleteLine", line_code); }
	 * logger.debug("@@ D : delete ==> "+ result); }
	 * 
	 * // 라인 수정
	 * 
	 * public void modifyLine(LineDTO ldto) throws Exception {
	 * logger.debug("@@ D : modifyLine(LineDTO ldto) 호출 @@");
	 * 
	 * int result = sqlSession.update(NAMESPACE+".updateLine", ldto);
	 * logger.debug("@@ D : update ==> "+ result); }
	 * 
	 * // 라인 조회(String line_code)
	 * 
	 * public LineDTO getLine(String line_code) throws Exception {
	 * logger.debug("@@ D : getLine(String line_code) 호출 @@");
	 * 
	 * return sqlSession.selectOne(NAMESPACE+".readLineList", line_code); }
	 * 
	 * // 라인 추가 시 code값 가져가기
	 * 
	 * public String getLiCode(String line_place) throws Exception {
	 * 
	 * String code = "L000";
	 * 
	 * if(sqlSession.selectOne(NAMESPACE+".getLiCode", line_place) == null) { return
	 * code; }else { return sqlSession.selectOne(NAMESPACE+".getLiCode",
	 * line_place); } }
	 * 
	 * // ===========창고==============================================
	 * 
	 * // 창고 목록 조회 + 페이징처리
	 * 
	 * public List<WarehouseDTO> getWh_prodListPage(LineWhPageDTO dto) throws
	 * Exception { logger.debug("@@ getWh_prodListPage() 호출 @@");
	 * 
	 * return sqlSession.selectList(NAMESPACE + ".whlistPage", dto); }
	 * 
	 * // 창고 조회 총 글 개수 계산
	 * 
	 * public int getWh_TotalCount() throws Exception {
	 * logger.debug("@@ getWh_TotalCount() 호출 @@");
	 * 
	 * return sqlSession.selectOne(NAMESPACE + ".whTotalCnt"); }
	 * 
	 * // 창고 검색 + 페이징처리
	 * 
	 * public List<WarehouseDTO> searchWarehousePage(LineWhPageDTO dto, Wh_prodDTO
	 * wdto) throws Exception { logger.
	 * debug("@@ searchWarehousePage(LineWhPageDTO dto, Wh_prodDTO wdto) 호출 @@");
	 * 
	 * Map<String, Object> params = new HashMap<>();
	 * 
	 * params.put("wh_code", wdto.getWh_code()); params.put("wh_dv",
	 * wdto.getWh_dv()); // params.put("prodCode", wdto.getProdCode()); //
	 * params.put("rawCode", wdto.getRawCode()); params.put("emp_id",
	 * wdto.getEmp_id()); // params.put("emp_name", wdto.getEmp().getEmp_name());
	 * 
	 * params.put("wh_addr", wdto.getWh_addr());
	 * 
	 * if(wdto.getWh_use() != 0) {
	 * 
	 * params.put("wh_use", wdto.getWh_use()); }
	 * 
	 * params.put("startPage", dto.getStartPage()); params.put("pageSize",
	 * dto.getPageSize());
	 * 
	 * return sqlSession.selectList(NAMESPACE + ".searchWareHouse", params); }
	 * 
	 * // 검색시 총 글 개수 계산
	 * 
	 * public int searchWh_TotalCount(Wh_prodDTO wdto) throws Exception {
	 * logger.debug("@@ searchWh_TotalCount(Wh_prodDTO wdto) 호출 @@");
	 * 
	 * 
	 * HashMap<String, Object> params = new HashMap<String, Object>();
	 * 
	 * params.put("wh_code", wdto.getWh_code()); params.put("wh_dv",
	 * wdto.getWh_dv()); // if(wdto.getProdCode() != null) { //
	 * params.put("prodCode", wdto.getProdCode()); // }else if(wdto.getRawCode()
	 * != null) { // params.put("rawCode", wdto.getRawCode()); // }
	 * 
	 * params.put("wh_addr", wdto.getWh_addr());
	 * 
	 * if(wdto.getWh_use() != 0) { params.put("wh_use", wdto.getWh_use()); }
	 * 
	 * params.put("emp_id", wdto.getEmp_id()); // params.put("emp_name",
	 * wdto.getEmp().getEmp_name());
	 * 
	 * return sqlSession.selectOne(NAMESPACE+".searchWhTotalCnt", params);
	 * 
	 * }
	 * 
	 * // 창고 추가
	 * 
	 * public void registWh(Wh_prodDTO wdto, String emp_id) throws Exception {
	 * logger.debug("@@ D : registWh(Wh_prodDTO wdto) 호출 @@");
	 * 
	 * wdto.setEmp_id(emp_id);
	 * 
	 * int result = sqlSession.insert(NAMESPACE+".registWh", wdto);
	 * 
	 * if(result != 0) { logger.debug("emp_id 포함 등록 완료"); } }
	 * 
	 * // 창고 삭제
	 * 
	 * public void deleteWh(List<String> checked) throws Exception {
	 * logger.debug("@@ D : deleteWh(List<String> checked) 호출 @@");
	 * 
	 * Iterator<String> it = checked.iterator(); int result = 0;
	 * 
	 * while(it.hasNext()) { String wh_code = it.next(); result +=
	 * sqlSession.delete(NAMESPACE+".deleteWh", wh_code); }
	 * logger.debug("@@ D : delete ==> "+result); }
	 * 
	 * // 창고 수정
	 * 
	 * public void modifyWh(Wh_prodDTO wdto) throws Exception {
	 * logger.debug("@@ D : modifyWh(Wh_prodDTO wdto) 호출 @@");
	 * 
	 * sqlSession.update(NAMESPACE+".updateWh", wdto); }
	 * 
	 * // 창고 조회(String wh_code)
	 * 
	 * public Wh_prodDTO getWarehouse(String wh_code) throws Exception {
	 * logger.debug("@@ D : getWarehouse(String wh_code) 호출 @@");
	 * 
	 * return sqlSession.selectOne(NAMESPACE+".readWhList", wh_code); }
	 * 
	 * // 창고 추가 시 code값 가져가기
	 * 
	 * public String getWhCode() {
	 * 
	 * String code = "WH000";
	 * 
	 * if(sqlSession.selectOne(NAMESPACE+".getWhCode") == null) { return code; }else
	 * { return sqlSession.selectOne(NAMESPACE+".getWhCode"); } }
	 * 
	 * // ==========================================================================
	 * 
	 * //생산실적 목록 - 전체
	 * 
	 * public List<PerformanceDTO> readPerfList(LineWhPageDTO pdto) throws Exception
	 * { logger.debug("##### DAO: readAllPerf() 호출");
	 * 
	 * return sqlSession.selectList(NAMESPACE + ".performList", pdto); } //
	 * readAllPerf()
	 * 
	 * //생산실적 등록
	 * 
	 * public void createPerformance(PerformanceDTO dto) throws Exception {
	 * logger.debug("##### DAO: createPerformance() 호출");
	 * 
	 * sqlSession.insert(NAMESPACE + ".insertPerform", dto);
	 * 
	 * //DB작업 위해서 작업지시코드 변수에 저장 String work_code = dto.getWork_code();
	 * 
	 * //생산실적 중 양품수와 작업지시수량 비교 String result = sqlSession.selectOne(NAMESPACE +
	 * ".compare", work_code); logger.debug("##### DAO: 양품수와 작업지시수량 비교 결과 있없 ===> "
	 * + result);
	 * 
	 * //비교결과 해당 작업지시수량보다 생산한 양품수가 같거나 많으면 생산현황 마감으로 변경 // => 마감으로 변경됐을 경우 해당 작업지시
	 * 양품수 합해서 재고에 더하기 if(result != null) { sqlSession.update(NAMESPACE +
	 * ".updateStatus", work_code);
	 * 
	 * int perform_fair = sqlSession.selectOne(NAMESPACE + ".sumFair", work_code);
	 * logger.debug("##### DAO: 양품수 합 ===> " + perform_fair);
	 * 
	 * //재고에서 해당 작업지시의 품목과 일치하는 품목 있는지 확인 StockDTO stock =
	 * sqlSession.selectOne(NAMESPACE + ".searchStock", work_code);
	 * 
	 * if(stock!=null) { //일치 품목 있을 때 stock.setStock_count(perform_fair);
	 * sqlSession.update(NAMESPACE + ".updateStock", stock);
	 * logger.debug("##### DAO: 재고 수량 증가"); } else { //일치 품목 없을 때(=> 새로 등록)
	 * dto.setPerform_fair(perform_fair); sqlSession.selectOne(NAMESPACE +
	 * ".insertStock", dto); logger.debug("##### DAO: 재고 새로 추가"); }
	 * 
	 * 
	 * logger.debug("##### DAO: 재고등록완~~~~~~~~~~~~~~~~~~~!!!!!!!!!!!!!!!!!!"); }
	 * //if(마감쳤을때)
	 * 
	 * 
	 * } // createPerformance()
	 * 
	 * //생산실적 삭제
	 * 
	 * public void deletePerformance(List<String> checked) throws Exception {
	 * logger.debug("##### DAO: deletePerformance() 호출");
	 * 
	 * Iterator<String> it = checked.iterator(); int result = 0;
	 * 
	 * while (it.hasNext()) { String perform_code = it.next(); result +=
	 * sqlSession.delete(NAMESPACE + ".deletePerformance", perform_code); }
	 * logger.debug("##### DAO: delete 결과 ===> " + result);
	 * 
	 * } //deletePerformance()
	 * 
	 * //생산실적 조회
	 * 
	 * public PerformanceDTO readPerformanceInfo(String performCode) throws
	 * Exception { logger.debug("##### DAO: readPerformanceInfo() 호출"); return
	 * sqlSession.selectOne(NAMESPACE + ".performInfo", performCode); }
	 * //readPerformanceInfo()
	 * 
	 * //생산실적 수정
	 * 
	 * public void updatePerformance(PerformanceDTO udto) throws Exception {
	 * logger.debug("##### DAO: updatePerformance() 호출"); int result =
	 * sqlSession.update(NAMESPACE + ".updatePerform", udto);
	 * logger.debug("##### DAO: update 결과 ===> " + result);
	 * 
	 * //DB작업 위해서 작업지시코드 변수에 저장 String work_code = udto.getWork_code();
	 * 
	 * //생산실적 중 양품수와 작업지시수량 비교 String updateStatus = sqlSession.selectOne(NAMESPACE
	 * + ".compare", work_code);
	 * logger.debug("##### DAO: 양품수와 작업지시수량 비교 결과 있없 ===> " + updateStatus);
	 * 
	 * //비교결과 해당 작업지시수량보다 생산한 양품수가 같거나 많으면 생산현황 마감으로 변경 // => 마감으로 변경됐을 경우 해당 작업지시
	 * 양품수 합해서 재고에 더하기 if(updateStatus != null ||
	 * udto.getPerform_status().equals("마감")) { sqlSession.update(NAMESPACE +
	 * ".updateStatus", work_code);
	 * 
	 * int perform_fair = sqlSession.selectOne(NAMESPACE + ".sumFair", work_code);
	 * logger.debug("##### DAO: 양품수 합 ===> " + perform_fair);
	 * 
	 * //재고에서 해당 작업지시의 품목과 일치하는 품목 있는지 확인 StockDTO stock =
	 * sqlSession.selectOne(NAMESPACE + ".searchStock", work_code);
	 * 
	 * if(stock!=null) { //일치 품목 있을 때 stock.setStock_count(perform_fair);
	 * sqlSession.update(NAMESPACE + ".updateStock", stock);
	 * logger.debug("##### DAO: 재고 수량 증가"); } else { //일치 품목 없을 때(=> 새로 등록)
	 * udto.setPerform_fair(perform_fair); sqlSession.selectOne(NAMESPACE +
	 * ".insertStock", udto); logger.debug("##### DAO: 재고 새로 추가"); }
	 * 
	 * 
	 * logger.debug("##### DAO: 재고등록완~~~~~~~~~~~~~~~~~~~!!!!!!!!!!!!!!!!!!"); }
	 * //if(마감쳤을때)
	 * 
	 * } //updatePerformance()
	 * 
	 * //생산실적 전체 수
	 * 
	 * public int getPerfCnt() throws Exception {
	 * logger.debug("##### DAO: getTotalPerf() 호출");
	 * 
	 * return sqlSession.selectOne(NAMESPACE + ".getTotalPerf"); } //getTotalPerf()
	 * 
	 * //생산실적 목록 - 검색
	 * 
	 * public List<PerformanceDTO> readPerfList(HashMap<String, Object> search)
	 * throws Exception { logger.debug("##### DAO: readPerfList(search) 호출"); return
	 * sqlSession.selectList(NAMESPACE + ".performSearchList", search); }
	 * //readPerfList(search)
	 * 
	 * //생산실적 검색 수
	 * 
	 * public int getPerfCnt(HashMap<String, Object> search) throws Exception {
	 * logger.debug("##### DAO: getPerfCnt(search) 호출"); return
	 * sqlSession.selectOne(NAMESPACE + ".getSearchPerf", search); }
	 * //getPerfCnt(search)
	 * 
	 * //생산실적 양불 현황
	 * 
	 * public Map<String, List<PerformanceDTO>> getPerformStatus() throws Exception
	 * { logger.debug("##### DAO: getPerformStatus() 호출");
	 * 
	 * Map<String, List<PerformanceDTO>> statusMap = new HashMap<>();
	 * 
	 * List<PerformanceDTO> statusLineList = sqlSession.selectList(NAMESPACE +
	 * ".statusLine"); logger.debug("##### DAO: 라인별 양불현황 ===> " + statusLineList);
	 * 
	 * List<PerformanceDTO> statusProdList = sqlSession.selectList(NAMESPACE +
	 * ".statusProd"); logger.debug("##### DAO: 품목별 양불현황 ===> " + statusProdList);
	 * 
	 * List<PerformanceDTO> statusDateList = sqlSession.selectList(NAMESPACE +
	 * ".statusDate"); logger.debug("##### DAO: 일자별 양불현황 ===> " + statusDateList);
	 * 
	 * statusMap.put("perLine", statusLineList); statusMap.put("perProd",
	 * statusProdList); statusMap.put("perDate", statusDateList);
	 * 
	 * return statusMap; } //getPerformStatus()
	 * 
	 * 
	 * public List<RequirementDTO> readReqList(RequirementPageDTO pdto) throws
	 * Exception { // TODO Auto-generated method stub return null; }
	 * 
	 * 
	 * public int countReq(RequirementDTO dto) { // TODO Auto-generated method stub
	 * return 0; }
	 * 
	 * 
	 * public List<RequirementDTO> readReqList(RequirementDTO dto,
	 * RequirementPageDTO pdto) throws Exception { // TODO Auto-generated method
	 * stub return null; }
	 * 
	 * 
	 * public void insertReqList(RequirementDTO raw) { // TODO Auto-generated method
	 * stub
	 * 
	 * }
	 * 
	 * 
	 * public RequirementDTO getReq(String reqCode) throws Exception { // TODO
	 * Auto-generated method stub return null; }
	 * 
	 * 
	 * public void updateReq(RequirementDTO udto) throws Exception { // TODO
	 * Auto-generated method stub
	 * 
	 * }
	 */






}
