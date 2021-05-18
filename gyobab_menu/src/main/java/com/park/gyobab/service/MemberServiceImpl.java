package com.park.gyobab.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.park.gyobab.domain.Criteria;
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
	public void deleteMember(MemberVO vo) {
		dao.deleteMember(vo);
	}

	@Override
	public MemberVO selectMemberById(int member_id) throws Exception {
		MemberVO tmpVo = dao.selectMemberById(member_id); 
		return tmpVo;
	}

	@Override
	public MemberVO selectMemberByEmail(String member_email) throws Exception {
		MemberVO tmpVo = dao.selectMemberByEmail(member_email); 
		return tmpVo;
	}

	@Override
	public Integer selectMemberIdByEmail(String member_email) throws Exception {
		int tmpId = dao.selectMemberIdByEmail(member_email); 
		return tmpId;
	}

	@Override
	public Integer selectMemberIdByName(String member_name) throws Exception {
		int tmpId = dao.selectMemberIdByName(member_name); 
		return tmpId;
	}

	@Override
	public List<MemberVO> selectMembers(Criteria cri) throws Exception {
		List<MemberVO> list = dao.selectMembers(cri);
		return list;
	}

	@Override
	public void updateMember(MemberVO vo) {
		dao.updateMember(vo);
	}

	@Override
	public void updateMemberGrant(MemberVO vo) {
		dao.updateMemberGrant(vo);
	}

	@Override
	public Integer selectMemberCnt() throws Exception {
		int cnt = dao.selectMemberCnt(); 
		return cnt;
	}
}
