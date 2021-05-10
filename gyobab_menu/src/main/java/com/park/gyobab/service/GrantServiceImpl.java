package com.park.gyobab.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.park.gyobab.persistence.GrantDAO;

@Service
public class GrantServiceImpl implements GrantService {
	
	@Inject
	private GrantDAO dao;

	@Override
	public int selectGrantIdByName(String grantName) throws Exception {
		return dao.selectGrantIdByName(grantName);
	}

}
