package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.dao.ClientDAO;
import com.itwillbs.domain.ClientDTO;

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
	
}
