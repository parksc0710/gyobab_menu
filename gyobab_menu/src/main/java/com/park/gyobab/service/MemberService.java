package com.park.gyobab.service;

import java.util.HashMap;
import java.util.List;

import com.park.gyobab.domain.Criteria;
import com.park.gyobab.domain.MemberVO;

public interface MemberService {
	
	public void insertMember(MemberVO vo);
	
	public void deleteMember(MemberVO vo);
	
	public MemberVO selectMemberById(int member_id) throws Exception;
	
	public MemberVO selectMemberByEmail(String member_email) throws Exception;
	
	public Integer selectMemberIdByEmail(String member_email) throws Exception;
	
	public Integer selectMemberIdByName(String member_name) throws Exception;
	
	public List<MemberVO> selectMembers(Criteria cri) throws Exception;
	
	public Integer selectMemberCnt() throws Exception;
	
	public void updateMember(MemberVO vo);
	
	public void updateMemberGrant(MemberVO vo);
	
	public void updateMemberLoginDate(HashMap<String, Object> map);
}
