package com.park.gyobab.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.park.gyobab.domain.MemberVO;
import com.park.gyobab.persistence.MemberDAO;

@Service
public class MemberServiceImpl implements MemberService {

	@Inject
	private MemberDAO dao;

	@Override
	public void insertMember(MemberVO vo) {
		dao.insertMember(vo);
	}

	@Override
	public MemberVO selectMemberById(int member_id) throws Exception {
		MemberVO tmpVo = dao.selectMemberById(member_id); 
		return tmpVo;
	}

	@Override
	public MemberVO selectMemberByEmail(String member_email) throws Exception {
		// TODO Auto-generated method stub
		MemberVO tmpVo = dao.selectMemberByEmail(member_email); 
		return tmpVo;
	}

	@Override
	public Integer selectMemberIdByEmail(String member_email) throws Exception {
		// TODO Auto-generated method stub
		int tmpId = dao.selectMemberIdByEmail(member_email); 
		return tmpId;
	}


}
