package com.itwillbs.service;

import java.io.Console;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.dao.ClientDAO;
import com.itwillbs.domain.ClientDTO;
import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.ProdDTO;
import com.itwillbs.domain.RawmaterialsDTO;
import com.itwillbs.domain.SellDTO;

@Service
public class ClientService {

	@Inject
	private ClientDAO clientDAO;

	public void insertClient(ClientDTO clientDTO) {
		
		System.out.println("ClientService insertController@@@@@@@@@@" + clientDTO);
		clientDAO.insertClient(clientDTO);
		
		
	}

       public List<ClientDTO> getclientList(PageDTO pageDTO) {
		// TODO Auto-generated method stub
		return null;
	}
	public String  getclientCode(String clientType) {
		
		System.out.println("ClientService getClientCode=============" + clientType);
		
		return clientDAO.getclientCode(clientType);
		
	}

	public ClientDTO clientdetail(String clientCompany) {
		
		return clientDAO.clientdetail(clientCompany);
	}

	public RawmaterialsDTO rawmaterialsdetail(String clientCode) {
		
		return clientDAO.rawmaterialsdetail(clientCode);
	}

	public ProdDTO selldetail(String clientCode) {
		
		return clientDAO.selldetail(clientCode);
	}

	public void clientupdate(ClientDTO clientDTO) {
		
		clientDAO.clientupdate(clientDTO);
		
	}

	public void clientdelete(String clientCompany) {
		
		clientDAO.clientdelete(clientCompany);
		
	}

	public List<ClientDTO> getSearch(ClientDTO clientDTO, PageDTO pageDTO) {
		
		System.out.println("ClientService getSearch****************");
		int startRow = (pageDTO.getCurrentPage() - 1) * pageDTO.getPageSize() + 1;
		// 끝나는 행번호 구하기
		int endRow = startRow + pageDTO.getPageSize() - 1;

		// 디비 startRow - 1
		pageDTO.setStartRow(startRow - 1);
		pageDTO.setEndRow(endRow);
		return clientDAO.getSearch(clientDTO, clientDTO);
	}

	public int getSearchcount(ClientDTO clientDTO) {
		// TODO Auto-generated method stub
		return 0;
	}

	public int getclientCount(PageDTO pageDTO) {
		// TODO Auto-generated method stub
		return 0;
	}

	

	
	
}
