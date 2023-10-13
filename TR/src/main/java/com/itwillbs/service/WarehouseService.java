package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.dao.WarehouseDAO;
import com.itwillbs.domain.PageDTO;
import com.itwillbs.domain.WarehouseDTO;

@Service
public class WarehouseService {
	
	@Inject
	private WarehouseDAO warehouseDAO;

	public List<WarehouseDTO> getWarehouseList(PageDTO pageDTO) {
		// TODO Auto-generated method stub
		return null;
	}

	public int getWarehouseCount(PageDTO pageDTO) {
		// TODO Auto-generated method stub
		return 0;
	}


	public void insertWarehouse(WarehouseDTO warehouseDTO) {
		// TODO Auto-generated method stub
		
	}

	public WarehouseDTO getWarehouse(String whseCode) {
		// TODO Auto-generated method stub
		return warehouseDAO.getWarehouse(whseCode);
	}

	public void updateWarehouse(WarehouseDTO warehouseDTO) {
		// TODO Auto-generated method stub
		
	}

}
