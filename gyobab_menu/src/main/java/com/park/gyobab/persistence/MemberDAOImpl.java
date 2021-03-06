package com.park.gyobab.persistence;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.park.gyobab.domain.Criteria;
import com.park.gyobab.domain.MemberVO;

@Repository
public class MemberDAOImpl implements MemberDAO {

	@Inject
	private SqlSession sqlSession;
	
	private static final String namespace = "com.park.gyobab.MemberMapper";
	
	
	@Override
	public String getTime() {
		return sqlSession.selectOne(namespace + ".getTime");
	}

	@Override
	public void insertMember(MemberVO vo) {
		sqlSession.insert(namespace + ".insertMember", vo); 
	}
	
	@Override
	public void deleteMember(MemberVO vo) {
		sqlSession.insert(namespace + ".deleteMember", vo); 
	}

	@Override
	public MemberVO selectMemberById(int member_id) throws Exception {
		MemberVO tmpVO = (MemberVO) sqlSession.selectOne(namespace + ".selectMemberById", member_id);
		return tmpVO;
	}

	@Override
	public MemberVO selectMemberByEmail(String member_email) throws Exception {
		MemberVO tmpVO = (MemberVO) sqlSession.selectOne(namespace + ".selectMemberByEmail", member_email);
		return tmpVO;
	}
	
	@Override
	public Integer selectMemberIdByEmail(String member_email) throws Exception {
		int member_id = 0;
		MemberVO tmpVO = (MemberVO) sqlSession.selectOne(namespace + ".selectMemberIdByEmail", member_email);
		member_id = tmpVO.getMember_id();
		return member_id;
	}

	@Override
	public Integer selectMemberIdByName(String member_name) throws Exception {
		int member_id = 0;
		member_id = sqlSession.selectOne(namespace + ".selectMemberIdByName", member_name);
		return member_id;
	}

	@Override
	public List<MemberVO> selectMembers(Criteria cri) throws Exception {
		List<MemberVO> list = sqlSession.selectList(namespace + ".selectMembers", cri);
		return list;
	}

	@Override
	public void updateMember(MemberVO vo) {
		sqlSession.update(namespace + ".updateMember", vo); 
	}

	@Override
	public void updateMemberGrant(MemberVO vo) {
		sqlSession.update(namespace + ".updateMemberGrant", vo); 
	}

	@Override
	public Integer selectMemberCnt() throws Exception {
		int cnt = sqlSession.selectOne(namespace + ".selectMemberCnt");
		return cnt;
	}

	@Override
	public void updateMemberLoginDate(HashMap<String, Object> map) {
		sqlSession.update(namespace + ".updateMemberLoginDate", map); 		
	}

}
