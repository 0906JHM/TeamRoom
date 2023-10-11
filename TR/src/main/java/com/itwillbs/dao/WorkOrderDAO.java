package com.itwillbs.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.itwillbs.domain.RequirementDTO;
import com.itwillbs.domain.RequirementPageDTO;
import com.itwillbs.domain.StockDTO;
import com.itwillbs.domain.WorkOrderDTO;


@Repository
public class WorkOrderDAO{
	private static final Logger logger = LoggerFactory.getLogger(WorkOrderDAO.class);
	
	private static final String NAMESPACE = "com.itwillbs.mappers.workorderMapper";
	
	@Autowired
	private SqlSession sqlSession;
	
	//작업지시 전체 목록
	
	public List<WorkOrderDTO> readAllWorkOrder(RequirementPageDTO pdto) throws Exception {
		logger.debug("##### DAO: readAllWorkOrder() 호출");
		
		return sqlSession.selectList(NAMESPACE + ".allWorkOrder", pdto);
	} //readAllWorkOrder()

	//작업지시 등록

	public int insertWorkOrder(WorkOrderDTO dto) throws Exception {
		logger.debug("##### DAO: updateWorkOrder() 호출");
		
		int rawExist = 0;
		
		//DB 처리 위해 완제품 코드 저장
		String prodCode = dto.getProdCode();
		
		//원자재 소요량 목록
		List<RequirementDTO> reqList = sqlSession.selectList(NAMESPACE + ".consumption", prodCode);
		
		System.out.println(dto + "dto 값 뭔데~~~~~~~~~~~~~~");
		
		//해당 완제품에 필요한 원자재 재고 테이블에 있는지 조회
		List<StockDTO> stockList = new ArrayList<>();
		stockList = sqlSession.selectList(NAMESPACE + ".reqRaw", prodCode);
		logger.debug("##### DAO: 완제품에 필요한 원자재 재고 유무 " + stockList.size());
		
		//있으면 원자재 재고수와 지시수량*원자재 소요량 비교 (반복문)
		/*
		 * if(stockList.size() > 0) { //지시수량 int workAmount = dto.getWorkAmount();
		 * 
		 * int minus = 0; boolean check = true;
		 * 
		 * for(int i=0; i<stockList.size(); i++) {
		 * 
		 * String rawCode = stockList.get(i).getRawCode();
		 * logger.debug("##### DAO 원자재 코드 = " + rawCode);
		 * 
		 * //원자재 재고 int rawStock = stockList.get(i).getWhseCount();
		 * logger.debug("##### DAO 원자재 재고 = " + rawStock); //원자재 소요량 int rawReq =
		 * Integer.parseInt(reqList.get(i).getReqAmount()); //지시수량*원자재소요량 minus =
		 * workAmount*rawReq; logger.debug("##### DAO 지시수량*원자재 소요량 = " + minus);
		 * 
		 * if(rawStock-minus < 0) { // 원자재 재고 - 지시수량*원자재 소요량 < 0 // -> 작업지시 등록 불가 check
		 * = false; break; } } //for(stockList)
		 * 
		 * if(check) { for(int i=0; i<stockList.size(); i++) {
		 * 
		 * String rawCode = stockList.get(i).getRawCode();
		 * logger.debug("##### DAO 원자재 코드 = " + rawCode);
		 * 
		 * //원자재 재고 int rawStock = stockList.get(i).getWhseCount();
		 * logger.debug("##### DAO 원자재 재고 = " + rawStock); //원자재 소요량 int rawReq =
		 * Integer.parseInt(reqList.get(i).getReqAmount()); //지시수량*원자재소요량 minus =
		 * workAmount*rawReq; logger.debug("##### DAO 지시수량*원자재 소요량 = " + minus);
		 * 
		 * if(rawStock-minus >= 0) { // 원자재 재고 - 지시수량*원자재 소요량 >= 0 // -> 원자재 재고 -
		 * 지시수량*원자재 소요량 stockList.get(i).setWhseCount(minus);
		 * sqlSession.update(NAMESPACE + ".reduceRaw", stockList.get(i));
		 * logger.debug("##### DAO: 원자재 재고 차감 완료");
		 * 
		 * } //원자재 재고 차감
		 * 
		 * } //for(stockList)
		 */				
				//작업지시 등록
				int result = sqlSession.insert(NAMESPACE + ".insertWorkOrder", dto);
				logger.debug("##### DAO: insert 결과 ====> " + result);
				
				//라인상태 변경
				String lineCode = getLineCode();
				sqlSession.update(NAMESPACE + ".updateLine", lineCode);
				
				rawExist = 1;
				/*
				 * } //if(원자재 모두 있을 때만)
				 */			
			
				/*
				 * } else { //없으면 // -> 작업지시 등록 불가 logger.debug("##### DAO: 원자재 재고 없음");
				 * 
				 * // return rawExist; }
				 */ //if(완제품에 필요한 원자재 재고 있없)
		
		return rawExist;
	} //insertWorkOrder()
	
	

	//작업지시 등록 - 1차공정 사용 가능 라인코드 가져오기
	
	public String getLineCode() throws Exception {
		logger.debug("##### DAO: getLineCode() 호출");
		
		String lineCode = sqlSession.selectOne(NAMESPACE + ".selectLine");
		logger.debug("##### DAO: lineCode ===> " + lineCode);
		
		return lineCode;
	} //getLineCode()
	
	//작업지시 삭제
	
	public void deleteWorkOrder(List<String> checked) throws Exception {
		logger.debug("##### DAO: deleteWorkOrder() 호출");
		
		Iterator<String> it = checked.iterator();
		int result = 0;
		
		while(it.hasNext()) {
			String work_code = it.next();
			result += sqlSession.delete(NAMESPACE + ".deleteWorkOrder", work_code);
		}
		
		logger.debug("##### DAO: delete 결과 ===> " + result);
	} //deleteWorkOrder()

	//특정 작업지시 조회
	
	public WorkOrderDTO readWorkOrder(String work_code) throws Exception {
		logger.debug("##### DAO: readWorkOrder() 호출");
		return sqlSession.selectOne(NAMESPACE + ".readWorkOrder", work_code);
	} //readWorkOrder()

	
	//작업지시 수정
	
	public int updateWorkOrder(WorkOrderDTO udto) throws Exception {
		logger.debug("##### DAO: updateWorkOrder() 호출");
		
		int rawExist = 0;
		
		// (udto 지시수량 - 기존컬럼 지시수량) 만큼 재고수량에서 차감
		int originQt = readWorkOrder(udto.getWorkCode()).getWorkAmount();
		String prodCode = udto.getProdCode();
		
		//원자재 소요량 목록
		List<RequirementDTO> reqList = sqlSession.selectList(NAMESPACE + ".consumption", prodCode);
				
		//해당 완제품에 필요한 원자재 재고 테이블에 있는지 조회
		List<StockDTO> stockList = new ArrayList<>();
		stockList = sqlSession.selectList(NAMESPACE + ".reqRaw", prodCode);
		
		//있으면 원자재 재고수와 (udto 지시수량 - 기존컬럼 지시수량)*원자재 소요량 비교 (반복문)
		if(stockList.size() > 0) {
			//(udto 지시수량 - 기존컬럼 지시수량)
			int workAmount = udto.getWorkAmount() - originQt;
			
			int minus = 0;
			boolean check = true;
			
			for(int i=0; i<stockList.size(); i++) {
				
				String rawCode = stockList.get(i).getRawCode();
				logger.debug("##### DAO 원자재 코드 = " + rawCode);
				
				//원자재 재고 
				int rawStock = stockList.get(i).getWhseCount();
				logger.debug("##### DAO 원자재 재고 = " + rawStock);
				//원자재 소요량
				int rawReq = Integer.parseInt(reqList.get(i).getReqAmount());
				//(udto 지시수량 - 기존컬럼 지시수량)*원자재소요량
				minus = workAmount*rawReq;
				logger.debug("##### DAO 지시수량*원자재 소요량 = " + minus);
				
				if(rawStock-minus < 0) {
					// 원자재 재고 - (udto 지시수량 - 기존컬럼 지시수량)*원자재 소요량 < 0
					// -> 작업지시 수정 불가
					check = false;
					break;
				}
			} //for(stockList)
			
			if(check) {
				for(int i=0; i<stockList.size(); i++) {
					
					String rawCode = stockList.get(i).getRawCode();
					logger.debug("##### DAO 원자재 코드 = " + rawCode);
					
					//원자재 재고 
					int rawStock = stockList.get(i).getWhseCount();
					logger.debug("##### DAO 원자재 재고 = " + rawStock);
					//원자재 소요량
					int rawReq = Integer.parseInt(reqList.get(i).getReqAmount());
					//(udto 지시수량 - 기존컬럼 지시수량)*원자재소요량
					minus = workAmount*rawReq;
					logger.debug("##### DAO 지시수량*원자재 소요량 = " + minus);
					
					if(rawStock-minus >= 0) {
						// 원자재 재고 - (udto 지시수량 - 기존컬럼 지시수량)*원자재 소요량 >= 0
						// -> 원자재 재고 - (udto 지시수량 - 기존컬럼 지시수량)*원자재 소요량
						stockList.get(i).setWhseCount(minus);
						sqlSession.update(NAMESPACE + ".reduceRaw", stockList.get(i));
						logger.debug("##### DAO: 원자재 재고 차감 완료");
						
						rawExist = 1;
					} //재고차감
					
				} //for(stockList)
				
				//작업지시 수정
				int result = sqlSession.update(NAMESPACE + ".updateWorkOrder", udto);
				logger.debug("##### DAO: update 결과 ===> " + result);
			} //if(원자재 모두 있을 때만)
					
					
		} else {
			//없으면 
			// -> 작업지시 수정 불가
			logger.debug("##### DAO: 원자재 재고 없음");
		} //if(완제품에 필요한 원자재 재고 있없)
		
		
		return rawExist;
	} //updateWorkOrder()

	
	//작업지시 검색
	
	public List<WorkOrderDTO> selectWorkOrder(HashMap<String, Object> search) throws Exception {
		logger.debug("##### DAO: selectWorkOrder() 호출");
		
		List<WorkOrderDTO> searchList = sqlSession.selectList(NAMESPACE + ".searchWorkOrder", search);
		logger.debug("##### DAO: search 결과 ===> " + searchList);
		
		return searchList;
	} //selectWorkOrder()

	//작업지시 전체 수
	
	public int getTotalWorkOrder() throws Exception {
		logger.debug("##### DAO: getTotalWorkOrder() 호출");
		return sqlSession.selectOne(NAMESPACE + ".workOrderAllCnt");
	} //getTotalWorkOrder()

	//작업지시 검색 수
	
	public int getSearchWOrkOrder(HashMap<String, Object> search) throws Exception {
		logger.debug("#####DAO: getSearchWorkOrder() 호출");
		return sqlSession.selectOne(NAMESPACE + ".searchWorkOrderCnt", search);
	} //getSearchWorkOrder()

	//작업지시 현재 작업 공정 변경
	
	public void updateStatus(WorkOrderDTO dto) throws Exception {
		logger.debug("##### DAO: updateStatus() 호출");
		sqlSession.update(NAMESPACE + ".updateStatus", dto);
		
		sqlSession.update(NAMESPACE + ".lineUseY", dto.getLineCode());
		
		String lineProcess = dto.getLineProcess();
		if(lineProcess.equals("1차공정")) {
			String lineCode = sqlSession.selectOne(NAMESPACE + ".selectLine2");
			sqlSession.update(NAMESPACE + ".updateLine", lineCode);
		} else if(lineProcess.equals("2차공정")) {
			String lineCode = sqlSession.selectOne(NAMESPACE + ".selectLine3");
			sqlSession.update(NAMESPACE + ".updateLine", lineCode);
		} else if(lineProcess.equals("3차공정")) {
			
		}
		
	} //updateStatus()


} //WorkOrderDAO
