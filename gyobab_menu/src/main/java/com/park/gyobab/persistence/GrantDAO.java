package com.park.gyobab.persistence;

public interface GrantDAO {
	
	public int selectGrantIdByName(String grantName) throws Exception;
	
}
