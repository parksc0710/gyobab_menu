package com.park.gyobab.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class GrantDAOImpl implements GrantDAO {
	
	@Inject
	private SqlSession sqlSession;
	
	private static final String namespace = "com.park.gyobab.GrantMapper";

	@Override
	public int selectGrantIdByName(String grantName) throws Exception {
		return sqlSession.selectOne(namespace + ".selectGrantIdByName", grantName);
	}

}
