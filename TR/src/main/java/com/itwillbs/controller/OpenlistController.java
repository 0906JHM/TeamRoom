package com.itwillbs.controller;

import java.net.URLEncoder;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itwillbs.service.OpenlistService;
import com.itwillbs.domain.ClientDTO;
import com.itwillbs.domain.ProdDTO;
import com.itwillbs.domain.RawmaterialsDTO;
import com.itwillbs.domain.RequirementDTO;
import com.itwillbs.domain.RequirementList;
import com.itwillbs.domain.RequirementPageDTO;
import com.mysql.cj.Session;

@Controller
@RequestMapping(value = "/search/*")
public class OpenlistController {

	// 서비스 객체 주입
	@Autowired
	private OpenlistService service;

	private static final Logger logger = LoggerFactory.getLogger(OpenlistController.class);
	
	@RequestMapping(value = "/search", method = RequestMethod.GET)
	public String popUpGET(@RequestParam("input") String input, @RequestParam("type") String type) throws Exception {

		logger.debug("@#@#@# C : popUpGET() 호출 @#@#@#");
		logger.debug("@#@#@# C : type = " + type);

		if (type.equals("prod")) { 
			return "redirect:/search/product?input="+input; }
		

		else if (type.equals("raw")) {
			return "redirect:/search/rawmaterial?input=" + input;
		}
		
		else if (type.equals("client")) {
			return "redirect:/search/client?input=" + input;
		}

		return "";

	}


	  
	  @RequestMapping(value = "/product", method = RequestMethod.GET)
	  public String productGET(Model model, ProdDTO dto, RequirementPageDTO pdto, 
	  
	  @RequestParam(value = "nowPage", required = false) String nowPage,
	  
	  @RequestParam(value = "cntPerPage", required = false) String cntPerPage,
	  
	  @RequestParam(value = "input", required = false) String input) throws
	  Exception {
	
	  
	  logger.debug("productGET() 호출");
	  List<ProdDTO> products = service.getProdList(pdto);
	  model.addAttribute("products", products);
	  logger.debug("DTO : " + dto);
	  logger.debug(" @@@@@@@@@@ input: " + input +  "@@@@@@@@@@@@@@@");
	  
	  if (dto.getProdCode() != null || dto.getProdName() != null) {
		  int total = service.countProd(dto);
	  pdto = new RequirementPageDTO(total, pdto.getNowPage(), pdto.getCntPerPage());
	  List<ProdDTO> list = service.getProdList(dto, pdto);
	  model.addAttribute("prodList", list);
	  model.addAttribute("paging", pdto);
	  model.addAttribute("DTO", dto);
	  logger.debug("pdto : " + pdto);
	  logger.debug("DTO : " + dto);
	  logger.debug("검색 리스트 가져감");
	  
	  if (input != null && !input.equals("")) {
		  model.addAttribute("input", input);
	  logger.debug("@@@@@@@@@@@@@@@@ input 정보 전달 @@@@@@@@@@@@@@@@"); }
	  
	  } else {
		  int total = service.countProd();
		  pdto = new RequirementPageDTO(total);
		  logger.debug("pdto : " + pdto);
		  List<ProdDTO> list = service.getProdList(pdto);
		  model.addAttribute("prodList", list);
	  model.addAttribute("paging", pdto);
	  logger.debug(" 모든 리스트 가져감"); }
	  
	  return "openlist/productlist";
	  
	  }
	 
	// =====================================================================================

	
	  // 원자재목록 // http://localhost:8088/search/rawMaterial
	  
	  @RequestMapping(value = "/rawmaterial", method = RequestMethod.GET)
	  public String rawMaterialGET(Model model, RawmaterialsDTO dto, RequirementPageDTO pdto,
	  
	  @RequestParam(value = "nowPage", required = false) String nowPage,
	  
	  @RequestParam(value = "cntPerPage", required = false) String cntPerPage,
	  
	  @RequestParam(value = "input", required = false) String input) throws Exception {
	  
	  logger.debug("rawMaterialGET() 호출");
	  List<RawmaterialsDTO> raws = new ArrayList<RawmaterialsDTO>();
	  model.addAttribute("raws", raws);
	  logger.debug("DTO : " + dto);
	  
	  if (dto.getRawCode() != null || dto.getRawName() != null) {
	  
	  logger.debug("if문 호출"); int total = service.countRaw(dto);
	  pdto = new RequirementPageDTO(total, pdto.getNowPage(), pdto.getCntPerPage());
	  List<RawmaterialsDTO> list = service.getRawList(dto, pdto);
	  model.addAttribute("rawList", list);
	  model.addAttribute("paging", pdto);
	  model.addAttribute("DTO", dto);
	  logger.debug("pdto : " + pdto);
	  logger.debug("DTO : " + dto);
	  
	  logger.debug("검색 리스트 가져감");
	  
	  // input 추가
	  if (input != null && !input.equals("")) {
	  model.addAttribute("input", input);
	  logger.debug("@@@@@@@@@@@@@@@@ input 정보 전달 @@@@@@@@@@@@@@@@"); }
	  }
	  else {
		  logger.debug("else문 호출");
	  int total = service.countRaw();
	  pdto = new RequirementPageDTO(total);
	  logger.debug("pdto : " + pdto);
	  List<RawmaterialsDTO> list = service.getRawList(pdto);
	  model.addAttribute("rawList", list);
	  model.addAttribute("paging", pdto);
	  logger.debug(" 모든 리스트 가져감"); }
	  return "openlist/rawmateriallist";
	  
	  }
	 

	// =====================================================================================

	  
	// 거래처목록 // http://localhost:8088/search/rawMaterial
	  
		  @RequestMapping(value = "/client", method = RequestMethod.GET)
		  public String clientGET(Model model, ClientDTO dto, RequirementPageDTO pdto,
		  
		  @RequestParam(value = "nowPage", required = false) String nowPage,
		  
		  @RequestParam(value = "cntPerPage", required = false) String cntPerPage,
		  
		  @RequestParam(value = "input", required = false) String input) throws Exception {
		  
		  logger.debug("clientGET() 호출");
		  List<ClientDTO> client = new ArrayList<ClientDTO>();
		  model.addAttribute("client", client);
		  logger.debug("DTO : " + dto);
		  
		  if (dto.getClientCode() != null || dto.getClientCompany() != null) {
		  
		  logger.debug("if문 호출"); int total = service.countClient(dto);
		  pdto = new RequirementPageDTO(total, pdto.getNowPage(), pdto.getCntPerPage());
		  List<ClientDTO> list = service.getClientList(dto, pdto);
		  model.addAttribute("clientList", list);
		  model.addAttribute("paging", pdto);
		  model.addAttribute("DTO", dto);
		  logger.debug("pdto : " + pdto);
		  logger.debug("DTO : " + dto);
		  
		  logger.debug("검색 리스트 가져감");
		  
		  // input 추가
		  if (input != null && !input.equals("")) {
		  model.addAttribute("input", input);
		  logger.debug("@@@@@@@@@@@@@@@@ input 정보 전달 @@@@@@@@@@@@@@@@"); }
		  }
		  else {
			  logger.debug("else문 호출");
		  int total = service.countClient();
		  pdto = new RequirementPageDTO(total);
		  logger.debug("pdto : " + pdto);
		  List<ClientDTO> list = service.getClientList(pdto);
		  model.addAttribute("clientList", list);
		  model.addAttribute("paging", pdto);
		  logger.debug(" 모든 리스트 가져감"); }
		  return "openlist/clientlist";
		  
		  }
	// 소요량관리
	// http://localhost:8088/requirement/reqdetail
	/*
	 * @RequestMapping(value = "/reqDetail", method = RequestMethod.GET) public
	 * String requirementGET(Model model, RequirementDTO dto, RequirementPageDTO
	 * pdto,
	 * 
	 * @RequestParam(value = "nowPage", required = false) String nowPage,
	 * 
	 * @RequestParam(value = "cntPerPage", required = false) String cntPerPage)
	 * throws Exception {
	 * 
	 * logger.debug("requirementGET() 호출"); List<RequirementDTO> reqs = new
	 * ArrayList<RequirementDTO>(); model.addAttribute("reqs", reqs);
	 * logger.debug("DTO : " + dto);
	 * 
	 * if (dto.getReqCode() != null || dto.getProdCode() != null || dto.getRawCode()
	 * != null) {
	 * 
	 * logger.debug("if문 호출"); logger.debug("DTO : " + dto); logger.debug("DTO : " +
	 * pdto); System.out.println(dto); int total = service.countReq(dto);
	 * logger.debug("DTO : " + pdto);
	 * 
	 * pdto = new RequirementPageDTO(total, pdto.getNowPage(),
	 * pdto.getCntPerPage()); List<RequirementDTO> list = service.getReqList(dto,
	 * pdto); model.addAttribute("reqList", list); model.addAttribute("paging",
	 * pdto); model.addAttribute("DTO", dto); logger.debug("pdto : " + pdto);
	 * logger.debug("DTO : " + dto);
	 * 
	 * logger.debug("검색 리스트 가져감");
	 * 
	 * } else { logger.debug("else문 호출"); int total = service.countReq(); pdto = new
	 * RequirementPageDTO(total); logger.debug("pdto : " + pdto);
	 * List<RequirementDTO> list = service.getReqList(pdto);
	 * model.addAttribute("reqList", list); model.addAttribute("paging", pdto);
	 * logger.debug(" 모든 리스트 가져감"); } return "requirement/requirement";
	 * 
	 * }
	 */

	// 소요량관리 추가 시 code 값 가져가기
	/*
	 * @ResponseBody
	 * 
	 * @RequestMapping(value = "/reqCode", method = RequestMethod.GET) public String
	 * getReqCode() { logger.debug(" getReqCode() 호출 ");
	 * 
	 * return service.getReqCode(); }
	 */

	// 소요량관리 정보 추가
	
	/*
	 * @RequestMapping(value = "/reqDetail", method = RequestMethod.POST) public
	 * String requirementPOST(RequirementList reqs) throws Exception {
	 * 
	 * logger.debug("requirementPOST() 호출"); logger.debug("reqs : " +
	 * reqs.getReqs()); service.insertReq(reqs.getReqs());
	 * 
	 * return "redirect:/requirement/reqDetail"; }
	 */
	 

	// 소요량관리 정보 삭제
	/*
	 * @RequestMapping(value = "/requirementDelete", method = RequestMethod.POST)
	 * public String deleteRequirement(@RequestParam(value = "checked[]")
	 * List<String> checked) throws Exception {
	 * logger.debug("@@@@@ CONTROLLER: deleteRequirement() 호출");
	 * logger.debug("@@@@@ CONTROLLER: checked = " + checked);
	 * 
	 * // 서비스 - 소요량관리 삭제 service.removeReq(checked);
	 * 
	 * return "redirect:/requirement/reqDetail"; }
	 */ // deleteRequirement()

	// 소요량관리 조회 POST
	/*
	 * @ResponseBody
	 * 
	 * @RequestMapping(value = "/reqOne", method = RequestMethod.POST) public
	 * RequirementDTO getreq(@RequestBody RequirementDTO dto) throws Exception {
	 * logger.debug("@@@@@ CONTROLLER: getreq() 호출");
	 * logger.debug("@@@@@ CONTROLLER: req_Code = " + dto.getReqCode());
	 * 
	 * // 서비스 - 소요량관리 정보 가져오기 RequirementDTO preDTO =
	 * service.getReq(dto.getReqCode()); logger.debug("@@@@@ CONTROLLER: preDTO = "
	 * + preDTO);
	 * 
	 * return preDTO; }
	 */ // getProd()

	// 소요량관리 수정
	/*
	 * @RequestMapping(value = "/reqModify", method = RequestMethod.POST) public
	 * String modifyreq(RequirementDTO uDTO) throws Exception {
	 * logger.debug("@@@@@ CONTROLLER: modifyreq() 호출");
	 * logger.debug("@@@@@ CONTROLLER: uDTO = " + uDTO);
	 * 
	 * // 서비스 - 소요량관리 수정 service.modifyReq(uDTO);
	 * 
	 * return "redirect:/requirement/reDetail"; }
	 */
	
	
	// modifyWorkOrder()

	// =====================================================================================

	// ======== 라인 - /line ================================
	// http://localhost:8088/requirement/line
	/*
	 * @RequestMapping(value = "/line", method = RequestMethod.GET) public void
	 * lineGET(Model model, LineDTO lDTO, LineWhPageDTO dto, LineWhPageMaker lwpm,
	 * 
	 * @RequestParam Map<String, Object> params, @RequestParam(value = "input",
	 * required = false) String input) throws Exception {
	 * logger.debug("@@lineGET() 호출@@");
	 * 
	 * logger.debug("lDTO : " + lDTO);
	 * 
	 * List<LineDTO> boardList = new ArrayList<>();
	 * 
	 * // 검색 if (lDTO.getLine_code() != null || lDTO.getLine_name() != null ||
	 * lDTO.getLine_place() != null || lDTO.getLine_use() != 0) {
	 * 
	 * // 이거 해야 전체 목록 보여짐 if (lDTO.getLine_use() == 0) { lDTO.setLine_use(3); }
	 * 
	 * // 페이징처리 + 검색 boardList = service.getSearchLinePage(dto, lDTO);
	 * model.addAttribute("boardList", boardList);
	 * 
	 * // 객체 다 넘기기 model.addAttribute("lDTO", lDTO); model.addAttribute("DTO", dto);
	 * model.addAttribute("params", params);
	 * 
	 * logger.debug("@@!!@@ 검색 리스트 (페이징처리) 불러옴 @@!!@@");
	 * 
	 * // 페이징처리 하단부 객체 저장 lwpm.setLwPageDTO(dto);
	 * lwpm.setTotalCount(service.getSearchTotalCount(lDTO));
	 * logger.debug("lwpm (서치) : " + lwpm.getTotalCount());
	 * model.addAttribute("lwpm", lwpm);
	 * 
	 * if (input != null && !input.equals("")) { model.addAttribute("input", input);
	 * logger.debug("@@@@@@@@@@@@@@@@ input 정보 전달 @@@@@@@@@@@@@@@@"); }
	 * 
	 * } else { // 페이징처리된 리스트정보 boardList = service.getLineListPage(dto);
	 * model.addAttribute("boardList", boardList);
	 * 
	 * model.addAttribute("lDTO", lDTO);
	 * 
	 * logger.debug("@@ 모든 리스트 호출 @@");
	 * 
	 * // 페이징처리 하단부 객체 저장 lwpm.setLwPageDTO(dto);
	 * lwpm.setTotalCount(service.getTotalCount()); logger.debug("lwpm : " +
	 * lwpm.getTotalCount()); model.addAttribute("lwpm", lwpm); }
	 * 
	 * }
	 */

	// 사원 팝업
	/*
	 * @RequestMapping(value = "/lineEmpSearch", method = RequestMethod.GET) public
	 * String popUpLineGET(@RequestParam("type") String type,
	 * 
	 * @RequestParam(value = "input", required = false) String input) throws
	 * Exception {
	 * 
	 * logger.debug("@#@#@# C : popUpLineGET() 호출");
	 * logger.debug("@#@#@# C : type = " + type);
	 * 
	 * if (type.equals("emp")) { return "redirect:/person/empinfo?input=" + input; }
	 * 
	 * return "redirect:/requirement/line?input=" + input; }
	 */

	// 라인 추가 시 code값 가져가기
	/*
	 * @ResponseBody
	 * 
	 * @RequestMapping(value = "/lineCode", method = RequestMethod.POST) public
	 * String getLiCode(@RequestBody LineDTO lDTO) throws Exception {
	 * logger.debug("line_place@@@@@@@ :   " + lDTO.getLine_place());
	 * 
	 * logger.debug("#$@(#(@((#)@$(#" + service.getLiCode(lDTO.getLine_place()));
	 * 
	 * return service.getLiCode(lDTO.getLine_place()); }
	 * 
	 * // 라인 추가
	 * 
	 * @RequestMapping(value = "/lineadd", method = RequestMethod.POST) public
	 * String addLine(LineDTO lDTO, HttpSession session, RedirectAttributes rttr)
	 * throws Exception { logger.debug("@#@#@# C : addLine(LineDTO lDTO) 호출 ");
	 * logger.debug("@#@#@# C : lDTO = " + lDTO);
	 * 
	 * EmployeesDTO eDTO = (EmployeesDTO) session.getAttribute("id"); String emp_id
	 * = eDTO.getEmp_id();
	 * 
	 * // 라인 등록 service.registLine(lDTO, emp_id);
	 * 
	 * rttr.addFlashAttribute("result", "registLine");
	 * 
	 * return "redirect:/requirement/line"; }
	 */

	/*
	 * // 라인 삭제
	 * 
	 * @RequestMapping(value = "/linedelete", method = RequestMethod.POST) public
	 * String deleteLine(@RequestParam(value = "checked[]") List<String> checked)
	 * throws Exception { logger.debug("@#@#@# C : deleteLine() 호출 ");
	 * logger.debug("@#@#@# C : checked = " + checked);
	 * 
	 * service.deleteLine(checked);
	 * 
	 * return "redirect:/requirement/line"; }
	 */

	// 라인 수정
	/*
	 * @RequestMapping(value = "/linemodify", method = RequestMethod.POST) public
	 * String modifyLine(LineDTO lDTO) throws Exception {
	 * logger.debug("@#@#@# C : modifyLine(LineDTO lDTO) 호출 ");
	 * logger.debug("@#@#@# C : lDTO = " + lDTO);
	 * 
	 * service.modifyLine(lDTO);
	 * 
	 * return "redirect:/requirement/line"; }
	 * 
	 * // 라인 조회 POST
	 * 
	 * @ResponseBody
	 * 
	 * @RequestMapping(value = "/line", method = RequestMethod.POST) public LineDTO
	 * getlinePOST(@RequestBody LineDTO lDTO) throws Exception {
	 * logger.debug("@#@#@# C : linePOST() 호출");
	 * logger.debug("@#@#@# C : lineCode = " + lDTO.getLine_code());
	 * 
	 * LineDTO lpdto = service.getLine(lDTO.getLine_code());
	 * logger.debug("@#@#@# C : lpdto = " + lpdto);
	 * 
	 * return lpdto; }
	 * 
	 * // ======== 라인 - /line ================================
	 * 
	 * // ======== 창고 - /warehouse =========================== //
	 * http://localhost:8088/requirement/warehouse
	 * 
	 * @RequestMapping(value = "/warehouse", method = RequestMethod.GET) public void
	 * warehouseGET(Model model, LineWhPageDTO dto, EmployeesDTO emp,
	 * LineWhPageMaker lwpm, Wh_prodDTO wDTO,
	 * 
	 * @RequestParam HashMap<String, Object> params, @RequestParam(value = "input",
	 * required = false) String input) throws Exception {
	 * 
	 * logger.debug("@@ warehouseGET() 호출 @@");
	 * 
	 * List<WarehouseDTO> whList = new ArrayList<>();
	 * 
	 * // 이거 해야 전체 목록 보여짐
	 * 
	 * logger.debug("wh_use : " + wDTO.getWh_use());
	 * 
	 * // 검색(+페이징) if (wDTO.getWh_code() != null || wDTO.getWh_name() != null ||
	 * wDTO.getWh_dv() != null || wDTO.getEmp_id() != null || wDTO.getWh_use() != 0)
	 * {
	 * 
	 * if (wDTO.getWh_use() == 0) { wDTO.setWh_use(3); }
	 * 
	 * whList = service.searchWarehousePage(dto, wDTO); model.addAttribute("whList",
	 * whList);
	 * 
	 * // 객체 다 넘기기 model.addAttribute("wDTO", wDTO); model.addAttribute("DTO", dto);
	 * model.addAttribute("params", params);
	 * 
	 * logger.debug("@@!!@@ 검색 리스트 (페이징처리) 불러옴 @@!!@@");
	 * 
	 * // 페이징처리(하단부) 저장 lwpm.setLwPageDTO(dto);
	 * lwpm.setTotalCount(service.searchWh_TotalCount(wDTO));
	 * logger.debug("lwpm (서치) : " + lwpm.getTotalCount());
	 * model.addAttribute("lwpm", lwpm);
	 * 
	 * logger.debug("검색" + whList);
	 * 
	 * if (input != null && !input.equals("")) { model.addAttribute("input", input);
	 * logger.debug("@@@@@@@@@@@@@@@@ input 정보 전달 @@@@@@@@@@@@@@@@"); }
	 * 
	 * } else {
	 * 
	 * // 모든 목록(+페이징) whList = service.getWh_prodListPage(dto);
	 * model.addAttribute("whList", whList);
	 * 
	 * model.addAttribute("wDTO", wDTO);
	 * 
	 * logger.debug("@@ 모든 리스트 호출 @@");
	 * 
	 * // 페이징처리(하단부) 저장 lwpm.setLwPageDTO(dto);
	 * lwpm.setTotalCount(service.getWh_TotalCount()); model.addAttribute("lwpm",
	 * lwpm);
	 * 
	 * } }
	 */

	/*
	 * // 창고 추가 시 code값 가져가기
	 * 
	 * @ResponseBody
	 * 
	 * @RequestMapping(value = "/whCode", method = RequestMethod.GET) public String
	 * getWhCode() {
	 * 
	 * return service.getWhCode(); }
	 */

	// 담당자(사원) 팝업 검색
	

	// 창고 추가
	/*
	 * @RequestMapping(value = "/whadd", method = RequestMethod.POST) public String
	 * addWh(Wh_prodDTO wDTO, HttpSession session, RedirectAttributes rttr) throws
	 * Exception {
	 * 
	 * logger.debug("@#@#@# C : addWh(Wh_prodDTO wDTO) 호출 ");
	 * 
	 * EmployeesDTO eDTO = (EmployeesDTO) session.getAttribute("id"); String emp_id
	 * = eDTO.getEmp_id();
	 * 
	 * logger.debug("@#@@#@#@#@ emp_id : " + emp_id);
	 * 
	 * service.registWh(wDTO, emp_id);
	 * 
	 * rttr.addFlashAttribute("result", "registWh");
	 * 
	 * return "redirect:/requirement/warehouse"; }
	 */

	/*
	 * // 창고 삭제
	 * 
	 * @RequestMapping(value = "/whdelete", method = RequestMethod.POST) public
	 * String deleteWh(@RequestParam(value = "checked[]") List<String> checked)
	 * throws Exception { logger.debug("@#@#@# C : deleteWh() 호출 ");
	 * logger.debug("@#@#@# C : checked = " + checked);
	 * 
	 * service.deleteWh(checked); ;
	 * 
	 * return "redirect:/requirement/warehouse"; }
	 */

	// 창고 수정
	/*
	 * @RequestMapping(value = "/whmodify", method = RequestMethod.POST) public
	 * String modifyWh(Wh_prodDTO wDTO) throws Exception {
	 * logger.debug("@#@#@# C : modifyWh(Wh_prodDTO wDTO) 호출 ");
	 * logger.debug("@#@#@# C : wDTO = " + wDTO);
	 * 
	 * service.modifyWh(wDTO);
	 * 
	 * return "redirect:/requirement/warehouse"; }
	 * 
	 * // 창고 조회 POST
	 * 
	 * @ResponseBody
	 * 
	 * @RequestMapping(value = "/warehouse", method = RequestMethod.POST) public
	 * Wh_prodDTO warehousePOST(@RequestBody Wh_prodDTO wDTO) throws Exception {
	 * logger.debug("@#@#@# C : warehousePOST() 호출");
	 * logger.debug("@#@#@# C : whCode = " + wDTO.getWh_code());
	 * 
	 * Wh_prodDTO whDTO = service.getWarehouse(wDTO.getWh_code());
	 * logger.debug("@#@#@# C : whDTO = " + whDTO);
	 * 
	 * return whDTO; }
	 */

	// ======== 창고 - /warehouse ===========================

	//// ************************* 생산실적 ************************* ////
	// 생산실적 목록
	// http://localhost:8088/requirement/performList
	/*
	 * @RequestMapping(value = "/performList", method = RequestMethod.GET) public
	 * void RequirementList(LineWhPageDTO pdto, @RequestParam HashMap<String,
	 * Object> search, Model model) throws Exception {
	 * logger.debug("@@@@@ CONTROLLER: RequirementList() 호출");
	 * 
	 * // 페이지 정보 pdto.setPageSize(8);
	 * 
	 * // 페이징 하단부 정보 LineWhPageMaker pm = new LineWhPageMaker();
	 * pm.setLwPageDTO(pdto); pm.setPageBlock(5);
	 * 
	 * List<RequirementDTO> perfList = new ArrayList<>();
	 * 
	 * // 검색 있을 때 if ((search.get("search_work_code") != null &&
	 * !search.get("search_work_code").equals("")) || (search.get("search_fromDate")
	 * != null && !search.get("search_fromDate").equals("")) ||
	 * (search.get("search_toDate") != null &&
	 * !search.get("search_toDate").equals("")) || (search.get("search_line_code")
	 * != null && !search.get("search_line_code").equals("")) ||
	 * (search.get("search_prod_code") != null &&
	 * !search.get("search_prod_code").equals("")) ||
	 * (search.get("search_perform_status") != null &&
	 * !search.get("search_perform_status").equals("") &&
	 * !search.get("search_perform_status").equals("전체"))) {
	 * 
	 * logger.debug("@@@@@ CONTROLLER: 검색 service 호출");
	 * 
	 * search.put("startPage", pdto.getStartPage()); search.put("pageSize",
	 * pdto.getPageSize());
	 * 
	 * // 서비스 - 생산실적관리 검색, 개수 perfList = service.getPerfList(search);
	 * logger.debug("@@@@@ CONTROLLER: 검색 list = " + perfList);
	 * logger.debug("@@@@@ CONTROLLER: 검색 결과 수 = " + service.getPerfCnt(search));
	 * pm.setTotalCount(service.getPerfCnt(search));
	 * 
	 * logger.debug("@@@@@ CONTROLLER: 페이징정보 ====> " + pdto + ", " + pm);
	 * 
	 * model.addAttribute("search", search); model.addAttribute("perfList",
	 * perfList); model.addAttribute("pm", pm); model.addAttribute("pdto", pdto);
	 * 
	 * } // 검색 없을 때 else { logger.debug("@@@@@ CONTROLLER: 목록 service 호출");
	 * 
	 * // 서비스 - 생산실적목록 perfList = service.getPerfList(pdto);
	 * 
	 * // 페이징정보 - 전체 수 pm.setTotalCount(service.getPerfCnt());
	 * 
	 * logger.debug("@@@@@ CONTROLLER: 페이징정보 ====> " + pdto + ", " + pm);
	 * 
	 * model.addAttribute("perfList", perfList); model.addAttribute("pm", pm);
	 * model.addAttribute("pdto", pdto); }
	 * 
	 * logger.debug("@@@@@ CONTROLLER: perfList = " + perfList);
	 * 
	 * model.addAttribute("perfList", perfList); }
	 */ // RequirementList()

	// 작업지시, 라인, 품번 팝업
	/*
	 * @RequestMapping(value = "/search", method = RequestMethod.GET) public String
	 * workOrderGET(Model model, @RequestParam("type") String
	 * type, @RequestParam("input") String input, RequirementPageDTO pdto) throws
	 * Exception { logger.debug("@@@@@ CONTROLLER: workOrderGET() 호출");
	 * logger.debug("@@@@@ CONTROLLER: type = " + type);
	 * 
	 * if (type.equals("work")) { String state = URLEncoder.encode("마감", "UTF-8");
	 * return "redirect:/workorder/workOrderList?input=" + input + "&search_place="
	 * + state; } if (type.equals("line")) { return
	 * "redirect:/requirement/line?input=" + input; } if (type.equals("prod")) {
	 * return "redirect:/requirement/product?input=" + input; } return ""; }
	 */ // workOrderGET()

	/*
	 * // 생산실적 등록
	 * 
	 * @RequestMapping(value = "/add", method = RequestMethod.POST) public String
	 * addRequirement(RequirementDTO dto) throws Exception {
	 * logger.debug("@@@@@ CONTROLLER: addRequirement() 호출");
	 * logger.debug("@@@@@ CONTROLLER: dto = " + dto);
	 * 
	 * // 서비스 - 작업지시 등록 service.regRequirement(dto);
	 * 
	 * return "redirect:/requirement/performList"; } // addRequirement()
	 * 
	 * // 생산실적 삭제
	 * 
	 * @RequestMapping(value = "/deletePerform", method = RequestMethod.POST) public
	 * String deleteRequirement(@RequestParam(value = "checked[]") List<String>
	 * checked) throws Exception {
	 * logger.debug("@@@@@ CONTROLLER: deleteRequirement() 호출");
	 * logger.debug("@@@@@ CONTROLLER: checked = " + checked);
	 * 
	 * // 서비스 - 작업지시 삭제 service.removeRequirement(checked);
	 * 
	 * return "redirect:/requirement/performList";
	 * 
	 * } // deleteRequirement()
	 * 
	 * // 생산실적 조회 POST
	 * 
	 * @ResponseBody
	 * 
	 * @RequestMapping(value = "/detail", method = RequestMethod.POST) public
	 * RequirementDTO getPerformData(@RequestBody RequirementDTO dto) throws
	 * Exception { logger.debug("@@@@@ CONTROLLER: getPerformData() 호출");
	 * logger.debug("@@@@@ CONTROLLER: performCode = " + dto.getPerform_code());
	 * 
	 * // 서비스 - 생산관리 정보 가져오기 RequirementDTO preDTO =
	 * service.getRequirementInfo(dto.getPerform_code());
	 * logger.debug("@@@@@ CONTROLLER: preDTO = " + preDTO);
	 * logger.debug("@@@@@ CONTROLLER: 실적일 =========> " + preDTO.getPerform_date());
	 * 
	 * return preDTO; } // getPerformData()
	 * 
	 * // 생산실적 수정
	 * 
	 * @RequestMapping(value = "/modify", method = RequestMethod.POST) public String
	 * modifyRequirement(RequirementDTO uDTO) throws Exception {
	 * logger.debug("@@@@@ CONTROLLER: modifyRequirement() 호출");
	 * logger.debug("@@@@@ CONTROLLER: uDTO = " + uDTO);
	 * 
	 * // 서비스 - 작업지시 수정 service.modifyRequirement(uDTO);
	 * 
	 * return "redirect:/requirement/performList"; } // modifyRequirement()
	 * 
	 * // 생산실적 현황 - 양불수 // http://localhost:8088/requirement/performStatus
	 * 
	 * @RequestMapping(value = "/performStatus", method = RequestMethod.GET) public
	 * void getPerformStatus(Model model) throws Exception {
	 * logger.debug("@@@@@ CONTROLLER: getPerformStatus() 호출");
	 * 
	 * } // getPerformStatus()
	 * 
	 * @ResponseBody
	 * 
	 * @RequestMapping(value = "/status", method = RequestMethod.POST) public
	 * Map<String, List<RequirementDTO>> status() throws Exception {
	 * logger.debug("@@@@@ CONTROLLER: status() 호출");
	 * 
	 * Map<String, List<RequirementDTO>> statusMap = service.getPerformStatus();
	 * 
	 * return statusMap; } // status()
	 */
}// RequirementController
