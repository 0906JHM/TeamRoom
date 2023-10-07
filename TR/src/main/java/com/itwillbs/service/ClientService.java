package com.itwillbs.service;

import java.io.Console;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.dao.ClientDAO;
import com.itwillbs.domain.ClientDTO;
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

	public List<ClientDTO> getclientList() {
		return clientDAO.getclientList();
	}

	public String  getclientCode(String clientType) {
		
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
	
}
